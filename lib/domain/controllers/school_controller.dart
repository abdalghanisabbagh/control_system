import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/school/grade_response/grade_res_model.dart';
import 'package:control_system/Data/Models/school/grade_response/grades_res_model.dart';
import 'package:control_system/Data/Models/school/school_response/school_res_model.dart';
import 'package:control_system/Data/Models/school/school_response/schools_res_model.dart';
import 'package:control_system/Data/Network/tools/failure_model.dart';
import 'package:control_system/Data/enums/req_type_enum.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../Data/Network/response_handler.dart';

class SchoolController extends GetxController {
  List<SchoolResModel> schools = <SchoolResModel>[];
  List<GradeResModel> grades = <GradeResModel>[];
  List schoolType = [];
  bool isLoadingSchools = false;
  bool isLoadingGrades = false;
  bool isLoadingAddGrades = false;
  bool gradeHasBeenAdded = false;

  RxList<ValueItem> selectedOptions = <ValueItem>[].obs;
  int selectedSchoolIndex = (-1);
  int selectedSchoolId = (-1);
  String selectedSchoolName = "";

  void updateSelectedSchool(int index, int id) {
    selectedSchoolIndex = index;
    selectedSchoolId = id;
    selectedSchoolName = schools[index].name!;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllSchools();
  }

  addNewSchoolType({
    required String schoolType,
  }) async {}

  getSchoolTypes() async {}

  addNewSchool() async {}
  getSchool() async {}

  Future<bool> getAllSchools() async {
    isLoadingSchools = true;
    update();
    ResponseHandler<SchoolsResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: SchoolsLinks.getAllSchools,
      converter: SchoolsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((fauilr) {
      /// handel error
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }, (result) {
// handel el response

      schools = result.data!;
      isLoadingSchools = false;
      update();
    });

    isLoadingSchools = false;
    return true;
  }

  Future<bool> getGradesBySchoolId() async {
    isLoadingGrades = true;
    update();
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: "${SchoolsLinks.gradesSchools}/${selectedSchoolId}",
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((fauilr) {
      /// handel error
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }, (result) {
// handel el response

      grades = result.data!;
      isLoadingGrades = false;
      update();
    });
    isLoadingGrades = false;

    return true;
  }

  Future<bool> addNewGrade({
    required String name,
  }) async {
    isLoadingAddGrades = true;
    bool gradeHasBeenAdded = false;
    ResponseHandler<GradeResModel> responseHandler = ResponseHandler();
    Either<Failure, GradeResModel> response = await responseHandler.getResponse(
      path: SchoolsLinks.grades,
      converter: GradeResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Schools_ID": selectedSchoolId,
        "Name": name,
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        gradeHasBeenAdded = false;
      },
      (r) {
        // spread operator to add new grade
        grades = [...grades, r];
        gradeHasBeenAdded = true;
        isLoadingAddGrades = false;
        update();
      },
    );

    isLoadingAddGrades = false;
    return gradeHasBeenAdded;
  }
}
