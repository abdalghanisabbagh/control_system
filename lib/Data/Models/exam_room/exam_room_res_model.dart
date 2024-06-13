import 'package:control_system/Data/Models/exam_room/exam_room_model.dart';

class ExamRoomResModel {
  ExamRoomResModel({this.data});

  ExamRoomResModel.fromJson(json) {
    data = List<ExamRoomModel>.from(
        json.map((e) => ExamRoomModel.fromJson(e)).toList());
  }

  List<ExamRoomModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
