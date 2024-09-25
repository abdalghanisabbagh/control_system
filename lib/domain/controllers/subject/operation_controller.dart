import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../Data/Models/subject/subject_res_model.dart';
import '../../../Data/Models/subject/subjects_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class OperationController extends GetxController {
  bool getAllLoading = false;
  List<SubjectResModel> subjects = <SubjectResModel>[].obs;

  Future getAllSubjects() async {
    getAllLoading = true;
    update();
    ResponseHandler<SubjectsResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectsResModel> response =
        await responseHandler.getResponse(
      path: SubjectsLinks.subjects,
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
        subjects.assignAll(r.data!);
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
