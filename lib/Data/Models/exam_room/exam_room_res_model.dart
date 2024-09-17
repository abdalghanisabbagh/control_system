import '../class_room/class_room_res_model.dart';
import '../control_mission/control_mission_res_model.dart';

class ExamRoomResModel {
  ClassRoomResModel? classRoomResModel;

  int? controlMissionID;

  ControlMissionResModel? controlMissionResModel;

  int? id;
  String? name;
  int? schoolClassID;
  String? stage;
  ExamRoomResModel({
    this.id,
    this.controlMissionID,
    this.schoolClassID,
    this.name,
    this.stage,
    this.controlMissionResModel,
  });
  ExamRoomResModel.fromExtra(Map<String, String>? extra) {
    id = int.parse(extra?['ID'] ?? '0');
    controlMissionID = int.parse(extra?['Control_Mission_ID'] ?? '0');
    schoolClassID = int.parse(extra?['School_Class_ID'] ?? '0');
    name = extra?['Name'];
    stage = extra?['Stage'];
  }
  ExamRoomResModel.fromJson(json) {
    id = json['ID'];
    controlMissionID = json['Control_Mission_ID'];
    schoolClassID = json['School_Class_ID'];
    name = json['Name'];
    stage = json['Stage'];
    controlMissionResModel = json['control_mission'] == null
        ? null
        : ControlMissionResModel.fromJson(json['control_mission']);

    classRoomResModel = json['school_class'] == null
        ? null
        : ClassRoomResModel.fromJson(json['school_class']);
  }

  Map<String, String>? toExtra() {
    return {
      'ID': id.toString(),
      'Control_Mission_ID': controlMissionID.toString(),
      'School_Class_ID': schoolClassID.toString(),
      'Name': name ?? '',
      'Stage': stage ?? '',
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Control_Mission_ID'] = controlMissionID;
    data['School_Class_ID'] = schoolClassID;
    data['Name'] = name;
    data['Stage'] = stage;
    if (controlMissionResModel != null) {
      data['control_mission'] = controlMissionResModel!.toJson();
    }
    if (classRoomResModel != null) {
      data['school_class'] = classRoomResModel!.toJson();
    }
    return data;
  }
}
