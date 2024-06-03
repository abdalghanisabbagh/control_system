import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/class_room/classes_rooms_res_model.dart';
import 'package:control_system/Data/Models/cohort/cohorts_res_model.dart';
import 'package:control_system/Data/Models/school/grade_response/grades_res_model.dart';
import 'package:control_system/Data/Models/student/student_model.dart';
import 'package:control_system/Data/enums/req_type_enum.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Network/response_handler.dart';

class AddNewStudentController extends GetxController {
  bool isLoading = false;
  List<ValueItem> optionsGrades = <ValueItem>[];
  List<ValueItem> optionsCohort = <ValueItem>[];
  List<ValueItem> optionsClassRoom = <ValueItem>[];
  ValueItem? selectedItemGrade;
  ValueItem? selectedItemCohort;
  ValueItem? selectedItemClassRoom;
  bool checkSelecteGrade = false;
  bool checkSelecteCohort = false;
  bool checkSelecteClassRoom = false;

  @override
  void onInit() async {
    super.onInit();
    isLoading = true;
    update();
    await Future.wait([
      getGradesBySchoolId(),
      getCohortBySchoolTypeId(),
      getSchoolsClassBySchoolId()
    ]);
    isLoading = false;
    update();
  }

  bool checkGradeValidation() {
    checkSelecteGrade = true;

    update();
    return checkSelecteGrade;
  }

  bool checkChortValidation() {
    checkSelecteCohort = true;

    update();
    return checkSelecteGrade;
  }

  bool checkClassRoomValidation() {
    checkSelecteClassRoom = true;
    update();
    return checkSelecteGrade;
  }

  Future<bool> getGradesBySchoolId() async {
    update();
    bool gradeHasBeenAdded = false;

    int schoolId = Hive.box('School').get('Id');
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: "${SchoolsLinks.gradesSchools}/$schoolId",
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      gradeHasBeenAdded = false;
    }, (result) {
      List<ValueItem> items = result.data!
          .map((item) => ValueItem(label: item.name!, value: item.iD))
          .toList();
      optionsGrades = items;
    });
    gradeHasBeenAdded = true;
    update();
    return gradeHasBeenAdded;
  }

  Future<bool> getSchoolsClassBySchoolId() async {
    update();
    bool classRoomHasBeenAdded = false;

    int schoolId = Hive.box('School').get('Id');
    ResponseHandler<ClassesRoomsResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: "${SchoolsLinks.getSchoolsClassesBySchoolId}/$schoolId",
      converter: ClassesRoomsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      classRoomHasBeenAdded = false;
    }, (result) {
      List<ValueItem> items = result.data!
          .map((item) => ValueItem(label: item.name!, value: item.iD))
          .toList();
      optionsClassRoom = items;
    });
    classRoomHasBeenAdded = true;
    update();
    return classRoomHasBeenAdded;
  }

  void setSelectedItemGrade(List<ValueItem> items) {
    selectedItemGrade = items.first;
    update();
  }

  void setSelectedItemCohort(List<ValueItem> items) {
    selectedItemCohort = items.first;
    update();
  }

  void setSelectedItemClassRoom(List<ValueItem> items) {
    selectedItemClassRoom = items.first;
    update();
  }

  Future<bool> getCohortBySchoolTypeId() async {
    update();
    bool cohortHasBeenAdded = false;

    int selectedSchoolId = Hive.box('School').get('SchoolTypeID');
    ResponseHandler<CohortsResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: "${SchoolsLinks.getCohortBySchoolType}/$selectedSchoolId",
      converter: CohortsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      cohortHasBeenAdded = false;
    }, (result) {
      List<ValueItem> items = result.data!
          .map((item) => ValueItem(label: item.name!, value: item.iD))
          .toList();
      optionsCohort = items;
    });
    cohortHasBeenAdded = true;
    update();
    return cohortHasBeenAdded;
  }

  Future<bool> postAddNewStudent({
    required int gradesId,
    required int cohortId,
    required int schoolClassId,
    required String firstName,
    required String secondName,
    required String thirdName,
  }) async {
    update();
    bool addStudentHasBeenAdded = false;
    int schoolId = Hive.box('School').get('Id');
    int createdBy = Hive.box('Profile').get('ID');

    ResponseHandler<StudentMoodel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
        path: StudentsLinks.student,
        converter: StudentMoodel.fromJson,
        type: ReqTypeEnum.POST,
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
      addStudentHasBeenAdded = false;
    }, (result) {});
    addStudentHasBeenAdded = true;
    update();
    return addStudentHasBeenAdded;
  }
}
