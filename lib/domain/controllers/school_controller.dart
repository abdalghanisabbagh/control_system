import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../Data/Models/school/school_response/school_res_model.dart';
// import '../../Data/Models/school/school_response/schools_res_model.dart';
import '../../Data/Models/school/school_type/schools_type_res_model.dart';
import '../../Data/Models/token/token_model.dart';
import '../../Data/Models/user/login_response/login_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import '../services/token_service.dart';
import 'profile_controller.dart';

class SchoolController extends GetxController {
  List<GradeResModel> grades = <GradeResModel>[];
  bool isLoading = false;
  bool isLoadingAddGrades = true;
  bool isLoadingAddSchool = false;
  bool isLoadingGrades = false;
  bool isLoadingSchools = false;
  List<ValueItem> options = <ValueItem>[];
  List schoolType = [];
  List<SchoolResModel> schools = <SchoolResModel>[];
  ValueItem? selectedItem;
  int selectedSchoolId = (-1);
  int selectedSchoolIndex = (-1);
  String selectedSchoolName = "";

  Future<bool> addNewGrade({
    required String name,
  }) async {
    isLoadingAddGrades = true;
    update();
    bool gradeHasBeenAdded = false;
    ResponseHandler<GradeResModel> responseHandler = ResponseHandler();
    Either<Failure, GradeResModel> response = await responseHandler.getResponse(
      path: GradeLinks.grades,
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
      },
    );

    gradeHasBeenAdded = true;
    isLoadingAddGrades = false;
    update();
    return gradeHasBeenAdded;
  }

  Future<bool> addNewSchool({
    required int schoolTypeId,
    required String name,
  }) async {
    isLoadingAddSchool = true;
    update();
    bool schoolHasBeenAdded = false;
    ResponseHandler<SchoolResModel> responseHandler = ResponseHandler();
    Either<Failure, SchoolResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.schools,
      converter: SchoolResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "School_Type_ID": schoolTypeId,
        "Name": "($name)",
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        schoolHasBeenAdded = false;
      },
      (r) {
        onInit();
      },
    );
    schoolHasBeenAdded = true;
    isLoadingAddGrades = false;
    update();
    return schoolHasBeenAdded;
  }

  Future<void> deleteFromSchoolBox() async {
    await Hive.box('School').clear();
  }

  Future<bool> getGradesBySchoolId() async {
    isLoadingGrades = true;
    update();
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: "${GradeLinks.gradesSchools}/$selectedSchoolId",
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

  Future<bool> getSchoolType() async {
    ResponseHandler<SchoolsTypeResModel> responseHandler = ResponseHandler();
    Either<Failure, SchoolsTypeResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.schoolsType,
      converter: SchoolsTypeResModel.fromJson,
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
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        options = items;
      },
    );
    isLoadingAddGrades = false;
    update();
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    getSchoolType();
  }

  Future<void> saveToSchoolBox(SchoolResModel currentSchool) async {
    TokenService tokenService = Get.find<TokenService>();
    ProfileController profileController = Get.find<ProfileController>();
    await ResponseHandler<void>().getResponse(
      path:
          '${UserLinks.users}/${Get.find<ProfileController>().cachedUserProfile!.iD}',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: {
        "LastSelectSchoolId": currentSchool.iD,
      },
    );
    ResponseHandler<LoginResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: AuthLinks.getNewAccessToken,
      converter: LoginResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) => MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!),
      (r) {
        tokenService.saveTokenModelToHiveBox(TokenModel(
          aToken: r.accessToken!,
          rToken: r.refreshToken!,
          dToken: DateTime.now().toIso8601String(),
        ));
        profileController.saveProfileToHiveBox(r.userProfile!);
      },
    );
    await Future.wait(
      [
        Hive.box('School').put('Id', currentSchool.iD),
        Hive.box('School').put('Name', currentSchool.name),
        Hive.box('School').put('SchoolTypeID', currentSchool.schoolTypeID),
      ],
    );
    await Hive.box('School').flush();
  }

  void setSelectedItem(ValueItem? item) {
    selectedItem = item;
    update();
  }

  void updateSelectedSchool(int index, int id, String name) {
    selectedSchoolIndex = index;
    selectedSchoolId = id;
    selectedSchoolName = name;
    update();
  }
}
