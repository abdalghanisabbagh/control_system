import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/satge/stage_res_model.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';
import '../../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../../Data/Models/exam_room/exam_rooms_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class DistributionController extends GetxController {
  List<ExamRoomResModel> listExamRoom = [];
  bool isLodingGetExamRooms = false;
  bool isLoadingDeleteClassRoom = false;
  bool isLodingGetStageAndClassRoom = false;
  bool isLodingAddExamRoom = false;
  List<ValueItem> optionsClassRoom = <ValueItem>[];
  List<ValueItem> optionsStage = <ValueItem>[];
  ValueItem? selectedItemClassRoom;
  ValueItem? selectedItemStage;
  String name = '';
  String id = '';
  int controlMissionId = 0;

  Future<void> getExamRoomByControlMissionId(int id) async {
    controlMissionId = id;
    isLodingGetExamRooms = true;
    update();

    final response = await ResponseHandler<ExamRoomsResModel>().getResponse(
      path: "${ExamLinks.examRoomsControlMission}/$id",
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
        update();
      },
    );
    isLodingGetExamRooms = false;
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
        getExamRoomByControlMissionId(controlMissionId);
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
      getExamRoomByControlMissionId(controlMissionId);
      // studentController.getStudents();
      addExamRoomHasBeenAdded = true;
      isLodingAddExamRoom = false;
    });

    update();
    return addExamRoomHasBeenAdded;
  }
}
