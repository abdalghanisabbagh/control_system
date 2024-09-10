import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/student/student_grades_res_model.dart';
import 'package:control_system/Data/Models/student_seat/student_seat_res_model.dart';
import 'package:control_system/Data/Models/student_seat/students_seats_numbers_res_model.dart';
import 'package:control_system/Data/Models/subject/subjects_res_model.dart';
import 'package:control_system/app/extensions/pluto_row_extension.dart';
import 'package:csv/csv.dart' as csv;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pluto_grid/pluto_grid.dart';

import '../../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../../Data/Models/exam_room/exam_rooms_res_model.dart';
import '../../../Data/Models/subject/subject_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class DetailsAndReviewMissionController extends GetxController {
  int controlMissionId = 0;
  String controlMissionName = '';
  bool isLoadingGetStudentsGrades = false;
  bool isLodingGetExamRooms = false;
  bool isLodingGetStudentsSeatNumbers = false;
  bool isLodingGetSubjects = false;
  List<ExamRoomResModel> listExamRoom = [];
  List<SubjectResModel> listSubject = [];
  final List<Tab> myTabs = const <Tab>[
    Tab(text: 'Mission Details'),
    Tab(text: 'Review Students Grades'),
  ];

  StudentGradesResModel? studentGradesResModel;
  PlutoGridStateManager? studentsGradesPlutoGridStateManager;
  List<PlutoRow> studentsGradesRows = <PlutoRow>[];
  List<StudentSeatNumberResModel> studentsSeatNumbers =
      <StudentSeatNumberResModel>[];

  List<PlutoRow> studentsSeatNumbersRows = <PlutoRow>[];
  TabController? tabController;

  Future<bool> activeStudentInControlMission({required String idSeat}) async {
    bool activateStudents = false;
    update();
    ResponseHandler<void> responseHandler = ResponseHandler<void>();
    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumberActive}/$idSeat',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: {},
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        activateStudents = false;
      },
      (r) {
        activateStudents = true;
        getStudentsSeatNumberByControlMissionId();
      },
    );
    update();
    return activateStudents;
  }

  void convertStudentsGradesToPlutoGridRows() {
    studentsGradesRows.clear();

    if (studentGradesResModel != null) {
      for (var examRoom in studentGradesResModel!.examRoom!) {
        for (var studentSeatNumber in examRoom.studentSeatNumnbers!) {
          studentsGradesRows.add(
            PlutoRow(
              cells: {
                'name_field': PlutoCell(
                    value:
                        '${studentSeatNumber.student?.firstName} ${studentSeatNumber.student?.secondName} ${studentSeatNumber.student?.thirdName}'),
                'grade_field': PlutoCell(
                    value: '${studentSeatNumber.student?.grades?.name}'),
                'class_field': PlutoCell(
                    value: '${studentSeatNumber.student?.schoolClass?.name}'),
                'exam_room_field': PlutoCell(value: '${examRoom.name}'),
                ...Map.fromEntries(
                  List.generate(
                    studentGradesResModel!.examRoom!
                        .map(
                          (element) => element.studentSeatNumnbers!.map(
                            (element) =>
                                element.student!.cohort!.cohortHasSubjects!.map(
                              (element) => (
                                element.subjects!.name,
                                element.subjects!.iD
                              ),
                            ),
                          ),
                        )
                        .expand((element) => element)
                        .expand((element) => element)
                        .toSet()
                        .toList()
                        .length,
                    (index) {
                      final ({String? name, int? id}) subject =
                          studentGradesResModel!.examRoom!
                              .map(
                                (element) => element.studentSeatNumnbers!.map(
                                  (element) => element
                                      .student!.cohort!.cohortHasSubjects!
                                      .map(
                                    (element) => (
                                      name: element.subjects!.name,
                                      id: element.subjects!.iD
                                    ),
                                  ),
                                ),
                              )
                              .expand((element) => element)
                              .expand((element) => element)
                              .toSet()
                              .toList()[index];
                      return MapEntry(
                        "${subject.name}_${subject.id}",
                        PlutoCell(
                            value: studentSeatNumber
                                    .student!.cohort!.cohortHasSubjects!
                                    .map((element) => element.subjects!.name)
                                    .contains(subject.name)
                                ? studentSeatNumber
                                            .student?.barcode?.studentDegree ==
                                        null
                                    ? 'Need to scan'
                                    : '${studentSeatNumber.student?.barcode?.studentDegree}'
                                : 'Exampt'),
                      );
                    },
                  ),
                ),
              },
            ),
          );
        }
      }
    }
    studentsGradesPlutoGridStateManager!.setPage(1);
    return;
  }

  Future<bool> deactiveStudentInControlMission({required String idSeat}) async {
    bool deactivateStudents = false;
    update();
    ResponseHandler<void> responseHandler = ResponseHandler<void>();
    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumberDeactive}/$idSeat',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: {},
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        deactivateStudents = false;
      },
      (r) {
        deactivateStudents = true;
        getStudentsSeatNumberByControlMissionId();
      },
    );
    update();
    return deactivateStudents;
  }

  void exportStudentDegreesToExcel(BuildContext context) {
    List<List<dynamic>> csvData = [];

    List<String> headers = [
      'Name',
      'Grade',
      'Class',
      'Exam Room',
      ...List.generate(
        studentGradesResModel!.examRoom!
            .map(
              (element) => element.studentSeatNumnbers!.map(
                (element) => element.student!.cohort!.cohortHasSubjects!.map(
                  (element) => (element.subjects!.name, element.subjects!.iD),
                ),
              ),
            )
            .expand((element) => element)
            .expand((element) => element)
            .toSet()
            .toList()
            .length,
        (index) {
          final ({String? name, int? id}) subject =
              studentGradesResModel!.examRoom!
                  .map(
                    (element) => element.studentSeatNumnbers!.map(
                      (element) =>
                          element.student!.cohort!.cohortHasSubjects!.map(
                        (element) => (
                          name: element.subjects!.name,
                          id: element.subjects!.iD
                        ),
                      ),
                    ),
                  )
                  .expand((element) => element)
                  .expand((element) => element)
                  .toSet()
                  .toList()[index];
          return subject.name!;
        },
      )
    ];

    csvData.add(headers);

    for (var row in studentsGradesRows) {
      List<dynamic> rowData = [];
      var cellsValues = row.cells.values.toList();
      for (var i = 0; i < cellsValues.length; i++) {
        rowData.add(cellsValues[i].value.toString());
      }
      csvData.add(rowData);
    }

    String csvString = const csv.ListToCsvConverter().convert(csvData);

    final bytes = utf8.encode(csvString);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute('download', 'students_degrees.csv')
      ..click();

    html.Url.revokeObjectUrl(url);

    MyAwesomeDialogue(
      title: 'success',
      desc: "CSV file exported successfully.",
      dialogType: DialogType.success,
    ).showDialogue(Get.key.currentContext!);
  }

  void exportStudentDegreesToPdf(BuildContext context) async {
    final pdf = pw.Document();

    List<List<String>> tableData = [];

    List<String> headers = [
      'Name',
      'Grade',
      'Class',
      'Exam Room',
      ...List.generate(
        studentGradesResModel!.examRoom!
            .map(
              (element) => element.studentSeatNumnbers!.map(
                (element) => element.student!.cohort!.cohortHasSubjects!.map(
                  (element) => (element.subjects!.name, element.subjects!.iD),
                ),
              ),
            )
            .expand((element) => element)
            .expand((element) => element)
            .toSet()
            .toList()
            .length,
        (index) {
          final ({String? name, int? id}) subject =
              studentGradesResModel!.examRoom!
                  .map(
                    (element) => element.studentSeatNumnbers!.map(
                      (element) =>
                          element.student!.cohort!.cohortHasSubjects!.map(
                        (element) => (
                          name: element.subjects!.name,
                          id: element.subjects!.iD
                        ),
                      ),
                    ),
                  )
                  .expand((element) => element)
                  .expand((element) => element)
                  .toSet()
                  .toList()[index];
          return subject.name!;
        },
      )
    ];

    for (var row in studentsGradesRows) {
      List<String> rowData = [];
      var cellsValues = row.cells.values.toList();
      for (var i = 0; i < cellsValues.length; i++) {
        rowData.add(cellsValues[i].value.toString());
      }
      tableData.add(rowData);
    }

    const maxRowsPerPage = 30;
    for (var i = 0; i < tableData.length; i += maxRowsPerPage) {
      final end = i + maxRowsPerPage;
      final dataSubset =
          tableData.sublist(i, end > tableData.length ? tableData.length : end);

      final pageData = [headers, ...dataSubset];

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.TableHelper.fromTextArray(
                  context: context,
                  data: pageData,
                ),
                pw.Spacer(),
                pw.Align(
                  alignment: pw.Alignment.bottomCenter,
                  child: pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    final Uint8List bytes = await pdf.save();
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute('download', 'students_degrees.pdf')
      ..click();

    MyAwesomeDialogue(
      title: 'success',
      desc: "PDF file exported successfully.",
      dialogType: DialogType.success,
    ).showDialogue(Get.key.currentContext!);
  }

  void exportToCsv(
      BuildContext context, List<PlutoRow> studentsSeatsNumberRows) {
    List<List<dynamic>> csvData = [];

    List<String> headers = [
      'Blb Id',
      'Student Name',
      'Seat Number',
      'Grade',
      'Class Room',
      'Cohort',
    ];

    csvData.add(headers);

    for (var row in studentsSeatsNumberRows) {
      List<dynamic> rowData = [];
      var cellsValues = row.cells.values.toList();
      for (var i = 0; i < cellsValues.length - 1; i++) {
        rowData.add(cellsValues[i].value.toString());
      }
      csvData.add(rowData);
    }

    String csvString = const csv.ListToCsvConverter().convert(csvData);

    final bytes = utf8.encode(csvString);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute('download', 'pluto_grid_export.csv')
      ..click();

    html.Url.revokeObjectUrl(url);

    MyAwesomeDialogue(
      title: 'success',
      desc: "CSV file exported successfully.",
      dialogType: DialogType.success,
    ).showDialogue(Get.key.currentContext!);
  }

  Future<void> exportToPdf(
      BuildContext context, List<PlutoRow> studentsSeatsNumberRows) async {
    final pdf = pw.Document();

    List<List<String>> tableData = [];

    List<String> headers = [
      'Blb Id',
      'Student Name',
      'Seat Number',
      'Grade',
      'Class Room',
      'Cohort',
    ];

    for (var row in studentsSeatsNumberRows) {
      List<String> rowData = [];
      var cellsValues = row.cells.values.toList();
      for (var i = 0; i < cellsValues.length - 1; i++) {
        rowData.add(cellsValues[i].value.toString());
      }
      tableData.add(rowData);
    }

    const maxRowsPerPage = 30;
    for (var i = 0; i < tableData.length; i += maxRowsPerPage) {
      final end = i + maxRowsPerPage;
      final dataSubset =
          tableData.sublist(i, end > tableData.length ? tableData.length : end);

      final pageData = [headers, ...dataSubset];

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.TableHelper.fromTextArray(
                  context: context,
                  data: pageData,
                ),
                pw.Spacer(),
                pw.Align(
                  alignment: pw.Alignment.bottomCenter,
                  child: pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    final Uint8List bytes = await pdf.save();
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute('download', 'pluto_grid_export.pdf')
      ..click();

    MyAwesomeDialogue(
      title: 'success',
      desc: "PDF file exported successfully.",
      dialogType: DialogType.success,
    ).showDialogue(Get.key.currentContext!);
  }

  Future<void> getControlMissionId() async {
    controlMissionId = Hive.box('ControlMission').get('Id') ?? 0;
    update();
  }

  Future<void> getControlMissionName() async {
    controlMissionName = Hive.box('ControlMission').get('Name') ?? '';
    update();
  }

  Future<void> getExamRoomByControlMissionId() async {
    isLodingGetExamRooms = true;
    update();

    final response = await ResponseHandler<ExamRoomsResModel>().getResponse(
      path: "${ExamRoomLinks.examRoomsControlMission}/$controlMissionId",
      converter: ExamRoomsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        listExamRoom = r.data!;
        update();
      },
    );
    isLodingGetExamRooms = false;
  }

  Future<void> getStudentsGrades() async {
    isLoadingGetStudentsGrades = true;
    update();
    final ResponseHandler<StudentGradesResModel> responseHandler =
        ResponseHandler<StudentGradesResModel>();

    var response = await responseHandler.getResponse(
      path: '${StudentsLinks.studentsGrades}/$controlMissionId',
      converter: StudentGradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        studentGradesResModel = r;
      },
    );

    isLoadingGetStudentsGrades = false;
    update();
  }

  Future<bool> getStudentsSeatNumberByControlMissionId() async {
    bool getData = false;
    isLodingGetStudentsSeatNumbers = true;
    update();

    ResponseHandler<StudentsSeatsNumbersResModel> responseHandler =
        ResponseHandler();
    Either<Failure, StudentsSeatsNumbersResModel> response =
        await responseHandler.getResponse(
      path:
          "${StudentsLinks.studentSeatNumbersControlMission}/$controlMissionId",
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
        getData = false;
      },
      (r) {
        studentsSeatNumbers = r.studentSeatNumbers!;
        studentsSeatNumbersRows = r.studentSeatNumbers!.convertStudentsToRows();

        getData = true;
      },
    );

    isLodingGetStudentsSeatNumbers = false;
    update();
    return getData;
  }

  Future<void> getSubjectByControlMissionId() async {
    isLodingGetSubjects = true;
    update();

    final response = await ResponseHandler<SubjectsResModel>().getResponse(
      path:
          "${ControlMissionLinks.getSubjectsByControlMission}/$controlMissionId",
      converter: SubjectsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        listSubject = r.data!;
        update();
      },
    );
    isLodingGetSubjects = false;
  }

  @override
  void onInit() async {
    super.onInit();
    await Future.wait([
      getControlMissionId(),
      getControlMissionName(),
    ]);
    getExamRoomByControlMissionId();
    getSubjectByControlMissionId();
    getStudentsSeatNumberByControlMissionId();
    controlMissionId != 0 ? getStudentsGrades() : null;
  }

  Future<void> saveControlMissionId(int id) async {
    controlMissionId = id;
    update();
    Hive.box('ControlMission').put('Id', id);
    getExamRoomByControlMissionId();
    getSubjectByControlMissionId();
    getStudentsSeatNumberByControlMissionId();
  }

  Future<void> saveControlMissionName(String name) async {
    controlMissionName = name;
    update();
    Hive.box('ControlMission').put('Name', name);
  }
}
