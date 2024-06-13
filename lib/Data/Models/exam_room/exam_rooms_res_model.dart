import 'package:control_system/Data/Models/exam_room/exam_room_res_model.dart';

class ExamRoomsResModel {
  ExamRoomsResModel({this.data});

  ExamRoomsResModel.fromJson(json) {
    data = List<ExamRoomResModel>.from(
        json.map((e) => ExamRoomResModel.fromJson(e)).toList());
  }

  List<ExamRoomResModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
