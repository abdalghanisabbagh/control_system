import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/school/school_type/school_type_model.dart';
import '../../../Data/Models/school/school_type/schools_type_res_model.dart';
import '../../../Data/Models/subject/subject_res_model.dart';
import '../../../Data/Models/subject/subjects_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class SubjectsController extends GetxController {
  bool addLoading = false;
  bool editLoading = false;
  bool getAllLoading = false;
  bool getSchoolTypeLoading = false;
  RxBool inExam = true.obs;
  List<SchoolTypeResModel> schoolsType = <SchoolTypeResModel>[];
  List<int> selectedSchoolTypeIds = <int>[];
  List<SubjectResModel> subjects = <SubjectResModel>[];

  Future<bool> addNewSubject({
    required String name,
    required bool inExam,
    required List schholTypeIds,
  }) async {
    addLoading = true;
    update();
    bool subjectHasBeenAdded = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response =
        await responseHandler.getResponse(
      path: SubjectsLinks.subjects,
      converter: SubjectResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Name": name,
        "InExam": inExam ? 1 : 0,
        'schools_type_ID': schholTypeIds
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
    Either<Failure, SubjectResModel> response = await responseHandler
        .getResponse(
            path: '${SubjectsLinks.subjectsDeactivate}/$id',
            converter: SubjectResModel.fromJson,
            type: ReqTypeEnum.PATCH,
            body: {});
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
        subjectHasBeenDeleted = true;
      },
    );
    return subjectHasBeenDeleted;
  }

  Future<bool> editSubject({
    required int id,
    // required String name,
    required List schholTypeIds,
    // required int inExam,
    // required String title,
    // required bool inExam,
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
        //"Name": name,
        'schools_type_ID': schholTypeIds,
        "InExam": 1,
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
    editLoading = false;
    update();
    return subjectHasBeenUpdated;
  }

  Future getAllSubjects() async {
    getAllLoading = true;
    update();
    ResponseHandler<SubjectsResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectsResModel> response =
        await responseHandler.getResponse(
      path:
          '${SubjectsLinks.subjectsBySchoolType}${Hive.box('School').get('SchoolTypeID')}',
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

  @override
  void onInit() {
    getSchoolType();
    getAllSubjects();
    super.onInit();
  }

  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedSchoolTypeIds =
        selectedOptions.map((e) => e.value).toList().cast<int>();
    update();
  }
}
