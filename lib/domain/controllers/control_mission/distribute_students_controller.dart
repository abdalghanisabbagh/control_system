import 'package:control_system/Data/Models/class_room/class_room_res_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../Data/Models/exam_room/exam_room_res_model.dart';

class DistributeStudentsController extends GetxController {
  ExamRoomResModel examRoomResModel = ExamRoomResModel();

  Future<void> saveExamRoom(ExamRoomResModel examRoomResModel) async {
    this.examRoomResModel = examRoomResModel;
    update();
    Hive.box('ExamRoom').putAll(examRoomResModel.toJson());
  }

  Future<void> getExamRoom() async {
    examRoomResModel = Hive.box('ExamRoom').containsKey('ID')
        ? ExamRoomResModel(
            id: Hive.box('ExamRoom').get('ID'),
            name: Hive.box('ExamRoom').get('Name'),
            stage: Hive.box('ExamRoom').get('Stage'),
            capacity: Hive.box('ExamRoom').get('Capacity'),
            classRoom: ClassRoomResModel(
              name: Hive.box('ExamRoom').get('school_class')['Name'],
            ),
            controlMissionID: Hive.box('ExamRoom').get('Control_Mission_ID'),
            schoolClassID: Hive.box('ExamRoom').get('School_Class_ID'),
          )
        : ExamRoomResModel();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await getExamRoom();
  }
}
