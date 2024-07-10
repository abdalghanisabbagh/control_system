import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../../Data/Models/cohort/cohorts_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/student/student_res_model.dart';
import '../../../Data/Models/user/login_response/user_profile_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import '../profile_controller.dart';
import 'student_controller.dart';

class AddNewStudentController extends GetxController {
  StudentController studentController = Get.find<StudentController>();

  final UserProfileModel? _userProfile =
      Get.find<ProfileController>().cachedUserProfile;

  bool checkSelecteClassRoom = false;
  bool checkSelecteCohort = false;
  bool checkSelecteGrade = false;
  bool isLoading = false;
  bool isLodingAddStudent = false;
  List<ValueItem> optionsClassRoom = <ValueItem>[];
  List<ValueItem> optionsCohort = <ValueItem>[];
  List<ValueItem> optionsGrades = <ValueItem>[];
  ValueItem? selectedItemClassRoom;
  ValueItem? selectedItemCohort;
  ValueItem? selectedItemGrade;

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
      cohortHasBeenAdded = true;
    });
    update();
    return cohortHasBeenAdded;
  }

  Future<bool> addNewStudent({
    required int blubID,
    required int gradesId,
    required int cohortId,
    required int schoolClassId,
    required String firstName,
    required String secondName,
    required String thirdName,
    required String secondLang,
  }) async {
    isLodingAddStudent = true;

    update();
    bool addStudentHasBeenAdded = false;
    int schoolId = Hive.box('School').get('Id');
    ResponseHandler<StudentResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
        path: StudentsLinks.student,
        converter: StudentResModel.fromJson,
        type: ReqTypeEnum.POST,
        body: {
          "Blb_Id": blubID,
          "Grades_ID": gradesId,
          "Schools_ID": schoolId,
          "Cohort_ID": cohortId,
          "School_Class_ID": schoolClassId,
          "First_Name": firstName,
          "Second_Name": secondName,
          "Third_Name": thirdName,
          "Created_By": _userProfile?.iD,
          "Second_Lang": secondLang
        });

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      addStudentHasBeenAdded = false;
    }, (result) {
      studentController.getStudents();
      addStudentHasBeenAdded = true;
    });
    isLodingAddStudent = false;

    update();
    return addStudentHasBeenAdded;
  }
}
