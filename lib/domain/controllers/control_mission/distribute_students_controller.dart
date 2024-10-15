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
import '../../../presentation/resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class DistributeStudentsController extends GetxController {
  Map<String, int> numberOfStudentsInClasses = {};
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
  int numberOfRows = 0;
  TextEditingController numberOfStudentsController = TextEditingController();
  List<ValueItem> optionsGrades = [];
  List<ValueItem> optionsClasses = [];
  List<ValueItem> optionsGradesInExamRoom = [];
  List<StudentSeatNumberResModel> removedStudentsFromExamRoom = [];
  int selectedItemGradeId = -1;
  int selectedItemClassId = -1;
  List<StudentSeatNumberResModel> studentsSeatNumbers = [];
  List<StudentSeatNumberResModel> studentsSettingNextToEachOther = [];

  /// Adds a student to a desk in the database with the given [studentSeatNumberId]
  /// and [classDeskId].
  ///
  /// The function will update the UI to show that the student has been added to
  /// the desk.
  ///
  /// The function will also update the student's class desk ID in the database.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the failure message.
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

// Backtracking function
  /// A function that assigns students to seats in the exam room with the given parameters and returns a boolean indicating whether the assignment was successful.
  //
  /// The function takes the following parameters:
  //
  /// - [availableStudents]: A list of students which are available to be assigned to seats in the exam room.
  //
  /// The function will return a boolean indicating whether the assignment was successful.
  //
  /// The function will also update the UI to show that the students have been assigned to seats in the exam room.
  bool assign() {
    for (var element in availableStudents) {
      element.classDeskID = null;
    }
    // Step 2: Group availableStudents by GradeId and sort within each GradeId
    Map<int, List<StudentSeatNumberResModel>> groupedItems = {};
    for (var item in availableStudents) {
      groupedItems.putIfAbsent(item.gradesID!, () => []).add(item);
    }
    // Step 2: Create a final sorted list maintaining distribution
    List<StudentSeatNumberResModel> sortedItems = [];

    // Create a list of availableStudents based on their keys
    List<int> gradesIds = groupedItems.keys.toList();

    while (true) {
      bool addedItem = false;

      // Sort availableStudents based on the current number of items left
      gradesIds.sort((a, b) {
        return (groupedItems[b]?.length ?? 0)
            .compareTo(groupedItems[a]?.length ?? 0);
      });

      for (var gradesID in gradesIds) {
        if (groupedItems[gradesID]?.isNotEmpty ?? false) {
          sortedItems.add(groupedItems[gradesID]!.removeAt(0));
          addedItem = true;
          // If you want to limit how many times you take from each GradeId, you can add logic here
        }
      }

      // Break the loop if no items were added
      if (!addedItem) break;
    }

    availableStudents.assignAll(sortedItems);
    classDesks.sort((a, b) => a.rowNum!.compareTo(b.rowNum!));
    for (var student in availableStudents) {
      if (student.classDeskID == null) {
        for (var classDesk in classDesks) {
          if (!availableStudents
                  .map((student) => student.classDeskID)
                  .contains(classDesk.id) &&
              !blockedClassDesks.contains(classDesk.id)) {
            student.classDeskID = classDesk.id;
            if (!checkStudentsSettingNextToEachOther(checkVertical: true)) {
              break;
            }
          }
        }
      }
    }
    return !checkStudentsSettingNextToEachOther(checkVertical: true);
  }

  /// This function is used to automatically distribute the students to class desks.
  /// The auto distribution is done in the following order:
  /// 1. If there are only two grades, distribute the students in a row-column order.
  /// 2. If there are three grades, distribute the students in a row-column order.
  /// 3. If there are four grades, distribute the students in a row-column order.
  /// 4. If there are more than four grades, distribute the students in a row-column order
  ///    with a block size of one.
  /// If the auto distribution is not possible, show an error message.
  ///
  void autoGenerate() {
    // Create the reordered list
    List<StudentSeatNumberResModel> reOrderedList =
        <StudentSeatNumberResModel>[];
    // Count students in each grade
    Map<int, List<StudentSeatNumberResModel>> gradeCounts =
        <int, List<StudentSeatNumberResModel>>{};
    for (StudentSeatNumberResModel student in availableStudents) {
      gradeCounts.putIfAbsent(student.gradesID!, () => []).add(student);
    }

    if (assign()) {
      update();
      distributeStudents();
      return;
    } else if (gradeCounts.keys.length == 2) {
      for (var element in availableStudents) {
        element.classDeskID = null;
      }
      availableStudents
        ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
        ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
      classDesks.sort((a, b) => a.rowNum!.compareTo(b.rowNum!));
      reOrderedList.clear();
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
      availableStudents.assignAll(reOrderedList);
      distributeStudentsUi();
      if (!checkStudentsSettingNextToEachOther()) {
        distributeStudents();
        return;
      }
    } else if (gradeCounts.keys.length == 3) {
      () {
        for (var element in availableStudents) {
          element.classDeskID = null;
        }
        availableStudents
          ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
          ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
        classDesks.sort((a, b) => a.rowNum!.compareTo(b.rowNum!));
        reOrderedList.clear();
        List<StudentSeatNumberResModel> maxStudents = [],
            secondMaxStudents = [],
            minStudents = [];
        List<int> grades = gradeCounts.keys.toList()
          ..sort((a, b) => a.compareTo(b));
        maxStudents.assignAll(gradeCounts[grades[0]]!);
        secondMaxStudents.assignAll(gradeCounts[grades[1]]!);
        minStudents.assignAll(gradeCounts[grades[2]]!);
        int row = 0;
        while (row < numberOfRows) {
          int rowLength =
              classDesks.where((classDesk) => classDesk.rowNum == row).length;
          for (int i = 0; i < rowLength; i++) {
            if (row.isEven && i.isEven) {
              secondMaxStudents.isEmpty
                  ? maxStudents.isEmpty
                      ? minStudents.isEmpty
                          ? null
                          : reOrderedList.add(minStudents.removeAt(0))
                      : reOrderedList.add(maxStudents.removeAt(0))
                  : reOrderedList.add(secondMaxStudents.removeAt(0));
            } else if (row.isEven && i.isOdd) {
              maxStudents.isEmpty
                  ? secondMaxStudents.isEmpty
                      ? minStudents.isEmpty
                          ? null
                          : reOrderedList.add(minStudents.removeAt(0))
                      : reOrderedList.add(secondMaxStudents.removeAt(0))
                  : reOrderedList.add(maxStudents.removeAt(0));
            } else if (row.isOdd && i.isEven) {
              maxStudents.isEmpty
                  ? secondMaxStudents.isEmpty
                      ? minStudents.isEmpty
                          ? null
                          : reOrderedList.add(minStudents.removeAt(0))
                      : reOrderedList.add(secondMaxStudents.removeAt(0))
                  : reOrderedList.add(maxStudents.removeAt(0));
            } else if (row.isOdd && i.isOdd) {
              minStudents.isEmpty
                  ? maxStudents.isEmpty
                      ? secondMaxStudents.isEmpty
                          ? null
                          : reOrderedList.add(secondMaxStudents.removeAt(0))
                      : reOrderedList.add(maxStudents.removeAt(0))
                  : reOrderedList.add(minStudents.removeAt(0));
            }
          }
          row++;
        }
        availableStudents.assignAll(reOrderedList);
        distributeStudentsUi();
      }();
      if (!checkStudentsSettingNextToEachOther(checkVertical: true)) {
        distributeStudents();
        return;
      }
      () {
        for (var element in availableStudents) {
          element.classDeskID = null;
        }
        availableStudents
          ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
          ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
        classDesks.sort((a, b) => a.rowNum!.compareTo(b.rowNum!));
        reOrderedList.clear();
        List<StudentSeatNumberResModel> maxStudents = [],
            secondMaxStudents = [],
            minStudents = [];
        List<int> grades = gradeCounts.keys.toList()
          ..sort((a, b) => a.compareTo(b));
        maxStudents.assignAll(gradeCounts[grades[0]]!);
        secondMaxStudents.assignAll(gradeCounts[grades[1]]!);
        minStudents.assignAll(gradeCounts[grades[2]]!);
        int row = 0;
        while (row < numberOfRows) {
          int rowLength =
              classDesks.where((classDesk) => classDesk.rowNum == row).length;
          for (int i = 0; i < rowLength; i++) {
            if ((row % 3 == 0 && i % 3 == 0) ||
                (row % 3 == 1 && i % 3 == 1) ||
                (row % 3 == 2 && i % 3 == 2)) {
              maxStudents.isNotEmpty
                  ? reOrderedList.add(maxStudents.removeAt(0))
                  : secondMaxStudents.isNotEmpty
                      ? reOrderedList.add(secondMaxStudents.removeAt(0))
                      : minStudents.isNotEmpty
                          ? reOrderedList.add(minStudents.removeAt(0))
                          : null;
            } else if ((row % 3 == 0 && i % 3 == 2) ||
                (row % 3 == 1 && i % 3 == 0) ||
                (row % 3 == 2 && i % 3 == 1)) {
              minStudents.isNotEmpty
                  ? reOrderedList.add(minStudents.removeAt(0))
                  : maxStudents.isNotEmpty
                      ? reOrderedList.add(maxStudents.removeAt(0))
                      : secondMaxStudents.isNotEmpty
                          ? reOrderedList.add(secondMaxStudents.removeAt(0))
                          : null;
            } else if ((row % 3 == 0 && i % 3 == 1) ||
                (row % 3 == 1 && i % 3 == 2) ||
                (row % 3 == 2 && i % 3 == 0)) {
              secondMaxStudents.isNotEmpty
                  ? reOrderedList.add(secondMaxStudents.removeAt(0))
                  : minStudents.isNotEmpty
                      ? reOrderedList.add(minStudents.removeAt(0))
                      : maxStudents.isNotEmpty
                          ? reOrderedList.add(maxStudents.removeAt(0))
                          : null;
            }
          }
          row++;
        }
        availableStudents.assignAll(reOrderedList);
        distributeStudentsUi();
      }();
      if (!checkStudentsSettingNextToEachOther(checkVertical: true)) {
        distributeStudents();
        return;
      }
      () {
        reOrderedList.clear();
        for (var element in availableStudents) {
          element.classDeskID = null;
        }
        availableStudents
          ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
          ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
        classDesks.sort((a, b) => a.rowNum!.compareTo(b.rowNum!));

        List<StudentSeatNumberResModel> maxStudents = [],
            secondMaxStudents = [],
            minStudents = [];
        List<int> grades = gradeCounts.keys.toList()
          ..sort((a, b) => a.compareTo(b));
        maxStudents.assignAll(gradeCounts[grades[0]]!);
        secondMaxStudents.assignAll(gradeCounts[grades[1]]!);
        minStudents.assignAll(gradeCounts[grades[2]]!);
        int row = 0;
        while (row < numberOfRows) {
          int rowLength =
              classDesks.where((classDesk) => classDesk.rowNum == row).length;
          for (int i = 0; i < rowLength; i++) {
            if (row % 3 == 0) {
              (maxStudents.length >= secondMaxStudents.length) &&
                      (maxStudents.length >= minStudents.length) &&
                      (maxStudents.isNotEmpty)
                  ? reOrderedList.add(maxStudents.removeAt(0))
                  : secondMaxStudents.isNotEmpty &&
                          secondMaxStudents.length >= minStudents.length
                      ? reOrderedList.add(secondMaxStudents.removeAt(0))
                      : minStudents.isNotEmpty
                          ? reOrderedList.add(minStudents.removeAt(0))
                          : null;
            } else if (row % 3 == 1) {
              (minStudents.length >= maxStudents.length) &&
                      (minStudents.length >= secondMaxStudents.length) &&
                      (minStudents.isNotEmpty)
                  ? reOrderedList.add(minStudents.removeAt(0))
                  : maxStudents.isNotEmpty &&
                          maxStudents.length >= secondMaxStudents.length
                      ? reOrderedList.add(maxStudents.removeAt(0))
                      : secondMaxStudents.isNotEmpty
                          ? reOrderedList.add(secondMaxStudents.removeAt(0))
                          : null;
            } else if (row % 3 == 2) {
              (secondMaxStudents.length >= maxStudents.length) &&
                      (secondMaxStudents.length >= minStudents.length) &&
                      (secondMaxStudents.isNotEmpty)
                  ? reOrderedList.add(secondMaxStudents.removeAt(0))
                  : minStudents.isNotEmpty &&
                          minStudents.length >= maxStudents.length
                      ? reOrderedList.add(minStudents.removeAt(0))
                      : maxStudents.isNotEmpty
                          ? reOrderedList.add(maxStudents.removeAt(0))
                          : null;
            }
          }
          row++;
        }
        availableStudents.assignAll(reOrderedList);
        distributeStudentsUi();
      }();
      if (!checkStudentsSettingNextToEachOther(checkVertical: true)) {
        distributeStudents();
        return;
      }
    } else if (gradeCounts.keys.length >= 4) {
      reOrderedList.clear();
      for (var element in availableStudents) {
        element.classDeskID = null;
      }
      availableStudents
        ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
        ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
      classDesks.sort((a, b) => a.rowNum!.compareTo(b.rowNum!));

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

        gradeCounts.removeWhere((key, value) => value.isEmpty);
        gradesQueue.removeWhere((grade) => !gradeCounts.containsKey(grade));
      }
      availableStudents.assignAll(reOrderedList);
      distributeStudentsUi();
      if (!checkStudentsSettingNextToEachOther()) {
        distributeStudents();
        return;
      }
    }
    distributeStudentsUi();
    MyAwesomeDialogue(
      title: 'Error',
      desc:
          'You can not automatically generate the students. Please manually distribute the students.',
      dialogType: DialogType.error,
      btnOkOnPressed: () {},
      btnCancelOnPressed: () {},
    ).showDialogue(Get.key.currentContext!);
  }

  /// This function is used to generate the distribution of the students in
  /// the classroom in a cross pattern. It takes the available students and
  /// class desks as input and assigns the students to the class desks in
  /// such a way that students from the same grade will not be sitting next
  /// to each other. The function returns a list of students that are
  /// assigned to the class desks. If the number of grades is greater than
  /// 4, the function will return an error dialogue. If the number of grades
  /// is 3, the function will return a warning dialogue if there are some
  /// students from the same grade that will be sitting next to each other.
  /// The user can choose to continue or cancel the distribution. If the
  /// user chooses to continue, the function will distribute the students
  /// in a cross pattern. If the user chooses to cancel, the function will
  /// return and the distribution will not be done.
  void autoGenerateCross() {
    for (var element in availableStudents) {
      element.classDeskID = null;
    }
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
      List<int> grades = gradeCounts.keys.toList()
        ..sort((a, b) => a.compareTo(b));
      maxStudents = gradeCounts[grades[0]]!;
      secondMaxStudents = gradeCounts[grades[1]]!;
      minStudents = gradeCounts[grades[2]]!;
      int row = 0;
      while (row < numberOfRows) {
        int rowLength =
            classDesks.where((classDesk) => classDesk.rowNum == row).length;
        for (int i = 0; i < rowLength; i++) {
          if (row % 3 == 0) {
            (maxStudents.length >= secondMaxStudents.length) &&
                    (maxStudents.length >= minStudents.length) &&
                    (maxStudents.isNotEmpty)
                ? reOrderedList.add(maxStudents.removeAt(0))
                : secondMaxStudents.isNotEmpty &&
                        secondMaxStudents.length >= minStudents.length
                    ? reOrderedList.add(secondMaxStudents.removeAt(0))
                    : minStudents.isNotEmpty
                        ? reOrderedList.add(minStudents.removeAt(0))
                        : null;
          } else if (row % 3 == 1) {
            (minStudents.length >= maxStudents.length) &&
                    (minStudents.length >= secondMaxStudents.length) &&
                    (minStudents.isNotEmpty)
                ? reOrderedList.add(minStudents.removeAt(0))
                : maxStudents.isNotEmpty &&
                        maxStudents.length >= secondMaxStudents.length
                    ? reOrderedList.add(maxStudents.removeAt(0))
                    : secondMaxStudents.isNotEmpty
                        ? reOrderedList.add(secondMaxStudents.removeAt(0))
                        : null;
          } else if (row % 3 == 2) {
            (secondMaxStudents.length >= maxStudents.length) &&
                    (secondMaxStudents.length >= minStudents.length) &&
                    (secondMaxStudents.isNotEmpty)
                ? reOrderedList.add(secondMaxStudents.removeAt(0))
                : minStudents.isNotEmpty &&
                        minStudents.length >= maxStudents.length
                    ? reOrderedList.add(minStudents.removeAt(0))
                    : maxStudents.isNotEmpty
                        ? reOrderedList.add(maxStudents.removeAt(0))
                        : null;
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

        gradeCounts.removeWhere((key, value) => value.isEmpty);
        gradesQueue.removeWhere((grade) => !gradeCounts.containsKey(grade));
      }
    } else if (gradeCounts.keys.length > 4) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Couldn\'t generate for more than three grades',
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      return;
    } else {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Couldn\'t generate one grade',
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      return;
    }

    availableStudents.assignAll(reOrderedList);
    distributeStudentsUi();
    if (!checkStudentsSettingNextToEachOther()) {
      distributeStudents();
      return;
    } else {
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
    return;
  }

  /// A simple algorithm to auto-generate the distribution of students in the exam room.
  ///
  /// This algorithm works by sorting the students in each grade in ascending order of their seat numbers.
  /// It then assigns the students in each grade to the available class desks in order, filling the desks column by column.
  /// The algorithm stops when it has assigned all the students to class desks, or when it runs out of class desks.
  ///
  /// The algorithm then calls [distributeStudentsUi] to update the UI, and checks if any students from the same grade are setting next to each other.
  /// If they are, it shows a warning dialogue to the user asking if they want to continue. If the user chooses to continue, it calls [distributeStudents].
  ///
  /// This algorithm is much simpler than the other auto-generate algorithms, and does not guarantee to find the best solution.
  /// It is intended for use when the other algorithms are too slow or are not finding a solution.
  void autoGenerateSimple() {
    for (var element in availableStudents) {
      element.classDeskID = null;
    }
    availableStudents
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
    classDesks.sort((a, b) => a.columnNum!.compareTo(b.columnNum!));
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

      gradeCounts.removeWhere((key, value) => value.isEmpty);
      gradesQueue.removeWhere((grade) => !gradeCounts.containsKey(grade));
    }

    availableStudents.assignAll(reOrderedList);

    distributeStudentsUi();
    if (!checkStudentsSettingNextToEachOther()) {
      distributeStudents();
      return;
    } else {
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
    return;
  }

  /// Blocks a class desk from being used to seat a student.
  ///
  /// The [classDeskId] is the id of the class desk to be blocked.
  ///
  /// The function adds the [classDeskId] to the [blockedClassDesks] list and calls [update] to notify the UI of the change.
  void blockClassDesk({required int classDeskId}) {
    blockedClassDesks.add(classDeskId);
    update();
  }

  /// Checks if the number of students to be added is valid.
  ///
  /// If [selectedItemClassId] is not -1, the function checks if the number of students
  /// in the selected class and grade is greater or equal to the number of students to be
  /// added. If the number is valid, the function also checks if the total number of students
  /// in the exam room after adding the new students is less than or equal to the maximum
  /// capacity of the exam room.
  ///
  /// If [selectedItemClassId] is -1, the function checks if the number of students
  /// in the selected grade is greater or equal to the number of students to be
  /// added. If the number is valid, the function also checks if the total number of students
  /// in the exam room after adding the new students is less than or equal to the maximum
  /// capacity of the exam room.
  ///
  /// The function returns true if the number of students to be added is valid, and false
  /// otherwise.
  bool canAddStudents() {
    if (selectedItemClassId != -1) {
      return (studentsSeatNumbers
                      .where((element) =>
                          (element.gradesID == selectedItemGradeId) &&
                          element.student!.classRoomResModel!.iD ==
                              selectedItemClassId)
                      .length -
                  int.parse(numberOfStudentsController.text) >=
              0) &&
          (int.parse(numberOfStudentsController.text) +
                  availableStudents.length) <=
              int.parse(examRoomResModel.classRoomResModel!.maxCapacity!);
    }
    return (studentsSeatNumbers
                    .where(
                        (element) => (element.gradesID == selectedItemGradeId))
                    .length -
                int.parse(numberOfStudentsController.text) >=
            0) &&
        (int.parse(numberOfStudentsController.text) +
                availableStudents.length) <=
            int.parse(examRoomResModel.classRoomResModel!.maxCapacity!);
  }

  /// Checks if the number of students to be removed is valid.
  ///
  /// If [selectedItemClassId] is not -1, the function checks if the number of students
  /// in the selected class and grade is greater or equal to the number of students to be
  /// removed. If the number is valid, the function also checks if the total number of students
  /// in the exam room after removing the new students is greater than or equal to 0.
  ///
  /// If [selectedItemClassId] is -1, the function checks if the number of students
  /// in the selected grade is greater or equal to the number of students to be
  /// removed. If the number is valid, the function also checks if the total number of students
  /// in the exam room after removing the new students is greater than or equal to 0.
  ///
  /// The function returns true if the number of students to be removed is valid, and false
  /// otherwise.
  bool canRemoveStudents() {
    if (selectedItemClassId != -1) {
      return availableStudents
                  .where((element) =>
                      (element.gradesID == selectedItemGradeId) &&
                      (element.student!.classRoomResModel!.iD ==
                          selectedItemClassId))
                  .length -
              int.parse(numberOfStudentsController.text) >=
          0;
    }
    return availableStudents
                .where((element) => (element.gradesID == selectedItemGradeId))
                .length -
            int.parse(numberOfStudentsController.text) >=
        0;
  }

  /// This function checks if there are any students from the same grade setting next to each other in the exam room.
  ///
  /// The function takes an optional parameter [checkVertical] which is a boolean. If [checkVertical] is true, the function
  /// will also check if there are any students from the same grade setting on top of each other in the exam room.
  ///
  /// The function will return true if there are any students from the same grade setting next to each other, and false
  /// otherwise.
  bool checkStudentsSettingNextToEachOther({bool checkVertical = false}) {
    studentsSettingNextToEachOther.clear();

    // ccheck there is no students from the sae grade setting next to each other
    // use the class desk rowNum and column
    for (int i = 0; i < availableStudents.length; i++) {
      if (classDesks.firstWhereOrNull((classDesk) =>
              classDesk.id == availableStudents[i].classDeskID) !=
          null) {
        ClassDeskResModel currentClassDesk = classDesks.firstWhere(
            (classDesk) => classDesk.id == availableStudents[i].classDeskID);
        ClassDeskResModel? nextClassDeskHorizontal =
            classDesks.firstWhereOrNull((classDesk) =>
                (classDesk.rowNum == currentClassDesk.rowNum &&
                    classDesk.columnNum == currentClassDesk.columnNum! + 1));
        ClassDeskResModel? nextClassDeskVertical = classDesks.firstWhereOrNull(
            (classDesk) => (classDesk.rowNum == currentClassDesk.rowNum! + 1 &&
                classDesk.columnNum == currentClassDesk.columnNum!));
        if (nextClassDeskHorizontal != null) {
          StudentSeatNumberResModel? nextStudent =
              availableStudents.firstWhereOrNull((student) =>
                  student.classDeskID == nextClassDeskHorizontal.id);
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
        if (checkVertical && nextClassDeskVertical != null) {
          StudentSeatNumberResModel? nextStudent =
              availableStudents.firstWhereOrNull(
                  (student) => student.classDeskID == nextClassDeskVertical.id);
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
    studentsSettingNextToEachOther
        .assignAll(studentsSettingNextToEachOther.toSet().toList());
    return studentsSettingNextToEachOther.isNotEmpty;
  }

  /// This function distributes the students in the exam room.
  ///
  /// The function takes no parameters.
  ///
  /// The function will make a PATCH request to the server to update the students in the exam room.
  /// The request body will contain the list of students with their ids and class desk ids.
  ///
  /// The function will return a Future<void> that completes when the request is finished.
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

  /// This function assigns the students to the class desks in the exam room.
  ///
  /// The function takes no parameters.
  ///
  /// The function will assign the students to the class desks in the exam room.
  /// The function will assign the students from the same grade to the class desks
  /// in a round robin fashion. If the number of grades is greater than 4, the
  /// function will show an error dialogue and will not assign the students to the
  /// class desks. If the number of grades is 3, the function will show a warning
  /// dialogue if there are some students from the same grade that will be sitting
  /// next to each other. The user can choose to continue or cancel the
  /// distribution. If the user chooses to continue, the function will assign the
  /// students to the class desks. If the user chooses to cancel, the function will
  /// return and will not assign the students to the class desks.
  ///
  /// The function will also update the UI to show the distribution of the
  /// students in the exam room.
  ///
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

  /// Export the student distribution in the exam room to a PDF file.
  ///
  /// The function does not take any parameters.
  ///
  /// The function will create a PDF file that contains the student distribution
  /// in the exam room. The PDF file will have the NIS logo at the top, and the
  /// student distribution will be displayed as a table with the student's name,
  /// grade, and class room. The table will have a header with the student's name,
  /// grade, and class room. The table will also have a footer with the number of
  /// students in each grade. The PDF file will be saved to the user's downloads
  /// folder with the name "student distribute of [exam room name].pdf". The
  /// function will also show a success message at the top of the screen.
  ///
  /// The function uses the [pdf] package to generate the PDF file. The function
  /// uses the [html] package to save the PDF file to the user's downloads folder.
  /// The function uses the [Get] package to show the success message at the top
  /// of the screen.
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
                                                                      .name!]
                                                                  ?.toPdfColorFromValue() ??
                                                              ColorManager.white
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
                                                                      .toList()[
                                                                  index])
                                                          .name]
                                                      ?.toPdfColorFromValue() ??
                                                  ColorManager.white
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

  /// Finishes the distribution of students to the exam room
  /// and returns true if successful.
  Future<bool> finish() async {
    distributeStudents();
    return true;
  }

  /// Adds the selected students to the [availableStudents] list and removes them from the [studentsSeatNumbers] list.
  /// It also updates the [availableStudentsCount] and [countByGrade] maps, and the [optionsGradesInExamRoom] list.
  ///
  /// If the selected grade does not have any more available students, it will be removed from the [optionsGradesInExamRoom] list.
  ///
  /// The function will also update the UI by calling [update()].
  ///
  /// The function takes no parameters.
  void getAvailableStudents() async {
    int? addedStudentsCount;
    if (selectedItemClassId == -1) {
      addedStudentsCount = studentsSeatNumbers
          .where((element) => (element.gradesID == selectedItemGradeId))
          .take(int.parse(numberOfStudentsController.text))
          .length;
      availableStudents.addAll(studentsSeatNumbers
          .where((element) => (element.gradesID == selectedItemGradeId))
          .take(int.parse(numberOfStudentsController.text)));
    } else if (selectedItemClassId != -1) {
      addedStudentsCount = studentsSeatNumbers
          .where((element) =>
              element.gradesID == selectedItemGradeId &&
              element.student!.classRoomResModel!.iD == selectedItemClassId)
          .take(int.parse(numberOfStudentsController.text))
          .length;
      availableStudents.addAll(studentsSeatNumbers
          .where((element) => (element.gradesID == selectedItemGradeId &&
              element.student!.classRoomResModel!.iD == selectedItemClassId))
          .take(int.parse(numberOfStudentsController.text)));
    }

    ResponseHandler responseHandler = ResponseHandler();
    responseHandler.getResponse(
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
    availableStudentsCount -= addedStudentsCount!;
    countByGrade[selectedItemGradeId.toString()] =
        countByGrade[selectedItemGradeId.toString()]! - addedStudentsCount;
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

  /// Gets all class desks from the API and updates the UI
  ///
  /// The function sends a GET request to the server and gets the response.
  /// If the response is successful, the function will update the list of
  /// class desks and the options for the class desk drop down.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the error message.
  ///
  /// The function will also update the UI to show or hide the loading indicator
  /// based on the status of the request.
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

  /// Gets the exam room from the local hive storage if it has been saved there
  ///
  /// The function checks if the exam room ID is null and if the exam room has
  /// been saved in the local hive storage. If yes, it fetches the exam room
  /// from the hive storage and updates the UI. If not, it creates a new
  /// instance of the ExamRoomResModel.
  ///
  /// The function is used when the user navigates to the distribute students
  /// page.
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

  /// Gets all the grades from the API and sets the
  /// [optionsGrades] with the grades returned by the API.
  ///
  /// It sets the [isLoadingGrades] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// The function is used when the user navigates to the distribute students
  /// page.
  ///
  /// The function returns a boolean indicating whether the grades were retrieved
  /// successfully.
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

  /// Gets all the students seat numbers from the API and sets the
  /// [studentsSeatNumbers], [availableStudents], [optionsGrades],
  /// [optionsGradesInExamRoom], [availableStudentsCount], and
  /// [countByGrade] with the students seat numbers returned by the API.
  ///
  /// It sets the [isLoading] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the
  /// failure message.
  ///
  /// The function is used when the user navigates to the distribute
  /// students page.
  ///
  /// The function returns a boolean indicating whether the students
  /// seat numbers were retrieved successfully.
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

  /// Called when the widget is initialized, it sets up the data necessary for the
  /// widget to work.
  //
  /// It first calls the superclass's [onInit], then sets [isLoading] to `true` and
  /// calls [update] to show the loading indicator.
  //
  /// It then calls [getExamRoom], waits for it to finish, and then calls
  /// [getGradesBySchoolId] and waits for it to finish. After that, it calls both
  /// [getStudentsSeatNumbers] and [getClassDesks] and waits for both to finish.
  //
  /// Finally, it sets [isLoading] to `false` and calls [update] again to hide the
  /// loading indicator and show the data in the UI.
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

  /// Removes all the students from the class desks in the database and in the UI.
  ///
  /// It first sets the [classDeskID] of each student in [availableStudents] to `null`.
  ///
  /// Then it creates a [ResponseHandler], and calls [getResponse] on it with the path
  /// `${StudentsLinks.studentSeatNumbers}/many`, the converter as an empty function,
  /// the request type as [ReqTypeEnum.PATCH], and the body as a list of maps.
  ///
  /// The list of maps is created by mapping each student in [availableStudents] to a
  /// map with the student's ID and the student's class desk ID set to `null`.
  ///
  /// After the request is finished, it calls [update] to update the UI.
  ///
  /// The function returns nothing.
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

  /// Removes a student from a class desk in the database and in the UI.
  ///
  /// It first finds the student in the [availableStudents] list and sets the
  /// [classDeskID] of the student to `null`.
  ///
  /// Then it creates a [ResponseHandler], and calls [getResponse] on it with the path
  /// `${StudentsLinks.studentSeatNumbers}/$studentSeatNumberId`, the converter as an
  /// empty function, the request type as [ReqTypeEnum.PATCH], and the body as a map
  /// with the student's ID and the student's class desk ID set to `null`.
  ///
  /// After the request is finished, it calls [update] to update the UI.
  ///
  /// The function takes one required parameter, [studentSeatNumberId], which is the ID
  /// of the student to be removed from the class desk.
  ///
  /// The function returns nothing.
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

  /// Removes a student from the exam room in the database and in the UI.
  ///
  /// It first finds the student in the [availableStudents] list, sets the
  /// [examRoomID] of the student to `null`, adds the student to the
  /// [studentsSeatNumbers] list, and increments the [availableStudentsCount].
  ///
  /// Then it increments the count of the student's grade in [countByGrade] by one.
  ///
  /// After that, it adds the student to the [removedStudentsFromExamRoom] list, and
  /// removes the student from the [availableStudents] list.
  ///
  /// Finally, it checks if there are any students with the same grade in the
  /// [availableStudents] list, and if not, removes the grade from the
  /// [optionsGradesInExamRoom] list. It then calls [update] to update the UI.
  ///
  /// The function takes one required parameter, [studentSeatNumberId], which is the ID
  /// of the student to be removed from the exam room.
  ///
  /// The function returns nothing.
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

  /// Removes multiple students from the exam room in the database and in the UI.
  ///
  /// If [selectedItemClassId] is -1, it removes the last [numberOfStudentsController.text]
  /// students from the exam room. If [selectedItemClassId] is not -1, it removes the last
  /// [numberOfStudentsController.text] students from the exam room with the same grade
  /// and class room as [selectedItemClassId].
  ///
  /// It first creates a list of students to be removed, and adds them to the
  /// [studentsSeatNumbers] list and the [removedStudentsFromExamRoom] list.
  ///
  /// Then it removes the students from the [availableStudents] list, and updates the
  /// [availableStudentsCount] and the [countByGrade] map.
  ///
  /// After that, it checks if there are any students with the same grade in the
  /// [availableStudents] list, and if not, removes the grade from the
  /// [optionsGradesInExamRoom] list.
  ///
  /// Finally, it clears the [numberOfStudentsController], calls [update] to update the
  /// UI, and sends a PATCH request to the server to update the students in the database.
  ///
  /// The function takes no parameters.
  ///
  /// The function returns nothing.
  void removeStudentsFromExamRoom() {
    List<StudentSeatNumberResModel>? removedStudents;
    if (selectedItemClassId == -1) {
      removedStudents = availableStudents.reversed
          .where((element) => (element.gradesID == selectedItemGradeId))
          .take(int.parse(numberOfStudentsController.text))
          .toList();
    } else if (selectedItemClassId != -1) {
      removedStudents = availableStudents.reversed
          .where((element) => (element.gradesID == selectedItemGradeId &&
              element.student!.classRoomResModel!.iD == selectedItemClassId))
          .take(int.parse(numberOfStudentsController.text))
          .toList();
    }
    studentsSeatNumbers.addAll(
      removedStudents!,
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
    availableStudentsCount += removedStudents.length;
    countByGrade[selectedItemGradeId.toString()] =
        countByGrade[selectedItemGradeId.toString()]! + removedStudents.length;
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

  /// Saves the exam room model to the local storage.
  //
  /// This function takes an [ExamRoomResModel] as a parameter and
  /// saves it to the local storage. It also updates the UI by calling
  /// [update].
  ///
  /// The exam room model is saved in a Hive box called 'ExamRoom'.
  /// The key of the box is 'examRoomResModel' and the value is the
  /// JSON representation of the exam room model.

  Future<void> saveExamRoom(ExamRoomResModel examRoomResModel) async {
    this.examRoomResModel = examRoomResModel;
    update();
    Hive.box('ExamRoom')
        .put('examRoomResModel', json.encode(examRoomResModel.toJson()));
  }

  /// Unblocks a class desk from being used to seat a student.
  ///
  /// The [classDeskId] is the id of the class desk to be unblocked.
  ///
  /// The function removes the [classDeskId] from the [blockedClassDesks] list and calls [update] to notify the UI of the change.
  void unBlockClassDesk({required int classDeskId}) {
    blockedClassDesks.remove(classDeskId);
    update();
  }
}
