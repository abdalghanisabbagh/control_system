import 'exam_room_res_model.dart';

class ExamRoomsResModel {
  List<ExamRoomResModel>? data;

  ExamRoomsResModel({this.data});

  ExamRoomsResModel.fromJson(json) {
    data = List<ExamRoomResModel>.from(
        json.map((e) => ExamRoomResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
