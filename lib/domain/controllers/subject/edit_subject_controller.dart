import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/school/school_type/school_type_model.dart';
import '../../../Data/Models/school/school_type/schools_type_res_model.dart';
import '../../../Data/Models/subject/subject_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class EditSubjectsController extends GetxController {
  bool addLoading = false;
  bool editLoading = false;
  bool getAllLoading = false;
  bool getSchoolTypeLoading = false;
  List<SubjectResModel> subjects = <SubjectResModel>[];
  List<SchoolTypeResModel> schoolsType = <SchoolTypeResModel>[];
  RxBool inExam = true.obs;
  List<int> selectedSchoolTypeIds = <int>[];
  List<int> initialSelectedSchoolTypeIds = <int>[];

  Future<bool> editSubject({
    required int id,
    required List schholTypeIds,
    required String name,
    required int inexam,
    required int active,
  }) async {
    editLoading = true;
    update();
    bool subjectHasBeenUpdated = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response =
        await responseHandler.getResponse(
      path: '${SubjectsLinks.subjects}/$id',
      converter: SubjectResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: {
        "Name": name,
        'schools_type_ID': schholTypeIds,
        "InExam": inexam,
        "Active": active
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
        subjectHasBeenUpdated = true;
        update();
      },
    );
    editLoading = false;
    update();
    return subjectHasBeenUpdated;
  }

  Future<bool> deleteSchoolTypeInSubject({
    required int idSubject,
    required int idSchoolType,
  }) async {
    editLoading = true;
    update();
    bool subjectHasBeenUpdated = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response =
        await responseHandler.getResponse(
      path:
          '${SubjectsLinks.deleteSchoolTypeinSubjects}/$idSubject/$idSchoolType',
      converter: SubjectResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: {},
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
        subjectHasBeenUpdated = true;
        update();
      },
    );
    editLoading = false;
    update();
    return subjectHasBeenUpdated;
  }

  Future<void> getSchoolType() async {
    getSchoolTypeLoading = true;
    update();
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
        schoolsType = r.data!;
      },
    );
    getSchoolTypeLoading = false;
    update();
  }

  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedSchoolTypeIds =
        selectedOptions.map((e) => e.value).toList().cast<int>();
    update();
  }


  @override
  void onInit() {
    getSchoolType();
    super.onInit();
  }
}
