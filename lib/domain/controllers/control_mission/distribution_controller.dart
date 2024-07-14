import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../../Data/Models/exam_room/exam_rooms_res_model.dart';
import '../../../Data/Models/satge/stage_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class DistributionController extends GetxController {
  int controlMissionId = 0;
  String controlMissionName = '';
  bool isLoadingDeleteClassRoom = false;
  bool isLodingAddExamRoom = false;
  bool isLodingGetExamRooms = false;
  bool isLodingGetStageAndClassRoom = false;
  List<ExamRoomResModel> listExamRoom = [];
  List<ValueItem> optionsClassRoom = <ValueItem>[];
  List<ValueItem> optionsStage = <ValueItem>[];
  ValueItem? selectedItemClassRoom;
  ValueItem? selectedItemStage;

  @override
  void onInit() async {
    super.onInit();
    await Future.wait([
      getControlMissionId(),
      getControlMissionName(),
    ]);
    getExamRoomByControlMissionId();
  }

  Future<void> saveControlMissionId(int id) async {
    controlMissionId = id;
    update();
    Hive.box('ControlMission').put('Id', id);
    getExamRoomByControlMissionId();
  }

  Future<void> saveControlMissionName(String name) async {
    controlMissionName = name;
    update();
    Hive.box('ControlMission').put('Name', name);
  }

  Future<void> getControlMissionId() async {
    controlMissionId = Hive.box('ControlMission').get('Id') ?? 0;
    update();
  }

  Future<void> getControlMissionName() async {
    controlMissionName = Hive.box('ControlMission').get('Name') ?? '';
    update();
  }

  Future<void> getExamRoomByControlMissionId() async {
    isLodingGetExamRooms = true;
    update();

    final response = await ResponseHandler<ExamRoomsResModel>().getResponse(
      path: "${ExamLinks.examRoomsControlMission}/$controlMissionId",
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
        listExamRoom = r.data!;
      },
    );
    isLodingGetExamRooms = false;
    update();
  }

  Future<bool> getClassesRoomsBySchoolId() async {
    bool gotData = false;
    ResponseHandler<ClassesRoomsResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassesRoomsResModel> response =
        await responseHandler.getResponse(
      path:
          "${SchoolsLinks.schoolsClasses}/school/${Hive.box('School').get('Id')}",
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

  void setSelectedItemClassRoom(List<ValueItem> items) {
    selectedItemClassRoom = items.first;
    update();
  }

  void setSelectedItemStage(List<ValueItem> items) {
    selectedItemStage = items.first;
    update();
  }

  Future<bool> deleteExamRoom(int idExamRoom) async {
    isLoadingDeleteClassRoom = true;
    bool succDel = false;
    update();
    ResponseHandler<ExamRoomResModel> responseHandler = ResponseHandler();
    Either<Failure, ExamRoomResModel> response =
        await responseHandler.getResponse(
      path: "${ExamLinks.examRooms}/$idExamRoom",
      converter: ExamRoomResModel.fromJson,
      type: ReqTypeEnum.DELETE,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        succDel = false;
        update();
      },
      (r) {
        getExamRoomByControlMissionId();
        isLoadingDeleteClassRoom = false;
        succDel = true;
        update();
      },
    );
    return succDel;
  }

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

  void getStageAndClassRoom() async {
    isLodingGetStageAndClassRoom = true;
    update();
    await Future.wait([getStage(), getClassesRoomsBySchoolId()]);
    isLodingGetStageAndClassRoom = false;
    update();
  }

  Future<bool> addNewExamRoom({
    required int controlMissionId,
    required int schoolClassId,
    required String name,
    required String stage,
    required int capacity,
  }) async {
    isLodingAddExamRoom = true;

    bool addExamRoomHasBeenAdded = false;
    update();

    ResponseHandler<ExamRoomResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
        path: ExamLinks.examRooms,
        converter: ExamRoomResModel.fromJson,
        type: ReqTypeEnum.POST,
        body: {
          "Control_Mission_ID": controlMissionId,
          "School_Class_ID": schoolClassId,
          "Name": name,
          "Stage": stage,
          "Capacity": capacity
        });

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      isLodingAddExamRoom = false;
      addExamRoomHasBeenAdded = false;
      update();
    }, (result) {
      getExamRoomByControlMissionId();
      // studentController.getStudents();
      addExamRoomHasBeenAdded = true;
      isLodingAddExamRoom = false;
    });

    update();
    return addExamRoomHasBeenAdded;
  }
}
