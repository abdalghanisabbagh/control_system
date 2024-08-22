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
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import '../profile_controller.dart';

class StudentController extends GetxController {
  List<ClassRoomResModel> classRooms = <ClassRoomResModel>[];
  List<CohortResModel> cohorts = <CohortResModel>[];
  Map<String, bool> errorMap = {};
  List<GradeResModel> grades = <GradeResModel>[];
  List hasError = [];
  bool hasErrorInBlbId = false;
  bool hasErrorInClassRoom = false;
  bool hasErrorInCohort = false;
  bool hasErrorInGrade = false;
  List<StudentResModel> importedStudents = <StudentResModel>[];
  List<PlutoRow> importedStudentsRows = <PlutoRow>[];
  bool isImportedNew = false;
  bool isImportedPromot = false;
  bool islodingAddStudents = false;
  bool islodingEditStudent = false;
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

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
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

  Future<void> downloadeTemp() async {
    if (!await launchUrl(Uri.parse(
        "https://drive.google.com/file/d/1ihFseXC6QHb3FrfAYqz-qp1WlK_1PuYl/view?usp=sharing"))) {
      throw 'Could not launch file';
    }
  }

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

  void exportToCsv(BuildContext context, List<PlutoRow> studentsRows) {
    List<List<dynamic>> csvData = [];

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

  // void testCohort(
  //   Uint8List fileBytes,
  // ) async {
  //   String content = String.fromCharCodes(fileBytes);

  //   List<List<dynamic>> rowsAsListOfValues =
  //       const CsvToListConverter().convert(content);

  //   List<dynamic> index9Values = [];

  //   if (rowsAsListOfValues.isNotEmpty && rowsAsListOfValues[0].length > 9) {
  //     index9Values = rowsAsListOfValues.skip(1).map((row) => row[7]).toList();
  //     for (var value in index9Values) {
  //       if (!grades.any((grade) => grade.name == value.toString())) {
  //         print("dsdsd");

  //         bool success = await addNewGrade(name: value.toString());
  //         if (success) {
  //           grades.add(GradeResModel(name: value.toString()));
  //         }
  //       }
  //     }
  //     isimorted = true;
  //   } else {
  //     print('The file is empty or does not contain enough columns.');
  //   }

  //   update();
  // }

  // Future<bool> addnewCohort(String name) async {
  //   // addLoading = true;
  //   update();
  //   bool cohortHasBeenAdded = false;
  //   ResponseHandler<CohortResModel> responseHandler = ResponseHandler();
  //   Either<Failure, CohortResModel> response =
  //       await responseHandler.getResponse(
  //     path: SchoolsLinks.cohort,
  //     converter: CohortResModel.fromJson,
  //     type: ReqTypeEnum.POST,
  //     body: {
  //       "Name": name,
  //       "Created_By": Hive.box('Profile').get('ID'),
  //       "School_Type_ID": Hive.box('School').get('SchoolTypeID'),
  //     },
  //   );
  //   response.fold(
  //     (l) {
  //       MyAwesomeDialogue(
  //         title: 'Error',
  //         desc: l.message,
  //         dialogType: DialogType.error,
  //       ).showDialogue(Get.key.currentContext!);
  //       cohortHasBeenAdded = false;
  //     },
  //     (r) {
  //       // getAllCohorts();
  //       cohortHasBeenAdded = true;
  //       update();
  //     },
  //   );

  //   //  addLoading = false;
  //   update();
  //   return cohortHasBeenAdded;
  // }
  // Future<bool> addNewGrade({
  //   required String name,
  // }) async {
  //   // isLoadingAddGrades = true;
  //   update();
  //   bool gradeHasBeenAdded = false;
  //   ResponseHandler<GradeResModel> responseHandler = ResponseHandler();
  //   Either<Failure, GradeResModel> response = await responseHandler.getResponse(
  //     path: SchoolsLinks.grades,
  //     converter: GradeResModel.fromJson,
  //     type: ReqTypeEnum.POST,
  //     body: {
  //       "Schools_ID": Hive.box('School').get('Id'),
  //       "Name": name,
  //     },
  //   );
  //   response.fold(
  //     (l) {
  //       MyAwesomeDialogue(
  //         title: 'Error',
  //         desc: l.message,
  //         dialogType: DialogType.error,
  //       ).showDialogue(Get.key.currentContext!);
  //       gradeHasBeenAdded = false;
  //     },
  //     (r) {
  //       // spread operator to add new grade
  //       grades = [...grades, r];
  //     },
  //   );

  //   gradeHasBeenAdded = true;
  //   // isLoadingAddGrades = false;
  //   update();
  //   return gradeHasBeenAdded;
  // }

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

  Future<bool> getGrades() async {
    bool gotData = false;
    update();
    int schoolId = Hive.box('School').get('Id');

    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();
    Either<Failure, GradesResModel> response =
        await responseHandler.getResponse(
      path: "${GradeLinks.gradesSchools}/$schoolId",
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
        students = r.students!;
        studentsRows = r.students!.convertStudentsToRows();
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  @override
  void onInit() async {
    isImportedNew = false;
    isImportedPromot = false;

    loading = true;
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

  Future<bool> patchEditStudent({
    required int studentid,
    required int gradesId,
    required int cohortId,
    required int schoolClassId,
    required String firstName,
    required String secondName,
    required String thirdName,
    required String secondLang,
    required String religion,
  }) async {
    islodingEditStudent = true;
    update();
    bool editStudentHasBeenAdded = false;
    int schoolId = Hive.box('School').get('Id');

    ResponseHandler<StudentResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
        path: "${StudentsLinks.student}/$studentid",
        converter: StudentResModel.fromJson,
        type: ReqTypeEnum.PATCH,
        body: {
          "Grades_ID": gradesId,
          "Schools_ID": schoolId,
          "Cohort_ID": cohortId,
          "School_Class_ID": schoolClassId,
          "First_Name": firstName,
          "Second_Name": secondName,
          "Third_Name": thirdName,
          "Created_By": _userProfile?.iD,
          "Second_Lang": secondLang,
          "Religion": religion,
        });

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      editStudentHasBeenAdded = false;
    }, (result) {
      getStudents();
      editStudentHasBeenAdded = true;
    });
    islodingEditStudent = false;
    update();
    return editStudentHasBeenAdded;
  }

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

  void setSelectedItemClassRoom(List<ValueItem> items) {
    selectedItemClassRoom = items.first;
    update();
  }

  void setSelectedItemCohort(List<ValueItem> items) {
    selectedItemCohort = items.first;
    update();
  }

  void setSelectedItemGrade(List<ValueItem> items) {
    selectedItemGrade = items.first;
    update();
  }

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

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
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

    if (rowsAsListOfValues.isNotEmpty && rowsAsListOfValues[0].length > 7) {
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
      } else if (isImportedPromot == true) {
        result = studentsCsv.convertPromtoFileStudentsToPluto(
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
