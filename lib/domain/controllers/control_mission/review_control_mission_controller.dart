import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../../Data/Models/exam_room/exam_rooms_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class DetailsAndReviewMissionController extends GetxController {
  String controlMissionName = '';
  int controlMissionId = 0;
  bool isLodingGetExamRooms = false;
  List<ExamRoomResModel> listExamRoom = [];
  TabController? tabController;
  final List<Tab> myTabs = const <Tab>[
    Tab(text: 'Mission Details'),
    Tab(text: 'Review Students Grades'),
  ];
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
        update();
      },
    );
    isLodingGetExamRooms = false;
  }
}
