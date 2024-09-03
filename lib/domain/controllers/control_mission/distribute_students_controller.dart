import 'dart:collection';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:custom_theme/lib.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

import '../../../Data/Models/class_desk/class_desk_res_model.dart';
import '../../../Data/Models/class_desk/class_desks_res_model.dart';
import '../../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/student_seat/student_seat_res_model.dart';
import '../../../Data/Models/student_seat/students_seats_numbers_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../app/extensions/convert_material_color_to_pdf_color_extension.dart';
import '../../../presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class DistributeStudentsController extends GetxController {
  List<StudentSeatNumberResModel> availableStudents = [];
  int availableStudentsCount = 0;
  List<int> blockedClassDesks = [];
  Map<int?, List<ClassDeskResModel>> classDeskCollection = {};
  List<ClassDeskResModel> classDesks = [];
  Map<String, int> countByGrade = {};
  ExamRoomResModel examRoomResModel = ExamRoomResModel();
  List<GradeResModel> grades = [];
  bool isLoading = false;
  bool isLoadingStudents = false;
  TextEditingController numberOfStudentsController = TextEditingController();
  int numberOfRows = 0;
  List<ValueItem> optionsGrades = [];
  List<ValueItem> optionsGradesInExamRoom = [];
  List<StudentSeatNumberResModel> removedStudentsFromExamRoom = [];
  int selectedItemGradeId = -1;
  List<StudentSeatNumberResModel> studentsSeatNumbers = [];

  void addStudentToDesk(
      {required int studentSeatNumberId, required int classDeskId}) async {
    availableStudents
            .firstWhere((element) => element.iD == studentSeatNumberId)
            .classDeskID =
        classDesks.firstWhere((classDesk) => classDesk.id == classDeskId).id;

    update();
    ResponseHandler responseHandler = ResponseHandler();
    await responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumbers}/$studentSeatNumberId',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: {
        "Class_Desk_ID": classDesks
            .firstWhere((classDesk) => classDesk.id == classDeskId)
            .id,
      },
    );
  }

  void autoGenerateCross() {
    availableStudents
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
    classDesks.sort((a, b) => a.rowNum!.compareTo(b.rowNum!));
    // Count students in each grade
    Map<int, List<StudentSeatNumberResModel>> gradeCounts =
        <int, List<StudentSeatNumberResModel>>{};
    for (StudentSeatNumberResModel student in availableStudents) {
      gradeCounts.putIfAbsent(student.gradesID!, () => []).add(student);
    }

// Create the reordered list
    List<StudentSeatNumberResModel> reOrderedList =
        <StudentSeatNumberResModel>[];
    if (gradeCounts.keys.length == 2) {
      List<StudentSeatNumberResModel> studentsFromGrade =
          gradeCounts.entries.toList()[0].value;
      List<StudentSeatNumberResModel> studentsFromAnotherGrade =
          gradeCounts.entries.toList()[1].value;
      int row = 0;
      while (row < numberOfRows) {
        int rowLength =
            classDesks.where((classDesk) => classDesk.rowNum == row).length;
        for (int i = 0; i < rowLength ~/ 2; i++) {
          if (row.isEven) {
            studentsFromGrade.isEmpty
                ? null
                : reOrderedList.add(studentsFromGrade.removeAt(0));
            studentsFromAnotherGrade.isEmpty
                ? null
                : reOrderedList.add(studentsFromAnotherGrade.removeAt(0));
          } else {
            studentsFromAnotherGrade.isEmpty
                ? null
                : reOrderedList.add(studentsFromAnotherGrade.removeAt(0));
            studentsFromGrade.isEmpty
                ? null
                : reOrderedList.add(studentsFromGrade.removeAt(0));
          }
        }
        row++;
      }
    } else if (gradeCounts.keys.length == 3) {
      List<StudentSeatNumberResModel>? maxStudents,
          secondMaxStudents,
          minStudents;
      int? maxLength;
      int? secondMaxLength;
      int? minLength;

      for (var entry in gradeCounts.entries) {
        int length = entry.value.length;

        // Update max length and corresponding list
        if (maxLength == null || length > maxLength) {
          // Move current max to second max
          secondMaxLength = maxLength;
          secondMaxStudents = maxStudents;

          // Update max length and list
          maxLength = length;
          maxStudents = entry.value;
        }
        if (secondMaxLength == null ||
            (length > secondMaxLength && length < maxLength)) {
          // Update second max length and list
          secondMaxLength = length;
          secondMaxStudents = entry.value;
        }

        // Update min length and corresponding list
        if (minLength == null || length < minLength) {
          minLength = length;
          minStudents = entry.value;
        }
      }
      int row = 0;
      while (row < numberOfRows) {
        int rowLength =
            classDesks.where((classDesk) => classDesk.rowNum == row).length;
        for (int i = 0; i < rowLength; i++) {
          if (row.isEven && i.isEven) {
            secondMaxStudents!.isEmpty
                ? null
                : reOrderedList.add(secondMaxStudents.removeAt(0));
          } else if (row.isEven && i.isOdd) {
            maxStudents!.isEmpty
                ? null
                : reOrderedList.add(maxStudents.removeAt(0));
          } else if (row.isOdd && i.isEven) {
            maxStudents!.isEmpty
                ? null
                : reOrderedList.add(maxStudents.removeAt(0));
          } else if (row.isOdd && i.isOdd) {
            minStudents!.isEmpty
                ? null
                : reOrderedList.add(minStudents.removeAt(0));
          }
        }
        row++;
      }
    } else if (gradeCounts.keys.length == 4) {
      Queue<int> gradesQueue = Queue<int>.from(gradeCounts.keys);

      while (gradesQueue.isNotEmpty) {
        int currentBlockSize = 1;
        List<StudentSeatNumberResModel> tempStudents =
            <StudentSeatNumberResModel>[];

        // Process students for the current block
        for (int i = 0; i < gradesQueue.length && currentBlockSize > 0; i++) {
          int grade = gradesQueue.removeFirst();
          List<StudentSeatNumberResModel> studentInGrade = gradeCounts[grade]!;

          if (studentInGrade.isNotEmpty) {
            int toAddCount = studentInGrade.length < currentBlockSize
                ? studentInGrade.length
                : currentBlockSize;
            tempStudents.addAll(studentInGrade.take(toAddCount));
            gradeCounts[grade] = studentInGrade.skip(toAddCount).toList();
            currentBlockSize -= toAddCount;

            if (gradeCounts[grade]!.isNotEmpty) {
              gradesQueue.addLast(grade);
            }
          }
        }

        reOrderedList.addAll(tempStudents);

        // Remove empty categories
        gradeCounts.removeWhere((key, value) => value.isEmpty);
        gradesQueue.removeWhere((grade) => !gradeCounts.containsKey(grade));
      }
    }

    // Print the reordered list
    availableStudents.assignAll(reOrderedList);
    distributeStudentsUi();
    checkStudentsSettingNextToEachOther();
  }

  void autoGenerateSimple() {
    availableStudents
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
    classDesks.sort((a, b) => a.cloumnNum!.compareTo(b.cloumnNum!));

    // Define the block size
    final int blockSize = numberOfRows;

    // Count students in each grade
    Map<int, List<StudentSeatNumberResModel>> gradeCounts =
        <int, List<StudentSeatNumberResModel>>{};
    for (StudentSeatNumberResModel student in availableStudents) {
      gradeCounts.putIfAbsent(student.gradesID!, () => []).add(student);
    }

    // Create the reordered list
    List<StudentSeatNumberResModel> reOrderedList =
        <StudentSeatNumberResModel>[];
    Queue<int> gradesQueue = Queue<int>.from(gradeCounts.keys);

    while (gradesQueue.isNotEmpty) {
      int currentBlockSize = blockSize;
      List<StudentSeatNumberResModel> tempStudents =
          <StudentSeatNumberResModel>[];

      // Process students for the current block
      for (int i = 0; i < gradesQueue.length && currentBlockSize > 0; i++) {
        int grade = gradesQueue.removeFirst();
        List<StudentSeatNumberResModel> studentInGrade = gradeCounts[grade]!;

        if (studentInGrade.isNotEmpty) {
          int toAddCount = studentInGrade.length < currentBlockSize
              ? studentInGrade.length
              : currentBlockSize;
          tempStudents.addAll(studentInGrade.take(toAddCount));
          gradeCounts[grade] = studentInGrade.skip(toAddCount).toList();
          currentBlockSize -= toAddCount;

          if (gradeCounts[grade]!.isNotEmpty) {
            gradesQueue.addLast(grade);
          }
        }
      }

      reOrderedList.addAll(tempStudents);

      // Remove empty categories
      gradeCounts.removeWhere((key, value) => value.isEmpty);
      gradesQueue.removeWhere((grade) => !gradeCounts.containsKey(grade));
    }

    // Print the reordered list
    availableStudents.assignAll(reOrderedList);

    distributeStudentsUi();
    checkStudentsSettingNextToEachOther();

// ///// 1-   map of grades students
//     Map<int, List<StudentSeatNumberResModel>> studentsByGrade =
//         availableStudents.groupListsBy((student) => student.gradesID!);

//     List<int> rows = examRoomResModel.classRoomResModel?.rows ?? [];
//     // int currentDeskCounter = 0;
//     for (int i = 0; i < rows.length; i++) {
//       List<StudentSeatNumberResModel> curerntGrade = studentsByGrade[
//           studentsByGrade.keys.toList()[i % studentsByGrade.keys.length]]!;
//       for (int j = 0; j < rows[i]; j++) {
//         ClassDeskResModel? deskModel = classDeskCollection[j]?.firstWhereOrNull(
//             (desk) => desk.cloumnNum == j && desk.rowNum == i);
//         if (deskModel != null) {
//           StudentSeatNumberResModel currentStudent = curerntGrade.first;
//           // curerntGrade[currentDeskCounter++];

//           availableStudents
//               .firstWhereOrNull((std) => std.iD == currentStudent.iD)?.classDeskID = deskModel.id;
//             curerntGrade.removeWhere((std) => std.iD == currentStudent.iD);
//         }
//       }
//       // currentDeskCounter = 0;
//     }

    // for (int i = 0; i < availableStudents.length; i++) {
    //   if (availableStudents[i].classDeskID == null) {
    //     availableStudents[i].classDeskID = availableStudents[i].classDeskID =
    //         classDesks
    //             .whereNot(
    //                 (classDesk) => blockedClassDesks.contains(classDesk.id))
    //             .whereNot((classDesk) => availableStudents
    //                 .map((student) => student.classDeskID)
    //                 .contains(classDesk.id))
    //             .firstOrNull
    //             ?.id;
    //   }
    // }

    return;
  }

  void blockClassDesk({required int classDeskId}) {
    blockedClassDesks.add(classDeskId);
    update();
  }

  bool canAddStudents() {
    return (countByGrade[selectedItemGradeId.toString()]! -
                int.parse(numberOfStudentsController.text) >=
            0) &&
        (int.parse(numberOfStudentsController.text) +
                availableStudents.length) <=
            int.parse(examRoomResModel.classRoomResModel!.maxCapacity!);
  }

  bool canRemoveStudents() {
    return availableStudents
                .where((element) => (element.gradesID == selectedItemGradeId))
                .length -
            int.parse(numberOfStudentsController.text) >=
        0;
  }

  void checkStudentsSettingNextToEachOther() {
    List<StudentSeatNumberResModel> studentsSettingNextToEachOther = [];

    // ccheck there is no students from the sae grade setting next to each other
    // use the class desk rowNum and column
    for (int i = 0; i < availableStudents.length; i++) {
      if (classDesks.firstWhereOrNull((classDesk) =>
              classDesk.id == availableStudents[i].classDeskID) !=
          null) {
        ClassDeskResModel currentClassDesk = classDesks.firstWhere(
            (classDesk) => classDesk.id == availableStudents[i].classDeskID);
        ClassDeskResModel? nextClassDesk = classDesks.firstWhereOrNull(
            (classDesk) =>
                classDesk.rowNum == currentClassDesk.rowNum &&
                classDesk.cloumnNum == currentClassDesk.cloumnNum! + 1);
        if (nextClassDesk != null) {
          StudentSeatNumberResModel? nextStudent =
              availableStudents.firstWhereOrNull(
                  (student) => student.classDeskID == nextClassDesk.id);
          if (nextStudent != null) {
            if (availableStudents[i].gradesID == nextStudent.gradesID) {
              studentsSettingNextToEachOther.addAll(
                [
                  availableStudents[i],
                  nextStudent,
                ],
              );
            }
          }
        }
      }
    }
    if (studentsSettingNextToEachOther.isNotEmpty) {
      MyAwesomeDialogue(
        title: 'Warning',
        desc:
            'Some students from the same grade will be setting next to each other. The following students will be setting next to each other: ${studentsSettingNextToEachOther.map((student) => 'name: ${student.student?.firstName} ${student.student?.secondName} ${student.student?.thirdName} grade: ${student.student?.gradeResModel?.name}').join(', ')} Are you sure you want to continue?',
        dialogType: DialogType.warning,
        btnOkOnPressed: () {
          distributeStudents();
        },
        btnCancelOnPressed: () {},
      ).showDialogue(Get.key.currentContext!);
    }
  }

  Future<void> distributeStudents() async {
    ResponseHandler responseHandler = ResponseHandler();
    responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumbers}/many',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: [
        ...availableStudents.map((element) => {
              "ID": element.iD,
              "Class_Desk_ID": element.classDeskID,
            }),
      ],
    );
    return;
  }

  void distributeStudentsUi() {
    for (int i = 0; i < availableStudents.length; i++) {
      if (availableStudents[i].classDeskID == null) {
        availableStudents[i].classDeskID = availableStudents[i].classDeskID =
            classDesks
                .whereNot(
                    (classDesk) => blockedClassDesks.contains(classDesk.id))
                .whereNot((classDesk) => availableStudents
                    .map((student) => student.classDeskID)
                    .contains(classDesk.id))
                .firstOrNull
                ?.id;
      }
    }
    update();
  }

  Future<void> exportToPdf() async {
    ByteData logoImage =
        await rootBundle.load(AssetsManager.assetsLogosNisLogo);

    final Uint8List logoImageBytes = logoImage.buffer.asUint8List();

    final pw.Document document = pw.Document(
      pageMode: PdfPageMode.fullscreen,
      title: 'Student Distribution in ${examRoomResModel.name}',
    );

    double pdfWidth = PdfPageFormat.a4.landscape.width;
    double pdfHeight = PdfPageFormat.a4.landscape.height;
    document.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Positioned(
                left: 10,
                top: 5,
                child: pw.Image(
                  pw.MemoryImage(logoImageBytes),
                  width: pdfWidth * 0.10,
                  height: pdfHeight * 0.10,
                ),
              ),
              pw.Positioned(
                left: 0,
                top: pdfHeight * 0.10,
                child: pw.Container(
                  width: pdfWidth,
                  height: pdfHeight * 0.90,
                  child: pw.Column(
                    children: [
                      pw.Container(
                        height: pdfHeight * 0.05,
                        width: pdfWidth * 0.30,
                        decoration: pw.BoxDecoration(
                          color: ColorManager.primary.toPdfColorFromValue(),
                          border: pw.Border.all(width: 1),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            'Smart Board',
                            style: pw.TextStyle(
                              color: ColorManager.white.toPdfColorFromValue(),
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          ...List.generate(
                            numberOfRows,
                            (i) {
                              return pw.Row(
                                children: [
                                  ...List.generate(
                                    classDeskCollection.entries
                                        .toList()[i]
                                        .value
                                        .length,
                                    (j) {
                                      return blockedClassDesks.contains(
                                              classDeskCollection.entries
                                                  .toList()[i]
                                                  .value[j]
                                                  .id)
                                          ? pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: pw.Column(
                                                children: [
                                                  pw.SizedBox(
                                                    height: (pdfHeight * 0.6) /
                                                        numberOfRows,
                                                  ),
                                                  pw.Container(
                                                    height:
                                                        (pdfHeight * 0.03 * 6) /
                                                            numberOfRows,
                                                    width: (pdfWidth /
                                                        classDeskCollection
                                                            .entries
                                                            .toList()[i]
                                                            .value
                                                            .length),
                                                    decoration:
                                                        pw.BoxDecoration(
                                                      border: pw.Border.all(
                                                        width: 1.5,
                                                      ),
                                                      color: ColorManager.yellow
                                                          .toPdfColorFromValue(),
                                                    ),
                                                  ),
                                                  pw.Container(
                                                    height:
                                                        (pdfHeight * 0.3 * 6) /
                                                            numberOfRows,
                                                    width:
                                                        (pdfWidth * 0.17 * 5) /
                                                            classDeskCollection
                                                                .entries
                                                                .toList()[i]
                                                                .value
                                                                .length,
                                                    decoration:
                                                        pw.BoxDecoration(
                                                      border: pw.Border.all(
                                                        width: 1.5,
                                                      ),
                                                      color: ColorManager.red
                                                          .toPdfColorFromValue(),
                                                    ),
                                                    alignment:
                                                        pw.Alignment.center,
                                                    child: pw.Text(
                                                      '${i != 0 ? i * classDeskCollection.entries.toList()[i - 1].value.length + j + 1 : i * classDeskCollection.entries.toList()[i].value.length + j + 1}',
                                                      style: pw.TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : (availableStudents
                                                  .map((element) =>
                                                      element.classDeskID)
                                                  .toList()
                                                  .contains(classDeskCollection
                                                      .entries
                                                      .toList()[i]
                                                      .value[j]
                                                      .id))
                                              ? pw.Padding(
                                                  padding: const pw
                                                      .EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                  ),
                                                  child: pw.Column(
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      pw.SizedBox(
                                                        height: (pdfHeight *
                                                                0.01 *
                                                                5) /
                                                            numberOfRows,
                                                      ),
                                                      pw.Container(
                                                        height: (pdfHeight *
                                                                0.05 *
                                                                5) /
                                                            numberOfRows,
                                                        width: (pdfWidth *
                                                                0.15 *
                                                                6) /
                                                            classDeskCollection
                                                                .entries
                                                                .toList()[i]
                                                                .value
                                                                .length,
                                                        decoration:
                                                            pw.BoxDecoration(
                                                          border: pw.Border.all(
                                                            width: 1.5,
                                                          ),
                                                          color: ColorManager
                                                              .yellow
                                                              .toPdfColorFromValue(),
                                                        ),
                                                        child: pw.Center(
                                                          child: pw.Text(
                                                            '${availableStudents.firstWhere((element) => element.classDeskID == classDeskCollection.entries.toList()[i].value[j].id).seatNumber}',
                                                            style: pw.TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      pw.Container(
                                                        height: (pdfHeight *
                                                                0.092 *
                                                                5) /
                                                            numberOfRows,
                                                        width: (pdfWidth *
                                                                0.15 *
                                                                6) /
                                                            classDeskCollection
                                                                .entries
                                                                .toList()[i]
                                                                .value
                                                                .length,
                                                        decoration:
                                                            pw.BoxDecoration(
                                                          border: pw.Border.all(
                                                            width: 1.5,
                                                          ),
                                                          color: ColorManager
                                                              .gradesColor[availableStudents
                                                                  .firstWhere((element) =>
                                                                      element
                                                                          .classDeskID ==
                                                                      classDeskCollection
                                                                          .entries
                                                                          .toList()[
                                                                              i]
                                                                          .value[
                                                                              j]
                                                                          .id)
                                                                  .student!
                                                                  .gradeResModel!
                                                                  .name!]!
                                                              .toPdfColorFromValue(),
                                                        ),
                                                        child: pw.Padding(
                                                          padding: pw.EdgeInsets
                                                              .symmetric(
                                                            horizontal: (pdfWidth *
                                                                    0.01 *
                                                                    6) /
                                                                classDeskCollection
                                                                    .entries
                                                                    .toList()[i]
                                                                    .value
                                                                    .length,
                                                            vertical:
                                                                (pdfHeight *
                                                                        0.01 *
                                                                        5) /
                                                                    numberOfRows,
                                                          ),
                                                          child: pw.Column(
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                '${availableStudents.firstWhere((element) => element.classDeskID == classDeskCollection.entries.toList()[i].value[j].id).student?.firstName!} ${availableStudents.firstWhere((element) => element.classDeskID == classDeskCollection.entries.toList()[i].value[j].id).student?.secondName!} ${availableStudents.firstWhere((element) => element.classDeskID == classDeskCollection.entries.toList()[i].value[j].id).student?.thirdName!}',
                                                                style: pw
                                                                    .TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                              pw.Text(
                                                                'Grade: ${availableStudents.firstWhere((element) => element.classDeskID == classDeskCollection.entries.toList()[i].value[j].id).student?.gradeResModel?.name}',
                                                                style: const pw
                                                                    .TextStyle(
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                              pw.Text(
                                                                'Class: ${availableStudents.firstWhere((element) => element.classDeskID == classDeskCollection.entries.toList()[i].value[j].id).student?.classRoomResModel?.name}',
                                                                style: const pw
                                                                    .TextStyle(
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : pw.Padding(
                                                  padding: const pw
                                                      .EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: pw.Column(
                                                    children: [
                                                      pw.SizedBox(
                                                        height: (pdfHeight *
                                                                0.01 *
                                                                5) /
                                                            numberOfRows,
                                                      ),
                                                      pw.Container(
                                                        height: (pdfHeight *
                                                                0.05 *
                                                                5) /
                                                            numberOfRows,
                                                        width: (pdfWidth *
                                                                0.15 *
                                                                6) /
                                                            classDeskCollection
                                                                .entries
                                                                .toList()[i]
                                                                .value
                                                                .length,
                                                        decoration:
                                                            pw.BoxDecoration(
                                                          border: pw.Border.all(
                                                            width: 1.5,
                                                          ),
                                                          color: ColorManager
                                                              .yellow
                                                              .toPdfColorFromValue(),
                                                        ),
                                                        child: pw.Center(
                                                          child: pw.Text(
                                                            '${i != 0 ? i * classDeskCollection.entries.toList()[i - 1].value.length + j + 1 : i * classDeskCollection.entries.toList()[i].value.length + j + 1}',
                                                            style: pw.TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      pw.Container(
                                                        height: (pdfHeight *
                                                                0.05 *
                                                                5) /
                                                            numberOfRows,
                                                        width: (pdfWidth *
                                                                0.15 *
                                                                6) /
                                                            classDeskCollection
                                                                .entries
                                                                .toList()[i]
                                                                .value
                                                                .length,
                                                        decoration:
                                                            pw.BoxDecoration(
                                                          border: pw.Border.all(
                                                            width: 1.5,
                                                          ),
                                                          color: ColorManager
                                                              .greyA8
                                                              .toPdfColorFromValue(),
                                                        ),
                                                        alignment:
                                                            pw.Alignment.center,
                                                        child: pw.Text(
                                                          '${i != 0 ? i * classDeskCollection.entries.toList()[i - 1].value.length + j + 1 : i * classDeskCollection.entries.toList()[i].value.length + j + 1}',
                                                          style: pw.TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      pw.SizedBox(height: pdfHeight * 0.01),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Row(
                            children: List.generate(
                              countByGrade.keys.length,
                              (index) => pw.Padding(
                                padding: pw.EdgeInsets.symmetric(
                                  horizontal: (pdfWidth * 0.005 * 6) /
                                      countByGrade.keys.length,
                                ),
                                child: availableStudents
                                        .where((element) =>
                                            element.gradesID ==
                                            grades
                                                .firstWhere((element) =>
                                                    element.iD.toString() ==
                                                    countByGrade.keys
                                                        .toList()[index])
                                                .iD)
                                        .isEmpty
                                    ? pw.SizedBox.shrink()
                                    : pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Container(
                                            height: (pdfHeight * 0.030 * 5) /
                                                numberOfRows,
                                            width: (pdfWidth * 0.17 * 6) /
                                                countByGrade.keys.length,
                                            alignment: pw.Alignment.center,
                                            decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                width: 1.5,
                                              ),
                                              color: ColorManager.yellow
                                                  .toPdfColorFromValue(),
                                            ),
                                            child: pw.Text(
                                              '${grades.firstWhere((element) => element.iD.toString() == countByGrade.keys.toList()[index]).name}',
                                              style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            height: (pdfHeight * 0.035 * 5) /
                                                numberOfRows,
                                            width: (pdfWidth * 0.17 * 6) /
                                                countByGrade.keys.length,
                                            alignment: pw.Alignment.center,
                                            decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                width: 1.5,
                                              ),
                                              color: ColorManager
                                                  .gradesColor[grades
                                                      .firstWhere((element) =>
                                                          element.iD
                                                              .toString() ==
                                                          countByGrade.keys
                                                              .toList()[index])
                                                      .name]!
                                                  .toPdfColorFromValue(),
                                            ),
                                            child: pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.symmetric(
                                                horizontal: 5,
                                                vertical: 5,
                                              ),
                                              child: pw.Text(
                                                '${availableStudents.where((element) => element.gradesID == grades.firstWhere((element) => element.iD.toString() == countByGrade.keys.toList()[index]).iD).length}',
                                                style: pw.TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    final Uint8List bytes = await document.save();
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute(
          'download', 'student distribute of ${examRoomResModel.name}.pdf')
      ..click();

    MyFlashBar.showSuccess(
      "PDF file exported successfully.",
      'success',
    ).show(Get.key.currentContext!);
  }

  Future<bool> finish() async {
    return true;
  }

  void getAvailableStudents() async {
    availableStudents.addAll(studentsSeatNumbers
        .where((element) => (element.gradesID == selectedItemGradeId))
        .take(int.parse(numberOfStudentsController.text)));

    ResponseHandler responseHandler = ResponseHandler();
    await responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumbers}/many',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: availableStudents
          .map((e) => {
                "ID": e.iD,
                "Exam_Room_ID": examRoomResModel.id,
                "Class_Desk_ID": e.classDeskID,
              })
          .toList(),
    );

    studentsSeatNumbers
        .removeWhere((element) => availableStudents.contains(element));
    removedStudentsFromExamRoom
        .removeWhere((element) => availableStudents.contains(element));
    availableStudents
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort(
        (a, b) => a.seatNumber!.compareTo(b.seatNumber!),
      );
    availableStudentsCount -= int.parse(numberOfStudentsController.text);
    countByGrade[selectedItemGradeId.toString()] =
        countByGrade[selectedItemGradeId.toString()]! -
            int.parse(numberOfStudentsController.text);
    optionsGradesInExamRoom.contains(ValueItem(
            label: grades
                .firstWhere((element) => element.iD == selectedItemGradeId)
                .name!,
            value: selectedItemGradeId))
        ? null
        : optionsGradesInExamRoom.add(ValueItem(
            label: grades
                .firstWhere((element) => element.iD == selectedItemGradeId)
                .name!,
            value: selectedItemGradeId));
    numberOfStudentsController.clear();
    update();
    return;
  }

  Future<void> getClassDesks() async {
    ResponseHandler<ClassDesksResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassDesksResModel> response =
        await responseHandler.getResponse(
      path:
          '${SchoolsLinks.classDesks}/class/${examRoomResModel.schoolClassID}',
      converter: ClassDesksResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        classDesks = r.data!;
        classDeskCollection = classDesks.groupListsBy(
          (e) => e.rowNum,
        );
        numberOfRows = classDeskCollection.length;
      },
    );
    update();
    return;
  }

  Future<void> getExamRoom() async {
    examRoomResModel = examRoomResModel.id == null &&
            Hive.box('ExamRoom').containsKey('examRoomResModel')
        ? ExamRoomResModel.fromJson(
            json.decode(
              Hive.box('ExamRoom').get('examRoomResModel'),
            ),
          )
        : ExamRoomResModel();
    update();
  }

  Future<bool> getGradesBySchoolId() async {
    bool gotData = false;
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    Either<Failure, GradesResModel> response =
        await responseHandler.getResponse(
      path: GradeLinks.gradesSchools,
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((l) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      gotData = false;
    }, (r) {
      grades = r.data!;
      gotData = true;
    });

    return gotData;
  }

  Future<bool> getStudentsSeatNumbers() async {
    isLoading = true;
    update();
    bool gotData = false;

    ResponseHandler<StudentsSeatsNumbersResModel> responseHandler =
        ResponseHandler();

    Either<Failure, StudentsSeatsNumbersResModel> response =
        await responseHandler.getResponse(
      path:
          '${StudentsLinks.studentSeatNumbersControlMission}/${examRoomResModel.controlMissionID}',
      converter: StudentsSeatsNumbersResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isLoading = false;
        gotData = false;
        update();
      },
      (r) {
        studentsSeatNumbers = r.studentSeatNumbers!
          ..removeWhere((element) =>
              element.examRoomID != null &&
              element.examRoomID != examRoomResModel.id);
        optionsGrades = studentsSeatNumbers
            .map(
              (e) => ValueItem(
                label: grades.firstWhere((g) => g.iD == e.gradesID).name!,
                value: e.gradesID!,
              ),
            )
            .toSet()
            .toList();
        availableStudents
          ..assignAll(studentsSeatNumbers
              .where((element) => element.examRoomID == examRoomResModel.id))
          ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
          ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
        studentsSeatNumbers
          ..removeWhere((element) => element.examRoomID == examRoomResModel.id)
          ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
          ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
        availableStudentsCount =
            int.parse(examRoomResModel.classRoomResModel!.maxCapacity!) -
                availableStudents.length;
        optionsGradesInExamRoom.assignAll(availableStudents
            .map(
              (e) => ValueItem(
                label: grades.firstWhere((g) => g.iD == e.gradesID).name!,
                value: e.gradesID!,
              ),
            )
            .toSet()
            .toList());
        Map<int?, List<StudentSeatNumberResModel>> gradesCollection =
            studentsSeatNumbers
                .where((e) => (e.examRoomID == null))
                .groupListsBy(
                  (e) => e.gradesID,
                );

        gradesCollection.forEach((key, value) {
          countByGrade[key.toString()] = value.length;
        });
        for (var element in availableStudents
            .groupListsBy((e) => e.gradesID)
            .keys
            .where((key) => countByGrade[key.toString()] == null)
            .toSet()) {
          countByGrade[element.toString()] = 0;
        }
        isLoading = false;
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading = true;
    update();
    await Future.wait([
      getExamRoom().then((_) async => getGradesBySchoolId()).then((_) async {
        await Future.wait([
          getStudentsSeatNumbers(),
          getClassDesks(),
        ]);
      }),
    ]);
    isLoading = false;
    update();
  }

  void removeAllFromDesks() {
    for (var element in availableStudents) {
      element.classDeskID = null;
    }

    ResponseHandler responseHandler = ResponseHandler();

    responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumbers}/many',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: [
        ...availableStudents.map((element) => {
              "ID": element.iD,
              "Class_Desk_ID": null,
            }),
      ],
    );

    update();
    return;
  }

  void removeStudentFromDesk({required int studentSeatNumberId}) {
    availableStudents
        .firstWhere((element) => element.iD == studentSeatNumberId)
        .classDeskID = null;
    update();

    ResponseHandler responseHandler = ResponseHandler();
    responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumbers}/$studentSeatNumberId',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: {
        "Class_Desk_ID": null,
      },
    );
    return;
  }

  void removeStudentFromExamRoom({required int studentSeatNumberId}) {
    studentsSeatNumbers
      ..add(
        availableStudents
            .firstWhere((element) => element.iD == studentSeatNumberId)
          ..classDeskID = null
          ..examRoomID = null,
      )
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort(
        (a, b) => a.seatNumber!.compareTo(b.seatNumber!),
      );
    ++availableStudentsCount;
    countByGrade[availableStudents
        .firstWhere((e) => e.iD == studentSeatNumberId)
        .gradesID
        .toString()] = countByGrade[availableStudents
            .firstWhere((e) => e.iD == studentSeatNumberId)
            .gradesID
            .toString()]! +
        1;
    removedStudentsFromExamRoom.add(
      availableStudents
          .firstWhere((element) => element.iD == studentSeatNumberId),
    );
    availableStudents
      ..removeWhere((element) => (element.iD == studentSeatNumberId))
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort(
        (a, b) => a.seatNumber!.compareTo(b.seatNumber!),
      );
    availableStudents
            .where((element) => (element.gradesID == selectedItemGradeId))
            .isEmpty
        ? optionsGradesInExamRoom
            .removeWhere((element) => (element.value == selectedItemGradeId))
        : null;
    update();

    ResponseHandler responseHandler = ResponseHandler();

    responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumbers}/$studentSeatNumberId',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: {
        "Exam_Room_ID": null,
        "Class_Desk_ID": null,
      },
    );

    return;
  }

  void removeStudentsFromExamRoom() {
    List<StudentSeatNumberResModel> removedStudents = availableStudents.reversed
        .where((element) => (element.gradesID == selectedItemGradeId))
        .take(int.parse(numberOfStudentsController.text))
        .toList();
    studentsSeatNumbers.addAll(
      removedStudents,
    );
    removedStudentsFromExamRoom
      ..addAll(removedStudents)
      ..toSet();

    studentsSeatNumbers
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));

    availableStudents
      ..removeWhere((element) => (studentsSeatNumbers.contains(element)))
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort(
        (a, b) => a.seatNumber!.compareTo(b.seatNumber!),
      );
    availableStudentsCount += int.parse(numberOfStudentsController.text);
    countByGrade[selectedItemGradeId.toString()] =
        countByGrade[selectedItemGradeId.toString()]! +
            int.parse(numberOfStudentsController.text);
    availableStudents
            .where((element) => (element.gradesID == selectedItemGradeId))
            .isEmpty
        ? optionsGradesInExamRoom
            .removeWhere((element) => (element.value == selectedItemGradeId))
        : null;
    numberOfStudentsController.clear();
    update();

    ResponseHandler responseHandler = ResponseHandler();

    responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumbers}/many',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: removedStudents
          .map((e) => {
                "ID": e.iD,
                "Exam_Room_ID": null,
                "Class_Desk_ID": null,
              })
          .toList(),
    );
  }

  Future<void> saveExamRoom(ExamRoomResModel examRoomResModel) async {
    this.examRoomResModel = examRoomResModel;
    update();
    Hive.box('ExamRoom')
        .put('examRoomResModel', json.encode(examRoomResModel.toJson()));
  }

  void unBlockClassDesk({required int classDeskId}) {
    blockedClassDesks.remove(classDeskId);
    update();
  }
}
