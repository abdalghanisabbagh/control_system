import 'package:control_system/Data/Models/control_mission/control_mission_model.dart';

class ControlMissionsModel {
  ControlMissionsModel({this.data});

  ControlMissionsModel.fromJson(json) {
    data = List<ControlMissionModel>.from(
        json.map((e) => ControlMissionModel.fromJson(e)).toList());
  }

  List<ControlMissionModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
