import 'proctor_in_exam_room_res_model.dart';

class ProctorsInExamRoomResModel {
  List<ProctorInExamRoomResModel>? data;

  ProctorsInExamRoomResModel({this.data});

  ProctorsInExamRoomResModel.fromJson(json) {
    data = List<ProctorInExamRoomResModel>.from(
        json.map((e) => ProctorInExamRoomResModel.fromJson(e)).toList());
  }
}
