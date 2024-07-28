import 'control_mission_res_model.dart';

class ControlMissionsResModel {
  List<ControlMissionResModel>? data;

  ControlMissionsResModel({this.data});

  ControlMissionsResModel.fromJson(json) {
    data = List<ControlMissionResModel>.from(
        json.map((e) => ControlMissionResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
