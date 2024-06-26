import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../Data/Models/class_room/class_room_res_model.dart';
import '../../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../../Data/Models/cohort/cohort_res_model.dart';
import '../../../Data/Models/cohort/cohorts_res_model.dart';
import '../../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/student/student_res_model.dart';
import '../../../Data/Models/student/students_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../app/extensions/pluto_row_extension.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class StudentController extends GetxController {
  List<ClassRoomResModel> classRooms = <ClassRoomResModel>[];
  List<CohortResModel> cohorts = <CohortResModel>[];
  List<GradeResModel> grades = <GradeResModel>[];
  bool islodingEditStudent = false;
  bool loading = false;
  bool islodingAddStudents = false;
  List<ValueItem> optionsClassRoom = <ValueItem>[];
  List<ValueItem> optionsCohort = <ValueItem>[];
  List<ValueItem> optionsGrade = <ValueItem>[];
  ValueItem? selectedItemClassRoom;
  ValueItem? selectedItemCohort;
  ValueItem? selectedItemGrade;
  List<StudentResModel> students = <StudentResModel>[];
  List<PlutoRow> studentsRows = <PlutoRow>[];
  Map<String, bool> errorMap = {};
  bool isImported = false;
  bool hasErrorInGrade = false;
  bool hasErrorInCohort = false;
  bool hasErrorInClassRoom = false;

  @override
  void onInit() async {
    isImported = false;

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
        studentsRows = r.students!.convertStudentsToRows(
            classesRooms: classRooms, cohorts: cohorts, grades: grades);
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  Future<bool> getCohorts() async {
    bool gotData = false;
    update();
    int selectedSchoolId = Hive.box('School').get('SchoolTypeID');

    ResponseHandler<CohortsResModel> responseHandler = ResponseHandler();
    Either<Failure, CohortsResModel> response =
        await responseHandler.getResponse(
      path: "${SchoolsLinks.getCohortBySchoolType}/$selectedSchoolId",
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

  void setSelectedItemGrade(List<ValueItem> items) {
    selectedItemGrade = items.first;
    update();
  }

  void setSelectedItemClassRoom(List<ValueItem> items) {
    selectedItemClassRoom = items.first;
    update();
  }

  void setSelectedItemCohort(List<ValueItem> items) {
    selectedItemCohort = items.first;
    update();
  }

  Future<bool> getClassRooms() async {
    bool gotData = false;
    update();
    int schoolId = Hive.box('School').get('Id');

    ResponseHandler<ClassesRoomsResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassesRoomsResModel> response =
        await responseHandler.getResponse(
      path: "${SchoolsLinks.getSchoolsClassesBySchoolId}/$schoolId",
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

  Future<bool> getGrades() async {
    bool gotData = false;
    update();
    int schoolId = Hive.box('School').get('Id');

    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();
    Either<Failure, GradesResModel> response =
        await responseHandler.getResponse(
      path: "${SchoolsLinks.gradesSchools}/$schoolId",
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

  Future<bool> patchEditStudent({
    required int studentid,
    required int gradesId,
    required int cohortId,
    required int schoolClassId,
    required String firstName,
    required String secondName,
    required String thirdName,
    required String secondLang,
  }) async {
    islodingEditStudent = true;
    update();
    bool editStudentHasBeenAdded = false;
    int schoolId = Hive.box('School').get('Id');
    int createdBy = Hive.box('Profile').get('ID');

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
          "Created_By": createdBy,
          "Second_Lang": secondLang,
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
      //String? fileName = pickedFile.files.single.name;

      if (fileBytes != null) {
        readCsvFile(fileBytes,
            grades: grades, classesRooms: classRooms, cohorts: cohorts);
        // testCohort(fileBytes);
      }
    } else {
      debugPrint('No file selected');
    }
  }

  void readCsvFile(
    Uint8List fileBytes, {
    required List<CohortResModel> cohorts,
    required List<ClassRoomResModel> classesRooms,
    required List<GradeResModel> grades,
  }) {
    String content = String.fromCharCodes(fileBytes);
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(content);

    if (rowsAsListOfValues.isNotEmpty && rowsAsListOfValues.length > 7) {
      List<String> headers =
          rowsAsListOfValues.first.map((header) => header.toString()).toList();
      List<String> requiredHeaders = [
        'blbid',
        'firstname',
        'middlename',
        'lastname',
        'grade',
        'class',
        'cohort',
        'second_language'
      ];

      List<String> missingHeaders =
          requiredHeaders.where((header) => !headers.contains(header)).toList();
      if (missingHeaders.isNotEmpty) {
        MyAwesomeDialogue(
          title: 'Error',
          desc:
              'Missing headers: ${missingHeaders.join(', ')} \nPlease check the header values ​​in the file and try again.',
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      }
      rowsAsListOfValues.removeAt(0);

      students = rowsAsListOfValues
          .map((row) => StudentResModel.fromCsvWithHeaders(row, headers))
          .toList();

      final result = students.convertFileStudentsToPluto(
        cohorts: cohorts,
        classesRooms: classesRooms,
        grades: grades,
      );
      isImported = true;
      studentsRows = result['rows'];
      students = result['students'];
      hasErrorInGrade = result['errorgrade'];
      hasErrorInCohort = result['errorcohort'];
      hasErrorInClassRoom = result['errorclass'];
      update();
    } else {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "Please check the values ​​in the file and try again.",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }
    update();
  }

  Future<bool> addManyStudents({
    required List<StudentResModel> students,
  }) async {
    loading = true;
    bool addStudentsHasBeenAdded = false;
    update();
    List<Map<String, dynamic>> studentData =
        students.map((student) => student.test()).toList();

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
      isImported = false;
    });
    loading = false;

    update();
    return addStudentsHasBeenAdded;
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
}
