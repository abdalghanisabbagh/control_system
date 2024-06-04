import 'class_room_res_model.dart';

class ClassesRoomsResModel {
  List<ClassRoomResModel>? data;

  ClassesRoomsResModel({this.data});

  ClassesRoomsResModel.fromJson(json) {
    data = List<ClassRoomResModel>.from(
        json.map((e) => ClassRoomResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
