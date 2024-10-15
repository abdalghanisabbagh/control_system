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

  /// Assign a proctor to an exam room.
  ///
  /// The function takes a boolean parameter [period] which determines if the proctor is assigned to the morning period or the evening period.
  ///
  /// The function assigns the proctor to the exam room and updates the UI.
  ///
  /// The function returns a boolean indicating whether the assignment was successful or not.
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

  /// Whether the proctor can be assigned to the exam room.
  ///
  /// This checks that the following are not null:
  ///
  /// - [selectedProctor]
  /// - [selectedExamRoom]
  /// - [selectedControlMissionsId]
  /// - [selectedEducationYearId]
  /// - [selectedExamRoom]'s control mission's exam mission with the current month
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

  /// Creates a new proctor with the given details and updates the UI.
  ///
  /// The function takes no parameters.
  ///
  /// The function will show an error dialogue if the response is a failure.
  ///
  /// The function will also clear all the text fields.
  ///
  /// The function will return a boolean indicating whether the creation was successful or not.
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

  /// Edits a proctor in the server and updates the UI.
  ///
  /// The function takes the [proctorId] of the proctor to be edited as a parameter.
  ///
  /// The function will show an error dialogue if the response is a failure.
  ///
  /// The function will also update the UI to show that the proctor has been edited
  /// in the server.
  ///
  /// The function returns a boolean indicating whether the proctor was edited
  /// successfully.
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

  /// Gets all the control missions for the selected education year and school.
  ///
  /// It sets the [controlMissionsAreLoading] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is successful, it updates the [controlMissions] with the
  /// control missions returned by the API and sets the [optionsControlMissions]
  /// with the control missions.
  ///
  /// The function is used when the user selects an education year in the
  /// proctor entry screen.
  Future<void> getControlMissionByEducationYearId() async {
    controlMissionsAreLoading = true;
    update(['proctorEntryScreen']);
    ResponseHandler<ControlMissionsResModel> responseHandler =
        ResponseHandler();
    Either<Failure, ControlMissionsResModel> response =
        await responseHandler.getResponse(
      path:
          "${ControlMissionLinks.controlMissionActiveSchool}/$schoolId/${ControlMissionLinks.controlMissionEducationYear}/$selectedEducationYearId",
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

  /// Gets all education years from the API and sets the [optionsEducationYear]
  /// with the education years returned by the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is successful, it updates the [optionsEducationYear] with
  /// the education years returned by the API.
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

  /// Gets all the exam rooms for the selected control mission from the API and
  /// sets the [examRooms] with the exam rooms returned by the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is successful, it updates the [examRooms] with the exam
  /// rooms returned by the API.
  ///
  /// The function takes no parameters and returns a Future that completes when
  /// the request is finished.
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

  /// Gets all the exam rooms for a given proctor ID from the API and sets the
  /// [proctorHasExamRooms] with the exam rooms returned by the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is successful, it updates the [proctorHasExamRooms] with
  /// the exam rooms returned by the API.
  ///
  /// The function takes a required [proctorId] parameter and returns a Future
  /// that completes when the request is finished.
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

  /// Gets all the proctors in a given school from the API and sets the
  /// [proctors] with the proctors returned by the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is successful, it updates the [proctors] with the proctors
  /// returned by the API.
  ///
  /// The function returns a boolean indicating whether the proctors were
  /// retrieved successfully.
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

  /// Gets all the proctors in a given exam room from the API and sets the
  /// [proctorsInExamRoom] with the proctors returned by the API.
  ///
  /// It sets the [isLoading] variable to true and then to false depending on
  /// the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// The function is used when the user navigates to the distribute proctors
  /// page.
  ///
  /// The function takes the [examRoomId] of the exam room as a required
  /// parameter.
  ///
  /// The function returns a boolean indicating whether the proctors in the
  /// exam room were retrieved successfully.
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

  /// Called when the controller is closed. Disposes of all of the text editing
  /// controllers and calls the superclass [onClose].
  ///
  void onClose() {
    fullNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nisIdController.dispose();
    super.onClose();
  }

  /// Called when the selected control mission changes.
  ///
  /// This function is a callback function for the [DropdownButton] widget in the
  /// [ProctorEntryScreen] widget.
  ///
  /// It takes a list of selected [ValueItem]s as a parameter.
  ///
  /// If the selected options is not empty, it sets the [selectedControlMissionsId]
  /// to the ID of the first selected item and sets the [selectedDate] to the
  /// start date of the selected control mission. It also calls the
  /// [getExamRoomByControlMissionId] function to get the exam rooms for the
  /// selected control mission.
  ///
  /// If the selected options is empty, it sets the [selectedDate] to null and
  /// sets the [dateController] text to an empty string. It also sets the
  /// [selectedExamRoom] and [selectedProctor] to null and clears the
  /// [examRooms] list.
  ///
  /// The function updates the UI to show the changes.
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

  /// Called when the user selects a date in the date picker dialog.
  ///
  /// This function is a callback function for the [showDatePicker] function.
  ///
  /// It calls the [getExamRoomByControlMissionId] function to get the exam rooms
  /// for the selected date.
  ///
  /// The function updates the UI to show the changes.
  Future<void> onDateSelected() async {
    getExamRoomByControlMissionId();
    return;
  }

  /// Called when the user selects an education year in the dropdown.
  ///
  /// This function is a callback function for the [DropdownButton] widget.
  ///
  /// It sets the [selectedEducationYearId] with the selected education year ID.
  /// If the selected education year ID is not null, it calls the
  /// [getControlMissionByEducationYearId] function to get the control missions for
  /// the selected education year. It also sets the [selectedControlMissionsId],
  /// [selectedExamRoom], and [selectedProctor] to null, and clears the
  /// [examRooms] list. Finally, it updates the UI to show the changes.
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

  /// Called when the widget is initialized.
  ///
  /// The function sets the [isLoading] variable to true, updates the UI to show
  /// the loading indicator, calls the [getProctors] and [getEducationYears]
  /// functions to retrieve the proctors and education years, sets the
  /// [isLoading] variable to false, and updates the UI to show the changes.
  ///
  /// Finally, it calls the [super.onInit] function to perform the default
  /// initialization of the widget.
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

  /// Unassigns a proctor from an exam room.
  ///
  /// The function takes the [proctorId] of the proctor to be unassigned as a
  /// parameter.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is successful, it updates the [examRooms] list and sets the
  /// [isLoading] variable to false. It also updates the UI to show the changes.
  ///
  /// The function returns a boolean indicating whether the proctor was unassigned
  /// successfully.
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
