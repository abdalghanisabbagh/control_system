import 'package:awesome_dialog/awesome_dialog.dart';
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
  bool isLoadingGetClassRoom = false;
  bool isLoadingDeleteClassRoom = false;
  List<ValueItem> optionsClassRoom = <ValueItem>[];
  ValueItem? selectedItemClassRoom;
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
    isLoadingGetClassRoom = true;
    bool gotData = false;
    update();
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
        isLoadingGetClassRoom = false;
        gotData = false;
        update();
      },
      (r) {
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsClassRoom = items;
        isLoadingGetClassRoom = false;
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
        isLoadingGetClassRoom = false;
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
}
