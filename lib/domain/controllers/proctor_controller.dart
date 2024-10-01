import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../Data/Models/education_year/education_year_model.dart';
import '../../Data/Models/education_year/educations_years_res_model.dart';
import '../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../Data/Models/exam_room/exam_rooms_res_model.dart';
import '../../Data/Models/proctor/proctor_in_exam_room_res_model.dart';
import '../../Data/Models/proctor/proctor_res_model.dart';
import '../../Data/Models/proctor/proctors_in_exam_room.dart';
import '../../Data/Models/proctor/proctors_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../app/extensions/date_time_extension.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';
import 'profile_controller.dart';

class ProctorController extends GetxController {
  final TextEditingController confirmPasswordController =
      TextEditingController();

  List<ControlMissionResModel> controlMissions = [];
  bool controlMissionsAreLoading = false;
  final dateController = TextEditingController();
  List<EducationYearModel> educationYears = [];
  List<ExamRoomResModel> examRooms = [];
  bool examRoomsAreLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  bool isLoading = false;
  final TextEditingController nisIdController = TextEditingController();
  List<ValueItem> optionsControlMissions = [];
  List<ValueItem> optionsEducationYear = [];
  final TextEditingController passwordController = TextEditingController();
  List<ProctorInExamRoomResModel> proctorHasExamRooms = [];
  List<ProctorResModel> proctors = [];
  List<ProctorInExamRoomResModel> proctorsInExamRoom = [];
  final int schoolId = Hive.box('School').get('Id');
  int? selectedControlMissionsId;
  DateTime? selectedDate;
  int? selectedEducationYearId;
  ExamRoomResModel? selectedExamRoom;
  ProctorResModel? selectedProctor;
  bool showPassword = true;
  bool showConfirmPassword = true;
  final TextEditingController usernameController = TextEditingController();

  Future<bool> assignProctorToExamRoom({required bool period}) async {
    isLoading = true;
    bool isSuccess = false;
    update(['examRooms', 'assignProctorToExamRoom']);
    final response = await ResponseHandler<ProctorInExamRoomResModel>()
        .getResponse(
            path: "${ProctorsLinks.proctor}/assign",
            converter: ProctorInExamRoomResModel.fromJson,
            type: ReqTypeEnum.POST,
            body: {
          "proctors_ID": selectedProctor?.iD,
          "exam_room_ID": selectedExamRoom?.id,
          "Month": selectedExamRoom!
              .controlMissionResModel!.examMissionsResModel!.data!
              .firstWhere((exam) =>
                  exam.month ==
                  '${selectedDate?.day} ${selectedDate?.toMonthName}')
              .month
              .toString(),
          "Year": selectedExamRoom!
              .controlMissionResModel!.examMissionsResModel!.data!
              .firstWhere((exam) => exam.year == '${selectedDate?.year}')
              .year
              .toString(),
          "Period": period,
          "Created_By": Get.find<ProfileController>().cachedUserProfile?.iD,
        });

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        isSuccess = true;
        getProctors();
        getExamRoomByControlMissionId();
      },
    );

    isLoading = false;
    update(['examRooms', 'assignProctorToExamRoom']);

    return isSuccess;
  }

  bool canAssignProctorToExamRoom() {
    return selectedProctor != null &&
        selectedExamRoom != null &&
        selectedControlMissionsId != null &&
        selectedEducationYearId != null &&
        selectedExamRoom!.controlMissionResModel!.examMissionsResModel!.data!
                .firstWhereOrNull((exam) =>
                    exam.month ==
                    '${selectedDate?.day} ${selectedDate?.toMonthName}') !=
            null;
  }

  Future<bool> createNewProctor() async {
    bool createdSuccessfully = false;
    isLoading = true;
    update(
      [
        'createNewProctor',
      ],
    );
    ResponseHandler<ProctorResModel> responseHandler = ResponseHandler();
    Either<Failure, ProctorResModel> response =
        await responseHandler.getResponse(
      path: ProctorsLinks.proctor,
      converter: ProctorResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Full_Name": fullNameController.text,
        "User_Name": usernameController.text,
        "Password": passwordController.text,
        "Created_By": Get.find<ProfileController>().cachedUserProfile?.iD,
      },
    );
    isLoading = false;
    update(
      [
        'createNewProctor',
      ],
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        createdSuccessfully = false;
      },
      (r) {
        getProctors();
        createdSuccessfully = true;
      },
    );
    update(
      [
        'createNewProctor',
      ],
    );

    fullNameController.clear();
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nisIdController.clear();

    return createdSuccessfully;
  }

  Future<bool> editProctor(int proctorId) async {
    bool editedSuccessfully = false;
    isLoading = true;
    update(
      [
        'updateProctor',
      ],
    );
    ResponseHandler<ProctorResModel> responseHandler = ResponseHandler();
    Either<Failure, ProctorResModel> response =
        await responseHandler.getResponse(
      path: "${ProctorsLinks.proctor}/$proctorId",
      converter: ProctorResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: {
        "Full_Name": fullNameController.text,
        "User_Name": usernameController.text,
        "Password": passwordController.text,
      },
    );
    isLoading = false;
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        editedSuccessfully = false;
      },
      (r) {
        getProctors();
        editedSuccessfully = true;
      },
    );
    update(
      [
        'updateProctor',
      ],
    );
    fullNameController.clear();
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nisIdController.clear();
    return editedSuccessfully;
  }

  Future<void> getControlMissionByEducationYearId() async {
    controlMissionsAreLoading = true;
    update(['proctorEntryScreen']);
    ResponseHandler<ControlMissionsResModel> responseHandler =
        ResponseHandler();
    Either<Failure, ControlMissionsResModel> response =
        await responseHandler.getResponse(
      path:
          "${ControlMissionLinks.controlMissionSchool}/$schoolId/${ControlMissionLinks.controlMissionEducationYear}/$selectedEducationYearId",
      converter: ControlMissionsResModel.fromJson,
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
        controlMissions = r.data!;
        optionsControlMissions.assignAll(
          controlMissions.map(
            (e) => ValueItem(
              label: e.name!,
              value: e.iD,
            ),
          ),
        );
      },
    );
    controlMissionsAreLoading = false;
    update(['proctorEntryScreen']);
    return;
  }

  Future<void> getEducationYears() async {
    final response = await ResponseHandler<EducationsYearsModel>().getResponse(
      path: EducationYearsLinks.educationYear,
      converter: EducationsYearsModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        educationYears = r.data!;
        optionsEducationYear.assignAll(
          educationYears.map(
            (item) => ValueItem(label: item.name!, value: item.id),
          ),
        );
      },
    );
    update();
  }

  Future<void> getExamRoomByControlMissionId() async {
    examRoomsAreLoading = true;
    update(['examRooms']);

    final response = await ResponseHandler<ExamRoomsResModel>().getResponse(
      path:
          "${ExamRoomLinks.examRoomsControlMission}/$selectedControlMissionsId",
      converter: ExamRoomsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        examRooms.assignAll(r.data!);
      },
    );
    examRoomsAreLoading = false;
    update(['examRooms']);
  }

  Future<void> getExamRoomsByProctorId({required int proctorId}) async {
    isLoading = true;
    update();

    final response =
        await ResponseHandler<ProctorsInExamRoomResModel>().getResponse(
      path: "${ExamRoomLinks.examRooms}/proctor/$proctorId",
      converter: ProctorsInExamRoomResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        proctorHasExamRooms.assignAll(r.data!);
      },
    );
    isLoading = false;
    update();
  }

  Future<bool> getProctors() async {
    bool gotData = false;
    isLoading = true;
    update(
      [
        'proctors',
      ],
    );
    ResponseHandler<ProctorsResModel> responseHandler = ResponseHandler();
    Either<Failure, ProctorsResModel> response =
        await responseHandler.getResponse(
      path: '${ProctorsLinks.proctor}/school',
      converter: ProctorsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        gotData = false;
      },
      (r) {
        proctors = r.data!;
        gotData = true;
      },
    );
    isLoading = false;
    proctors.length == 1
        ? update(
            [
              'proctorEntryScreen',
            ],
          )
        : update(
            [
              'proctors',
            ],
          );
    return gotData;
  }

  Future<void> getProctorsByExamRoomId({required int examRoomId}) async {
    isLoading = true;
    update();

    final response = await ResponseHandler<ProctorsInExamRoomResModel>()
        .getResponse(
            path: "${ProctorsLinks.proctor}/exam-room/$examRoomId",
            converter: ProctorsInExamRoomResModel.fromJson,
            type: ReqTypeEnum.GET,
            params: {
          "month": '${selectedDate?.day} ${selectedDate?.toMonthName}',
          "year": '${selectedDate?.year}',
        });

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        proctorsInExamRoom.assignAll(r.data!);
      },
    );
    isLoading = false;
    update();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nisIdController.dispose();
    super.onClose();
  }

  void onControlMissionsChange(List<ValueItem<dynamic>> selectedOptions) {
    selectedControlMissionsId = selectedOptions.firstOrNull?.value;
    selectedControlMissionsId != null
        ? {
            selectedDate = DateTime.tryParse(controlMissions
                .firstWhereOrNull(
                    (element) => element.iD == selectedControlMissionsId)!
                .startDate!),
            dateController.text =
                DateFormat('dd MMMM yyyy').format(selectedDate!),
            getExamRoomByControlMissionId(),
          }
        : {
            selectedDate = null,
            dateController.text = '',
          };
    selectedExamRoom = null;
    selectedProctor = null;
    examRooms = [];
    update(['proctorEntryScreen']);
  }

  Future<void> onDateSelected() async {
    getExamRoomByControlMissionId();
    return;
  }

  void onEducationYearChange(List<ValueItem<dynamic>> selectedOptions) {
    selectedEducationYearId = selectedOptions.firstOrNull?.value;
    selectedEducationYearId != null
        ? {
            getControlMissionByEducationYearId(),
          }
        : null;

    selectedControlMissionsId = null;
    selectedExamRoom = null;
    selectedProctor = null;
    examRooms = [];
    update(['proctorEntryScreen']);
  }

  @override
  void onInit() async {
    isLoading = true;
    update(
      [
        'proctorEntryScreen',
      ],
    );
    await Future.wait([
      getProctors(),
      getEducationYears(),
    ]);
    isLoading = false;
    update(
      [
        'proctorEntryScreen',
      ],
    );
    super.onInit();
  }

  Future<bool> unAssignProctorFromExamRoom({required int proctorId}) async {
    bool success = false;
    isLoading = true;
    update();

    final response = await ResponseHandler<void>().getResponse(
      path: "${ProctorsLinks.proctor}/unassign-from-exam-room/$proctorId",
      converter: (_) {},
      type: ReqTypeEnum.DELETE,
      body: {},
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
        success = false;
      },
      (r) {
        success = true;
        getExamRoomsByProctorId(proctorId: proctorId);
      },
    );
    isLoading = false;
    update();
    return success;
  }
}
