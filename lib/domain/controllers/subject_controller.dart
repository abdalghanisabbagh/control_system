import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/subject/subject_res_model.dart';
import '../../Data/Models/subject/subjects_res_model.dart';
import '../../Data/Models/user/login_response/user_profile_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'profile_controller.dart';

class SubjectsController extends GetxController {
  bool addLoading = false;
  bool getAllLoading = false;
  List<SubjectResModel> subjects = <SubjectResModel>[];

  final UserProfileModel? _userProfile =
      Get.find<ProfileController>().cachedUserProfile;

  Future<bool> addNewSubject({
    required String name,
    // required String title,
    // required bool inExam,
  }) async {
    addLoading = true;
    update();
    bool subjectHasBeenAdded = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.subjects,
      converter: SubjectResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Name": name,
        "Created_By": _userProfile?.iD,
        // "title": title,
        // "inExam": inExam,
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        subjectHasBeenAdded = false;
      },
      (r) {
        getAllSubjects();
        subjectHasBeenAdded = true;
        update();
      },
    );
    // getSubjectsFromServerbyGradeId();
    addLoading = false;
    update();
    return subjectHasBeenAdded;
  }

  Future<bool> deleteSubject({required int id}) async {
    bool subjectHasBeenDeleted = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response =
        await responseHandler.getResponse(
      path: '${SchoolsLinks.subjects}/$id',
      converter: SubjectResModel.fromJson,
      type: ReqTypeEnum.DELETE,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        subjectHasBeenDeleted = false;
      },
      (r) {
        getAllSubjects();
        update();
      },
    );
    return subjectHasBeenDeleted;
  }

  Future<bool> editSubject({
    required int id,
    required String name,
    // required String title,
    // required bool inExam,
  }) async {
    addLoading = true;
    update();
    bool subjectHasBeenUpdated = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response =
        await responseHandler.getResponse(
      path: '${SchoolsLinks.subjects}/$id',
      converter: SubjectResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: {
        "Name": name,
        "Created_By": _userProfile?.iD,
        // "title": title,
        // "inExam": inExam,
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        subjectHasBeenUpdated = false;
      },
      (r) {
        getAllSubjects();
        subjectHasBeenUpdated = true;
        update();
      },
    );
    addLoading = false;
    update();
    return subjectHasBeenUpdated;
  }

  Future getAllSubjects() async {
    getAllLoading = true;
    update();
    ResponseHandler<SubjectsResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectsResModel> response =
        await responseHandler.getResponse(
      path: '${SchoolsLinks.subjectsBySchoolType}${Hive.box('School').get('SchoolTypeID')}'
          ,
      converter: SubjectsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        getAllLoading = false;
        update();
      },
      (r) {
        subjects = r.data!;
        getAllLoading = false;
        update();
      },
    );
  }

  @override
  void onInit() {
    getAllSubjects();
    super.onInit();
  }
}
