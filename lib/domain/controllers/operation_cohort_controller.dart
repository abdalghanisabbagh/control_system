import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../Data/Models/cohort/cohort_res_model.dart';
import '../../Data/Models/cohort/cohorts_res_model.dart';
import '../../Data/Models/school/school_type/schools_type_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class OperationCohortController extends GetxController {
  List<CohortResModel> cohorts = <CohortResModel>[];

  List<int> selectedSubjectsIds = <int>[];

  bool loadindCohorts = false;

  SchoolsTypeResModel? schoolsType;

  Future<bool> deleteCohort(int id) async {
    bool cohortHasBeenDeleted = false;
    ResponseHandler<CohortResModel> responseHandler = ResponseHandler();
    Either<Failure, CohortResModel> response =
        await responseHandler.getResponse(
      path: '${CohortLinks.cohort}/$id',
      converter: CohortResModel.fromJson,
      type: ReqTypeEnum.DELETE,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        cohortHasBeenDeleted = false;
      },
      (r) {
        getAllCohorts();
        cohortHasBeenDeleted = true;
        update();
      },
    );

    getAllCohorts();

    return cohortHasBeenDeleted;
  }

  Future getAllCohorts() async {
    loadindCohorts = true;
    update();
    final response = await ResponseHandler<CohortsResModel>().getResponse(
      path: CohortLinks.cohort,
      converter: CohortsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) => MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!),
      (r) {
        cohorts = r.data!;
        update();
      },
    );
    loadindCohorts = false;
    update();
  }

  Future<void> getAllSchoolTypes() async {
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
        schoolsType = r;
        update();
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    getAllCohorts();
    await getAllSchoolTypes();
  }
}
