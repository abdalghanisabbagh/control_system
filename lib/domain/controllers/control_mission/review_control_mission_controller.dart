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
import 'package:worker_manager/worker_manager.dart';

import '../../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../../Data/Models/exam_room/exam_rooms_res_model.dart';
import '../../../Data/Models/subject/subject_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class DetailsAndReviewMissionController extends GetxController {
  final List<(String?, int?)> subjects = [];
  int controlMissionId = 0;
  String controlMissionName = '';
  double height = 0;
  bool isLoadingGetExamRooms = false;
  bool isLoadingGetStudentsGrades = false;
  bool isLoadingGetStudentsSeatNumbers = false;
  bool isLoadingGetSubjects = false;
  List<ExamRoomResModel> listExamRoom = [];
  List<SubjectResModel> listSubject = [];
  final List<Tab> myTabs = const <Tab>[
    Tab(text: 'Mission Details'),
    Tab(text: 'Review Students Grades'),
  ];

  StudentGradesResModel? studentGradesResModel;
  List<PlutoColumn> studentsGradesColumns = [];
  PlutoGridStateManager? studentsGradesPlutoGridStateManager;
  List<PlutoRow> studentsGradesRows = <PlutoRow>[];
  List<StudentSeatNumberResModel> studentsSeatNumbers =
      <StudentSeatNumberResModel>[];

  List<PlutoRow> studentsSeatNumbersRows = <PlutoRow>[];
  TabController? tabController;

  /// Activates a student in a control mission by its ID seat number.
  ///
  /// The function takes the ID seat number of the student to be activated as a parameter.
  ///
  /// The function performs the following actions:
  ///
  /// - Sends a PATCH request to the server to activate the student in the control mission.
  /// - If the response is a success, calls [getStudentsSeatNumberByControlMissionId] to refresh
  ///   the list of students in the control mission and sets [activateStudents] to true.
  /// - If the response is a failure, shows an error dialogue with the failure message and
  ///   sets [activateStudents] to false.
  ///
  /// Returns a boolean indicating whether the student was activated successfully.
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

  /// Converts student grades to PlutoGrid rows.
  ///
  /// This function clears the existing `studentsGradesRows` and then populates it with new rows
  /// containing student information from the `studentGradesResModel`. It uses the `workerManager`
  /// to execute tasks for each student in the exam room.
  Future<void> convertStudentsGradesToPlutoGridRows() async {
    studentsGradesRows.clear();

    // Check if the studentGradesResModel is not null.
    if (studentGradesResModel != null) {
      // Execute the task using workerManager.
      workerManager.execute(
        () {
          // Iterate over each exam room.
          for (var examRoom in studentGradesResModel!.examRoom!) {
            // Iterate over each student seat number.
            for (var studentSeatNumber in examRoom.studentSeatNumbers!) {
              // Execute task immediately for each student seat number.
              workerManager.execute(
                priority: WorkPriority.immediately,
                () {
                  // Add a new PlutoRow to studentsGradesRows.
                  studentsGradesRows.add(
                    PlutoRow(
                      cells: {
                        // Add student name to the row.
                        'name_field': PlutoCell(
                          value:
                              '${studentSeatNumber.student?.firstName} ${studentSeatNumber.student?.secondName} ${studentSeatNumber.student?.thirdName}',
                        ),
                        // Add student grade to the row.
                        'grade_field': PlutoCell(
                          value: '${studentSeatNumber.student?.grades?.name}',
                        ),
                        // Add student class to the row.
                        'class_field': PlutoCell(
                          value:
                              '${studentSeatNumber.student?.schoolClass?.name}',
                        ),
                        // Add exam room name to the row.
                        'exam_room_field': PlutoCell(value: '${examRoom.name}'),

                        // Add subject-specific information to the row.
                        ...Map.fromEntries(
                          List.generate(
                            subjects.length,
                            (index) {
                              final ({String? name, int? id}) subject = (
                                name: subjects[index].$1,
                                id: subjects[index].$2,
                              );

                              // Determine the student's status for the subject.
                              return MapEntry(
                                "${subject.name}_${subject.id}",
                                PlutoCell(
                                  value: studentSeatNumber
                                          .student!.cohort!.cohortHasSubjects!
                                          .map(
                                              (element) => element.subjects!.iD)
                                          .contains(subject.id)
                                      ? studentSeatNumber.student?.barcode
                                                  ?.firstWhereOrNull(
                                                      (barcode) =>
                                                          barcode.examMission!
                                                              .subjectsID ==
                                                          subject.id)
                                                  ?.studentDegree ==
                                              null
                                          ? 'Need to scan'
                                          : '${studentSeatNumber.student?.barcode?.firstWhere((barcode) => barcode.examMission!.subjectsID == subject.id).studentDegree}'
                                      : 'Exempt',
                                ),
                              );
                            },
                          ),
                        ),
                      },
                    ),
                  );
                },
              );
            }
          }
          return;
        },
      );
      return;
    }
    return;
  }

  /// Deactivate a student in the control mission with the given id seat.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure. If the response is a success, the function will
  /// call [getStudentsSeatNumberByControlMissionId] to refresh the list of
  /// students in the control mission.
  ///
  /// The function will return a boolean indicating whether the deactivation
  /// was successful.
  ///
  /// [idSeat] is the ID of the student seat number to be deactivated.
  Future<bool> deActiveStudentInControlMission({required String idSeat}) async {
    bool deactivateStudents = false;
    update();
    ResponseHandler<void> responseHandler = ResponseHandler<void>();
    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumberDeActive}/$idSeat',
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

  /// Exports the students' degrees to an Excel (CSV) file and downloads it.
  ///
  /// The function generates a CSV file containing students' information such as
  /// name, grade, class, exam room, and subjects. The subjects' headers are dynamically
  /// generated based on the subjects associated with the students. The CSV file is
  /// saved with the name 'students_degrees.csv' in the user's downloads folder.
  ///
  /// A success dialog is displayed upon successful export.
  ///
  /// [context] is the build context used to show dialogs.
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
              (element) => element.studentSeatNumbers!.map(
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
                    (element) => element.studentSeatNumbers!.map(
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

  /// Export the students' degrees to a PDF file.
  ///
  /// The function does not take any parameters.
  ///
  /// The function will create a PDF file that contains the students' degrees.
  /// The PDF file will have the NIS logo at the top, and the students' degrees
  /// will be displayed as a table with the student's name, grade, class, exam
  /// room, and subjects. The table will have a header with the student's name,
  /// grade, class, exam room, and subjects. The table will also have a footer
  /// with the number of students in each grade. The PDF file will be saved to
  /// the user's downloads folder with the name "students_degrees.pdf". The
  /// function will also show a success message at the top of the screen.
  ///
  /// The function uses the [pdf] package to generate the PDF file. The function
  /// uses the [html] package to save the PDF file to the user's downloads folder.
  /// The function uses the [Get] package to show the success message at the top
  /// of the screen.
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
              (element) => element.studentSeatNumbers!.map(
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
                    (element) => element.studentSeatNumbers!.map(
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

  /// Exports the given [studentsSeatsNumberRows] to a CSV file and downloads it.
  ///
  /// The file will be saved with a .csv extension and the name 'pluto_grid_export.csv'.
  ///
  /// If an error occurs, a dialogue will be shown with the error message.
  ///
  /// The UI will be updated to show a loading indicator while the request is being processed.
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

  /// Exports the given [studentsSeatsNumberRows] to a PDF file and downloads it.
  ///
  /// The file will be saved with a .pdf extension and the name 'pluto_grid_export.pdf'.
  ///
  /// If an error occurs, a dialogue will be shown with the error message.
  ///
  /// The UI will be updated to show a loading indicator while the request is being processed.
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

  /// Generates the columns for the PlutoGrid that shows the grades of the students
  /// in the control mission.
  ///
  /// The function generates columns for the name, grade, class, and exam room of
  /// the students. It also generates a column for each subject in the
  /// [subjects] list. The footer of the last column is a count of the number of
  /// students. The function is executed in the background using the
  /// [workerManager] to avoid blocking the UI thread. The function returns
  /// nothing.
  void generateStudentsGradesColumns() async {
    workerManager.execute(
      () {
        studentsGradesColumns = [
          PlutoColumn(
            readOnly: true,
            enableEditingMode: false,
            title: 'Name',
            field: 'name_field',
            type: PlutoColumnType.text(),
          ),
          PlutoColumn(
            readOnly: true,
            enableEditingMode: false,
            title: 'Grade',
            field: 'grade_field',
            type: PlutoColumnType.text(),
          ),
          PlutoColumn(
            readOnly: true,
            enableEditingMode: false,
            title: 'Class',
            field: 'class_field',
            type: PlutoColumnType.text(),
          ),
          PlutoColumn(
            readOnly: true,
            enableEditingMode: false,
            title: 'Exam Room',
            field: 'exam_room_field',
            type: PlutoColumnType.text(),
          ),
          ...List.generate(
            subjects.length,
            (index) {
              final ({String? name, int? id}) subject =
                  (name: subjects[index].$1, id: subjects[index].$2);
              return PlutoColumn(
                readOnly: true,
                enableEditingMode: false,
                title: subject.name ?? '',
                field: "${subject.name}_${subject.id}",
                type: PlutoColumnType.text(),
                footerRenderer: index == subjects.length - 1
                    ? (footerRenderer) {
                        return PlutoAggregateColumnFooter(
                          rendererContext: footerRenderer,
                          type: PlutoAggregateColumnType.count,
                          format: 'count : #,###',
                          alignment: Alignment.center,
                        );
                      }
                    : null,
              );
            },
          ),
        ];
      },
    );
    return;
  }

  /// Gets the control mission ID from Hive and updates the UI.
  ///
  /// The function will get the control mission ID from Hive and store it in the
  /// [controlMissionId] variable. It will then call the [update] function to
  /// update the UI. If the control mission ID is null, it will default to 0.
  Future<void> getControlMissionId() async {
    controlMissionId = Hive.box('ControlMission').get('Id') ?? 0;
    update();
  }

  /// Gets the control mission name from Hive and updates the UI.
  ///
  /// The function will get the control mission name from Hive and store it in the
  /// [controlMissionName] variable. It will then call the [update] function to
  /// update the UI. If the control mission name is null, it will default to an
  /// empty string.
  Future<void> getControlMissionName() async {
    controlMissionName = Hive.box('ControlMission').get('Name') ?? '';
    update();
  }

  /// Gets the exam rooms of a control mission from the API and sets the
  /// [listExamRoom] with the exam rooms returned by the API.
  ///
  /// The function takes no parameters.
  ///
  /// The function will show a loading indicator while the request is being
  /// processed.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the failure message.
  ///
  /// If the response is successful, the function will update the UI with the
  /// exam rooms returned by the API.
  Future<void> getExamRoomByControlMissionId() async {
    isLoadingGetExamRooms = true;
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
    isLoadingGetExamRooms = false;
  }

  /// Gets all students grades for the given control mission ID from the API and assigns them to [studentGradesResModel].
  ///
  /// The function takes no parameters.
  ///
  /// The function will show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update the UI with the students grades returned by the API.
  ///
  /// The function will also call [convertStudentsGradesToPlutoGridRows] to convert the students grades to a list of [PlutoRow] objects and update the UI.
  ///
  /// The function will also call [generateStudentsGradesColumns] to generate the columns for the students grades table.
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
      (r) async {
        workerManager.execute(
          () {
            studentGradesResModel = r;
            subjects.assignAll(studentGradesResModel!.examRoom!
                .map(
                  (element) => element.studentSeatNumbers!.map(
                    (element) =>
                        element.student!.cohort!.cohortHasSubjects!.map(
                      (element) =>
                          (element.subjects!.name, element.subjects!.iD),
                    ),
                  ),
                )
                .expand((element) => element)
                .expand((element) => element)
                .toSet()
                .toList());
            convertStudentsGradesToPlutoGridRows();
          },
        );
        generateStudentsGradesColumns();
      },
    );

    isLoadingGetStudentsGrades = false;
    update();
  }

  /// Gets the students seat numbers for the given control mission ID from the API and assigns them to [studentsSeatNumbersRows].
  ///
  /// The function takes no parameters.
  ///
  /// The function will show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update the UI with the students seat numbers returned by the API and return true.
  ///
  /// The function will also call [convertStudentsSeatNumbersToPlutoGridRows] to convert the students seat numbers to a list of [PlutoRow] objects and update the UI.
  Future<bool> getStudentsSeatNumberByControlMissionId() async {
    bool getData = false;
    isLoadingGetStudentsSeatNumbers = true;
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
        workerManager.execute(
          () {
            studentsSeatNumbers = r.studentSeatNumbers!;
            studentsSeatNumbersRows =
                r.studentSeatNumbers!.convertStudentsToRows();
            getData = true;
          },
        );
      },
    );

    isLoadingGetStudentsSeatNumbers = false;
    update();
    return getData;
  }

  /// Gets the subjects for a control mission from the API and sets the
  /// [listSubject] with the subjects returned by the API.
  ///
  /// The function takes no parameters.
  ///
  /// The function will show a loading indicator while the request is being
  /// processed.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the failure message.
  ///
  /// If the response is successful, the function will update the UI with the
  /// subjects returned by the API.
  Future<void> getSubjectByControlMissionId() async {
    isLoadingGetSubjects = true;
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
    isLoadingGetSubjects = false;
  }

  void onDragUpdate(DragUpdateDetails details) {
    height = details.globalPosition.dy;
    update();
  }

  @override

  /// This function is called when the widget is initialized.
  ///
  /// The function calls the following functions in parallel:
  /// - [getControlMissionId]
  /// - [getControlMissionName]
  ///
  /// After the above functions are completed, the function calls the following
  /// functions in series:
  /// - [getExamRoomByControlMissionId]
  /// - [getSubjectByControlMissionId]
  /// - [getStudentsSeatNumberByControlMissionId]
  /// - [getStudentsGrades] if [controlMissionId] is not zero.
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

  /// Saves the given [id] as the control mission ID in the hive box
  /// 'ControlMission' and updates the UI. The function also calls the
  /// following functions to update the exam room, subjects, and
  /// student seat numbers in the UI:
  /// - [getExamRoomByControlMissionId]
  /// - [getSubjectByControlMissionId]
  /// - [getStudentsSeatNumberByControlMissionId]
  ///
  /// The function is used when the user selects a control mission from the
  /// dropdown menu.
  Future<void> saveControlMissionId(int id) async {
    controlMissionId = id;
    update();
    Hive.box('ControlMission').put('Id', id);
    getExamRoomByControlMissionId();
    getSubjectByControlMissionId();
    getStudentsSeatNumberByControlMissionId();
  }

  /// Saves the given [name] as the control mission name in the hive box
  /// 'ControlMission' and updates the UI. The function is used when the user
  /// edits the name of the control mission in the text field.
  Future<void> saveControlMissionName(String name) async {
    controlMissionName = name;
    update();
    Hive.box('ControlMission').put('Name', name);
  }
}
