import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/subject/subject_res_model.dart';
import '../../Data/Models/subject/subjects_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class SubjectsController extends GetxController {
  List<SubjectResModel> subjects = <SubjectResModel>[];
  // RxList<SubjectResModel> subjectsController = <SubjectResModel>[].obs;
  bool addLoading = false;
  bool getAllLoading = false;

  Future getAllSubjects() async {
    getAllLoading = true;
    update();
    ResponseHandler<SubjectsResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectsResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.subjects,
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
        "Created_By": Hive.box('Profile').get('ID'),
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
        subjects = [...subjects, r];
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
        subjects.removeWhere((element) => element.iD == id);
        subjectHasBeenDeleted = true;
        update();
      },
    );
    return subjectHasBeenDeleted;
  }

  @override
  void onInit() {
    getAllSubjects();
    super.onInit();
  }
}
