import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:csv/csv.dart' as csv;
import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worker_manager/worker_manager.dart';

import '../../../Data/Models/class_room/class_room_res_model.dart';
import '../../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../../Data/Models/cohort/cohort_res_model.dart';
import '../../../Data/Models/cohort/cohorts_res_model.dart';
import '../../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/student/student_res_model.dart';
import '../../../Data/Models/student/students_res_model.dart';
import '../../../Data/Models/user/login_response/user_profile_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../app/extensions/pluto_row_extension.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';
import '../profile_controller.dart';

class StudentController extends GetxController {
  List<ClassRoomResModel> classRooms = <ClassRoomResModel>[];
  List<CohortResModel> cohorts = <CohortResModel>[];
  Map<String, bool> errorMap = {};
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<GradeResModel> grades = <GradeResModel>[];
  List hasError = [];
  bool hasErrorInBlbId = false;
  bool hasErrorInClassRoom = false;
  bool hasErrorInCohort = false;
  bool hasErrorInGrade = false;
  List<StudentResModel> importedStudents = <StudentResModel>[];
  List<PlutoRow> importedStudentsRows = <PlutoRow>[];
  bool isImportedNew = false;
  bool isImportedPromote = false;
  bool isLoadingAddStudents = false;
  bool isLoadingEditStudent = false;
  bool loading = false;
  List<ValueItem> optionsClassRoom = <ValueItem>[];
  List<ValueItem> optionsCohort = <ValueItem>[];
  List<ValueItem> optionsGrade = <ValueItem>[];
  ValueItem? selectedItemClassRoom;
  ValueItem? selectedItemCohort;
  ValueItem? selectedItemGrade;
  List<StudentResModel> students = <StudentResModel>[];
  List<PlutoRow> studentsRows = <PlutoRow>[];

  final UserProfileModel? _userProfile =
      Get.find<ProfileController>().cachedUserProfile;

  /// Adds many students to the server and updates the UI.
  //
  /// The function takes a list of students and returns a boolean indicating whether
  /// the students have been added to the server.
  //
  /// If the response is a failure, the function shows an error dialog and returns
  /// false.
  //
  /// The function will also update the UI to show that the students have been added
  /// to the server.
  //
  /// The function will also call [onInit] after the students have been added to the
  /// server.
  Future<bool> addManyStudents({
    required List<StudentResModel> students,
  }) async {
    loading = true;
    bool addStudentsHasBeenAdded = false;
    update();
    List<Map<String, dynamic>> studentData = importedStudents
        .map((student) => student.importStudentByExcel())
        .toList();

    ResponseHandler<void> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
        path: StudentsLinks.studentMany,
        converter: (_) {},
        type: ReqTypeEnum.POST,
        body: studentData);

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      addStudentsHasBeenAdded = false;
    }, (result) {
      addStudentsHasBeenAdded = true;
      isImportedNew = false;
      onInit();
    });
    loading = false;

    update();
    return addStudentsHasBeenAdded;
  }

  /// Downloads the student template PDF file and saves it to the user's downloads folder.
  ///
  /// If an error occurs, a dialogue will be shown with the error message.
  ///
  /// The function is used when the user navigates to the add new student page and
  /// presses the download template button.
  ///
  /// The function is asynchronous and returns a future of void.
  Future<void> downloadFile() async {
    try {
      final ByteData data = await rootBundle.load('assets/files/template.pdf');
      final Uint8List bytes = data.buffer.asUint8List();

      await FileSaver.instance.saveFile(
        name: 'student_template',
        bytes: bytes,
        mimeType: MimeType.pdf,
        ext: 'pdf',
      );
    } catch (e) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "$e",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }
  }

  /// Downloads the student template PDF file from Google Drive and saves it to the user's downloads folder.
  //
  /// If an error occurs, a dialogue will be shown with the error message.
  //
  /// The function is used when the user navigates to the add new student page and
  /// presses the download template button.
  //
  /// The function is asynchronous and returns a future of void.
  Future<void> downloadTemp() async {
    if (!await launchUrl(Uri.parse(
        "https://drive.google.com/file/d/1ihFseXC6QHb3FrfAYqz-qp1WlK_1PuYl/view?usp=sharing"))) {
      throw 'Could not launch file';
    }
  }

  /// Exports the given [studentsRows] to a CSV file and downloads it.
  ///
  /// The file will be saved with a .csv extension and the name 'pluto_grid_export.csv'.
  ///
  /// If an error occurs, a dialogue will be shown with the error message.
  ///
  /// The UI will be updated to show a loading indicator while the request is being processed.
  ///
  /// The function will also show a success message at the top of the screen.
  void exportToCsv(BuildContext context, List<PlutoRow> studentsRows) {
    List<List<dynamic>> csvData = [];

    List<String> headers = [
      'id',
      'firstname',
      'middlename',
      'lastname',
      'cohort',
      'grade',
      'class',
      'second_language',
      'religion',
      'citizenship',
    ];

    csvData.add(headers);

    for (var row in studentsRows) {
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

  /// Exports the given [studentsRows] to a PDF file and downloads it.
  //
  /// The file will be saved with a .pdf extension and the name 'pluto_grid_export.pdf'.
  //
  /// If an error occurs, a dialogue will be shown with the error message.
  //
  /// The UI will be updated to show a loading indicator while the request is being processed.
  Future<void> exportToPdf(
      BuildContext context, List<PlutoRow> studentsRows) async {
    final pdf = pw.Document();

    List<List<String>> tableData = [];

    List<String> headers = [
      'Blb Id',
      'First Name',
      'Second Name',
      'Third Name',
      'Cohort',
      'Grade',
      'Class Room',
      'Second Language'
    ];

    tableData.add(headers);

    for (var row in studentsRows) {
      List<String> rowData = [];
      var cellsValues = row.cells.values.toList();
      for (var i = 0; i < cellsValues.length - 1; i++) {
        rowData.add(cellsValues[i].value.toString());
      }
      tableData.add(rowData);
    }

    const maxRowsPerPage = 20;
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

  /// Gets all the classes rooms from the API and sets the
  /// [optionsClassRoom] with the classes rooms returned by the API.
  //
  /// The function will return a boolean indicating whether the classes rooms
  /// were retrieved successfully.
  //
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  //
  /// If the response is a failure, the function will show an error dialog with the failure message.
  Future<bool> getClassRooms() async {
    bool gotData = false;
    update();

    ResponseHandler<ClassesRoomsResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassesRoomsResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.getSchoolsClassesBySchoolId,
      converter: ClassesRoomsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        gotData = false;
      },
      (r) {
        classRooms = r.data!;
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsClassRoom = items;
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  /// Gets all the cohorts by school type from the API and sets the
  /// [optionsCohort] with the cohorts returned by the API.
  //
  /// The function will return a boolean indicating whether the cohorts were
  /// retrieved successfully.
  //
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  //
  /// If the response is a failure, the function will show an error dialog with the failure message.
  Future<bool> getCohorts() async {
    bool gotData = false;
    update();

    ResponseHandler<CohortsResModel> responseHandler = ResponseHandler();
    Either<Failure, CohortsResModel> response =
        await responseHandler.getResponse(
      path: CohortLinks.getCohortBySchoolType,
      converter: CohortsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        gotData = false;
      },
      (r) {
        cohorts = r.data!;
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsCohort = items;

        gotData = true;
      },
    );
    update();
    return gotData;
  }

  /// Gets all grades from the API and assigns them to [grades] and [optionsGrade].
  //
  /// It takes no parameters.
  //
  /// The function will return a boolean indicating whether the grades were
  /// retrieved successfully.
  //
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  //
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  Future<bool> getGrades() async {
    bool gotData = false;
    update();

    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();
    Either<Failure, GradesResModel> response =
        await responseHandler.getResponse(
      path: GradeLinks.gradesSchools,
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        gotData = false;
      },
      (r) {
        grades = r.data!;
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsGrade = items;
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  /// Gets all students from the API and assigns them to [students] and [studentsRows].
  ///
  /// It takes no parameters.
  ///
  /// The function will return a boolean indicating whether the students were
  /// retrieved successfully.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  Future<bool> getStudents() async {
    bool gotData = false;
    update();

    ResponseHandler<StudentsResModel> responseHandler = ResponseHandler();
    Either<Failure, StudentsResModel> response =
        await responseHandler.getResponse(
      path: '${StudentsLinks.studentSchool}/${Hive.box('School').get('Id')}',
      converter: StudentsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        gotData = false;
      },
      (r) {
        workerManager.execute(
          () {
            students = r.students!;
            studentsRows = r.students!.convertStudentsToRows();
            gotData = true;
          },
        );
      },
    );
    update();
    return gotData;
  }

  @override

  /// Called when the widget is initialized.
  ///
  /// The function sets the initial state of the controller and then calls the
  /// [getCohorts], [getClassRooms], and [getGrades] functions to retrieve the
  /// cohorts, class rooms, and grades from the API.
  ///
  /// After the retrieval of the data, the function calls [getStudents] to
  /// retrieve the students from the API.
  ///
  /// The function also updates the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// When the function is finished, it calls the [super.onInit] method to
  /// initialize the parent class.
  void onInit() async {
    isImportedNew = false;
    isImportedPromote = false;
    loading = true;
    importedStudentsRows = [];
    update();
    await Future.wait([
      getCohorts(),
      getClassRooms(),
      getGrades(),
    ]).then((_) async {
      await getStudents();
    });
    loading = false;
    update();
    super.onInit();
  }

  /// Edits a student in the server and updates the UI.
  ///
  /// The function takes the following parameters:
  ///
  /// - [studentid]: the id of the student to be edited
  /// - [blbId]: the id of the student's blb
  /// - [gradesId]: the id of the student's grade
  /// - [cohortId]: the id of the student's cohort
  /// - [schoolClassId]: the id of the student's school class
  /// - [firstName]: the first name of the student
  /// - [secondName]: the second name of the student
  /// - [thirdName]: the third name of the student
  /// - [secondLang]: the second language of the student
  /// - [religion]: the religion of the student
  /// - [citizenship]: the citizenship of the student
  ///
  /// The function will show an error dialog if the response is a failure.
  ///
  /// The function will also update the UI to show that the student has been edited
  /// in the server.
  ///
  /// The function returns a boolean indicating whether the student was edited
  /// successfully.
  Future<bool> patchEditStudent({
    required int studentid,
    required int blbId,
    required int gradesId,
    required int cohortId,
    required int schoolClassId,
    required String firstName,
    required String secondName,
    required String thirdName,
    required String? secondLang,
    required String religion,
    required String? citizenship,
  }) async {
    isLoadingEditStudent = true;
    update();
    bool editStudentHasBeenAdded = false;
    int schoolId = Hive.box('School').get('Id');

    ResponseHandler<StudentResModel> responseHandler = ResponseHandler();

    Map<String, dynamic> body = {
      "Blb_Id": blbId,
      "Grades_ID": gradesId,
      "Schools_ID": schoolId,
      "Cohort_ID": cohortId,
      "School_Class_ID": schoolClassId,
      "First_Name": firstName,
      "Second_Name": secondName,
      "Third_Name": thirdName,
      "Created_By": _userProfile?.iD,
      "Religion": religion,
      if (citizenship != null) "Citizenship": citizenship,
      if (secondLang != null) "Second_Lang": secondLang
    };

    var response = await responseHandler.getResponse(
      path: "${StudentsLinks.student}/$studentid",
      converter: StudentResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: body,
    );

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      editStudentHasBeenAdded = false;
    }, (result) {
      getStudents();
      editStudentHasBeenAdded = true;
    });

    isLoadingEditStudent = false;
    update();
    return editStudentHasBeenAdded;
  }

  /// Allows the user to select a CSV file and processes it to add students to the server.
  ///
  /// The function shows an error dialog if the user does not select a file.
  ///
  /// The function will also update the UI to show that the file has been imported.
  ///
  /// The function will also update the UI to show that the students have been added to the server.
  Future<void> pickAndReadFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      allowMultiple: false,
    );

    if (pickedFile != null) {
      Uint8List? fileBytes = pickedFile.files.single.bytes;

      if (fileBytes != null) {
        await _processCsvFile(
          fileBytes,
          students: students,
          cohorts: cohorts,
          classesRooms: classRooms,
          grades: grades,
        );
      }
    } else {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'No file selected',
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }
  }

  /// Sets the [selectedItemClassRoom] to the first item in [items] if [items] is not empty.
  ///
  /// The function will also call [update] to update the UI.
  void setSelectedItemClassRoom(List<ValueItem> items) {
    selectedItemClassRoom = items.isEmpty ? null : items.first;
    update();
  }

  /// Sets the [selectedItemCohort] to the first item in [items] if [items] is not empty.
  ///
  /// The function will also call [update] to update the UI.
  void setSelectedItemCohort(List<ValueItem> items) {
    selectedItemCohort = items.isEmpty ? null : items.first;
    update();
  }

  /// Sets the [selectedItemGrade] to the first item in [items] if [items] is not empty.
  ///
  /// The function will also call [update] to update the UI.
  void setSelectedItemGrade(List<ValueItem> items) {
    selectedItemGrade = items.isEmpty ? null : items.first;
    update();
  }

  /// Updates many students in the server.
  ///
  /// The function takes a list of [StudentResModel] as a parameter.
  ///
  /// The function will update the UI to show that the students are being updated.
  ///
  /// The function will also call [onInit] after the students have been updated to the
  /// server.
  ///
  /// The function will return a boolean indicating whether the students were updated
  /// successfully.
  Future<bool> updateManyStudents({
    required List<StudentResModel> students,
  }) async {
    loading = true;
    bool updateStudentsHasBeenAdded = false;
    update();

    List<Map<String, dynamic>> studentData = importedStudents
        .map((student) => student.importStudentByExcel())
        .toList();

    ResponseHandler<void> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
        path: StudentsLinks.studentMany,
        converter: (_) {},
        type: ReqTypeEnum.PATCH,
        body: studentData);

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      updateStudentsHasBeenAdded = false;
    }, (result) {
      updateStudentsHasBeenAdded = true;
      onInit();
    });
    loading = false;

    update();
    return updateStudentsHasBeenAdded;
  }

  /// Processes a CSV file and updates the UI with the data from the file.
  //
  /// The function takes the following parameters:
  //
  /// - [fileBytes]: The bytes of the file to be processed.
  /// - [students]: The list of students to check against.
  /// - [cohorts]: The list of cohorts to check against.
  /// - [classesRooms]: The list of class rooms to check against.
  /// - [grades]: The list of grades to check against.
  //
  /// The function will first check if the file contains the required headers.
  /// If the file does not contain the required headers, the function will show
  /// an error dialogue with the missing headers.
  //
  /// If the file contains the required headers, the function will then check if
  /// the file contains any rows. If the file does not contain any rows, the
  /// function will show an error dialogue.
  //
  /// If the file contains rows, the function will then convert the rows to a
  /// list of [StudentResModel] using the [StudentResModel.fromCsvWithHeaders]
  /// constructor.
  //
  /// The function will then call the [convertFileStudentsToPluto] or
  /// [convertPromoteFileStudentsToPluto] function depending on the value of
  /// [isImportedNew] and [isImportedPromote] respectively.
  //
  /// If the response is a failure, the function will show an error dialogue with
  /// the failure message.
  //
  /// If the response is a success, the function will update the UI with the
  /// returned data.
  //
  /// The function will also update the UI with the errors returned by the
  /// [convertFileStudentsToPluto] or [convertPromoteFileStudentsToPluto]
  /// function.
  Future<void> _processCsvFile(
    Uint8List fileBytes, {
    required List<StudentResModel> students,
    required List<CohortResModel> cohorts,
    required List<ClassRoomResModel> classesRooms,
    required List<GradeResModel> grades,
  }) async {
    String content = String.fromCharCodes(fileBytes);
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(content);

    if (rowsAsListOfValues.isNotEmpty && rowsAsListOfValues[0].length > 8) {
      List<String> headers =
          rowsAsListOfValues.first.map((header) => header.toString()).toList();
      List<String> requiredHeaders = [
        'id',
        'firstname',
        'middlename',
        'lastname',
        'grade',
        'class',
        'cohort',
        'second_language',
        'religion',
        'citizenship',
      ];

      List<String> missingHeaders =
          requiredHeaders.where((header) => !headers.contains(header)).toList();
      if (missingHeaders.isNotEmpty) {
        MyAwesomeDialogue(
          title: 'Error',
          desc:
              'Missing headers: ${missingHeaders.join(', ')} \nPlease check the header values in the file and try again',
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        return;
      }
      rowsAsListOfValues.removeAt(0);

      var studentsCsv = rowsAsListOfValues
          .map((row) => StudentResModel.fromCsvWithHeaders(row, headers))
          .toList();
      Map<String, dynamic> result;

      if (isImportedNew == true) {
        result = studentsCsv.convertFileStudentsToPluto(
          students: students,
          cohorts: cohorts,
          classesRooms: classesRooms,
          grades: grades,
        );
        importedStudentsRows.assignAll(result['rows']);
        importedStudents.assignAll(result['students']);
        hasErrorInGrade = result['errorgrade'];
        hasErrorInCohort = result['errorcohort'];
        hasErrorInClassRoom = result['errorclass'];
        hasError.assignAll(result['errors']);
        update();
      } else if (isImportedPromote == true) {
        result = studentsCsv.convertPromoteFileStudentsToPluto(
          students: students,
          cohorts: cohorts,
          classesRooms: classesRooms,
          grades: grades,
        );
        importedStudentsRows.assignAll(result['rows']);
        importedStudents.assignAll(result['students']);
        hasErrorInGrade = result['errorgrade'];
        hasErrorInCohort = result['errorcohort'];
        hasErrorInClassRoom = result['errorclass'];
        hasErrorInBlbId = result['errorBlbID'];
        update();
      }
    } else {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "Please check the values in the file and try again.",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      update();
    }
  }
}
