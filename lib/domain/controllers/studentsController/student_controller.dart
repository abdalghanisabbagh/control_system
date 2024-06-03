import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/class_room/class_room_res_model.dart';
import 'package:control_system/Data/Models/class_room/classes_rooms_res_model.dart';
import 'package:control_system/Data/Models/cohort/cohort_res_model.dart';
import 'package:control_system/Data/Models/school/grade_response/grade_res_model.dart';
import 'package:control_system/Data/Models/school/grade_response/grades_res_model.dart';
import 'package:control_system/Data/Models/student/students_res_model.dart';
import 'package:control_system/app/extensions/pluto_row_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../Data/Models/cohort/cohorts_res_model.dart';
import '../../../Data/Models/student/student_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class StudentController extends GetxController {
  List<StudentResModel> students = <StudentResModel>[];
  List<PlutoRow> studentsRows = <PlutoRow>[];
  List<CohortResModel> cohorts = <CohortResModel>[];
  List<ClassRoomResModel> classRooms = <ClassRoomResModel>[];
  List<GradeResModel> grades = <GradeResModel>[];
  List<ValueItem> optionsCohort = <ValueItem>[];
  List<ValueItem> optionsClassRoom = <ValueItem>[];
  List<ValueItem> optionsGrade = <ValueItem>[];
  ValueItem? selectedItemGrade;
  ValueItem? selectedItemCohort;
  ValueItem? selectedItemClassRoom;

  bool loading = false;

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
  }) async {
    loading = true;
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
          "Created_By": createdBy
        });

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      editStudentHasBeenAdded = false;
    }, (result) {
      editStudentHasBeenAdded = true;
    });
    loading = false;
    update();
    return editStudentHasBeenAdded;
  }

  @override
  void onInit() async {
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
}
