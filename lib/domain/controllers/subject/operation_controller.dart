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

  /// Gets all subjects from the server and updates the UI
  ///
  /// This function sends a GET request to the server to get all subjects
  /// and updates the [subjects] list with the subjects returned by the server.
  ///
  /// The function also updates the UI to show a loading indicator while
  /// the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog
  /// with the failure message.
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

  /// Calls [getAllSubjects] to get all subjects from the server
  /// and then calls [onInit] of the superclass.
  void onInit() {
    getAllSubjects();
    super.onInit();
  }
}
