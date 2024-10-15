import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/class_room/class_room_res_model.dart';
import '../../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../../Data/Models/distribution_students_res_model.dart';
import '../../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../../Data/Models/exam_room/exam_rooms_res_model.dart';
import '../../../Data/Models/stage/stage_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class DistributionController extends GetxController {
  List<ClassRoomResModel> classRooms = [];
  int controlMissionId = 0;
  String controlMissionName = '';
  int distributedStudents = 0;
  bool isLoadingAddExamRoom = false;
  bool isLoadingDeleteClassRoom = false;
  bool isLoadingGetExamRooms = false;
  bool isLoadingGetStageAndClassRoom = false;
  List<ExamRoomResModel> listExamRoom = [];
  List<ValueItem> optionsClassRoom = <ValueItem>[];
  List<ValueItem> optionsStage = <ValueItem>[];
  ValueItem? selectedItemClassRoom;
  ValueItem? selectedItemStage;
  int totalStudents = 0;
  int unDistributedStudents = 0;

  /// Adds a new exam room to the database with the given parameters and returns a boolean indicating whether the add was successful.
  ///
  /// The function takes the following parameters:
  ///
  /// - [controlMissionId]: The ID of the control mission the exam room is being added to.
  /// - [schoolClassId]: The ID of the school class the exam room is being added to.
  /// - [name]: The name of the exam room.
  /// - [stage]: The stage of the exam room.
  ///
  /// The function will return a boolean indicating whether the add was successful.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  Future<bool> addNewExamRoom({
    required int controlMissionId,
    required int schoolClassId,
    required String name,
    required String stage,
  }) async {
    isLoadingAddExamRoom = true;

    bool addExamRoomHasBeenAdded = false;
    update();

    ResponseHandler<ExamRoomResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
        path: ExamRoomLinks.examRooms,
        converter: ExamRoomResModel.fromJson,
        type: ReqTypeEnum.POST,
        body: {
          "Control_Mission_ID": controlMissionId,
          "School_Class_ID": schoolClassId,
          "Name": name,
          "Stage": stage,
        });

    response.fold(
      (failure) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: "${failure.code} ::${failure.message}",
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isLoadingAddExamRoom = false;
        addExamRoomHasBeenAdded = false;
        update();
      },
      (result) {
        getExamRoomByControlMissionId();
        addExamRoomHasBeenAdded = true;
        isLoadingAddExamRoom = false;
      },
    );

    update();
    return addExamRoomHasBeenAdded;
  }

  /// Deletes an exam room from the database with the given ID and returns a boolean indicating whether the delete was successful.
  ///
  /// The function takes the following parameter:
  ///
  /// - [idExamRoom]: The ID of the exam room to be deleted.
  ///
  /// The function will return a boolean indicating whether the delete was successful.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  Future<bool> deleteExamRoom(int idExamRoom) async {
    isLoadingDeleteClassRoom = true;
    bool isSuccess = false;
    update();
    ResponseHandler<ExamRoomResModel> responseHandler = ResponseHandler();
    Either<Failure, ExamRoomResModel> response =
        await responseHandler.getResponse(
      path: "${ExamRoomLinks.examRooms}/$idExamRoom",
      converter: ExamRoomResModel.fromJson,
      type: ReqTypeEnum.DELETE,
      body: {},
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isSuccess = false;
        update();
      },
      (r) {
        getExamRoomByControlMissionId();
        isLoadingDeleteClassRoom = false;
        isSuccess = true;
        update();
      },
    );
    return isSuccess;
  }

  /// Gets all the classes rooms from the API and sets the
  /// [optionsClassRoom] with the classes rooms returned by the API.
  ///
  /// The function will return a boolean indicating whether the classes rooms
  /// were retrieved successfully.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  Future<bool> getClassesRoomsBySchoolId() async {
    bool gotData = false;
    ResponseHandler<ClassesRoomsResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassesRoomsResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.getSchoolsClassesBySchoolId,
      converter: ClassesRoomsResModel.fromJson,
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
        update();
      },
      (r) {
        classRooms = r.data!;
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsClassRoom = items;
        gotData = true;
        update();
      },
    );
    return gotData;
  }

  /// Retrieves the control mission ID from the local storage and updates the UI.
  ///
  /// The function retrieves the control mission ID from the local storage using
  /// Hive. If the ID is not found, it defaults to 0. The function then updates
  /// the UI with the retrieved ID.
  Future<void> getControlMissionId() async {
    controlMissionId = Hive.box('ControlMission').get('Id') ?? 0;
    update();
  }

  /// Retrieves the control mission name from the local storage and updates the UI.
  ///
  /// The function retrieves the control mission name from the local storage using
  /// Hive. If the name is not found, it defaults to an empty string. The function
  /// then updates the UI with the retrieved name.
  Future<void> getControlMissionName() async {
    controlMissionName = Hive.box('ControlMission').get('Name') ?? '';
    update();
  }

  /// Retrieves the number of distributed and undistributed students and the total
  /// number of students in the control mission from the API and updates the UI.
  ///
  /// The function will return a boolean indicating whether the response was
  /// successful.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the failure message.
  Future<void> getDistributedStudentsCounts() async {
    final ResponseHandler<DistributionStudentsResModel> responseHandler =
        ResponseHandler();
    Either<Failure, DistributionStudentsResModel> response =
        await responseHandler.getResponse(
      path: "${ControlMissionLinks.distributedStudents}/$controlMissionId",
      converter: DistributionStudentsResModel.fromJson,
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
        distributedStudents = r.distributedStudents!;
        unDistributedStudents = r.unDistributedStudents!;
        totalStudents = r.totalStudents!;
      },
    );
    update(['getDistributedStudentsCounts']);
  }

  /// Retrieves the list of exam rooms from the API based on the control mission ID
  /// and assigns the list to the [listExamRoom] variable.
  ///
  /// The function will return a boolean indicating whether the response was
  /// successful.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the failure message.
  Future<void> getExamRoomByControlMissionId() async {
    isLoadingGetExamRooms = true;
    update(['getExamRoomByControlMissionId']);

    final response = await ResponseHandler<ExamRoomsResModel>().getResponse(
      path: "${ExamRoomLinks.examRoomsControlMission}/$controlMissionId",
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
      (r) async {
        listExamRoom.assignAll(r.data!);
      },
    );
    isLoadingGetExamRooms = false;
    update(['getExamRoomByControlMissionId']);
  }

  /// Gets all stages from the API and assigns the list to the [optionsStage]
  /// variable.
  ///
  /// The function will return a boolean indicating whether the response was
  /// successful.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the failure message.
  Future<bool> getStage() async {
    bool getData = false;
    ResponseHandler<StageResModel> responseHandler = ResponseHandler();
    Either<Failure, StageResModel> response = await responseHandler.getResponse(
      path: Stage.stage,
      converter: StageResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        // isLoadingGetStage = false;
        getData = false;
        update();
      },
      (r) {
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsStage = items;
        getData = true;
        update();
      },
    );
    return getData;
  }

  /// Gets all stages and classes rooms by school id from the API and assigns the
  /// lists to the [optionsStage] and [classesRooms] variables respectively.
  ///
  /// The function will return nothing.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the failure message.
  void getStageAndClassRoom() async {
    isLoadingGetStageAndClassRoom = true;
    update();
    await Future.wait([getStage(), getClassesRoomsBySchoolId()]);
    isLoadingGetStageAndClassRoom = false;
    update();
  }

  @override

  /// Called when the widget is initialized.
  ///
  /// Calls the [getControlMissionId] and [getControlMissionName] functions and
  /// waits for them to complete.
  ///
  /// If the [controlMissionId] is not 0, then it calls the
  /// [getDistributedStudentsCounts] and [getExamRoomByControlMissionId] functions
  /// and waits for them to complete.
  void onInit() async {
    super.onInit();
    await Future.wait([
      getControlMissionId(),
      getControlMissionName(),
    ]);
    if (controlMissionId != 0) {
      await Future.wait([
        getDistributedStudentsCounts(),
        getExamRoomByControlMissionId(),
      ]);
    }
  }

  /// Saves the control mission ID in the local storage and calls
  /// [getExamRoomByControlMissionId] to update the exam room.
  ///
  /// The function takes one parameter, [id], which is the ID of the control
  /// mission that will be saved.
  ///
  /// The function will return nothing.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the failure message.
  Future<void> saveControlMissionId(int id) async {
    controlMissionId = id;
    Hive.box('ControlMission').put('Id', id);
    getExamRoomByControlMissionId();
  }

  /// Saves the control mission name in the local storage.
  ///
  /// The function takes one parameter, [name], which is the name of the control
  /// mission that will be saved.
  ///
  /// The function will return nothing.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the failure message.
  Future<void> saveControlMissionName(String name) async {
    controlMissionName = name;
    Hive.box('ControlMission').put('Name', name);
  }

  /// Sets the selected item for the class room dropdown to the first item of
  /// [items] and updates the UI.
  ///
  /// The function takes one parameter, [items], which is a list of [ValueItem]
  /// objects representing the items in the class room dropdown.
  ///
  /// The function will return nothing.
  void setSelectedItemClassRoom(List<ValueItem> items) {
    selectedItemClassRoom = items.first;
    update();
  }

  /// Sets the selected item for the stage dropdown to the first item of
  /// [items] and updates the UI.
  ///
  /// The function takes one parameter, [items], which is a list of [ValueItem]
  /// objects representing the items in the stage dropdown.
  ///
  /// The function will return nothing.
  void setSelectedItemStage(List<ValueItem> items) {
    selectedItemStage = items.first;
    update();
  }
}
