import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/subject/subject_res_model.dart';
import 'package:control_system/Data/Models/subject/subjects_res_model.dart';
import 'package:control_system/Data/Network/response_handler.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class SubjectsController extends GetxController {
  List<SubjectResModel> subjects = <SubjectResModel>[];
  // RxList<SubjectResModel> subjectsController = <SubjectResModel>[].obs;
  RxBool addLoading = false.obs;

  Future getAllSubjects() async {
    ResponseHandler<SubjectsResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectsResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.subjects,
      converter: SubjectsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) => MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!),
      (r) {
        subjects = r.data!;
        update();
      },
    );
  }

  Future<bool> addNewSubject({
    required String name,
    // required String title,
    // required bool inExam,
  }) async {
    bool subjectHasBeenAdded = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.subjects,
      converter: SubjectResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Name": name,
        "Created_By": 1,
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
    await getAllSubjects();
    return subjectHasBeenAdded;
  }

  @override
  void onInit() {
    getAllSubjects();
    super.onInit();
  }
}
