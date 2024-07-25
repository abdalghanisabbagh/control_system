import '../control_mission/control_mission_res_model.dart';

class ExamRoomResModel {
  ExamRoomResModel({
    this.id,
    this.controlMissionID,
    this.schoolClassID,
    this.name,
    this.stage,
    this.capacity,
  });

  ExamRoomResModel.fromExtra(Map<String, String>? extra) {
    id = int.parse(extra?['ID'] ?? '0');
    controlMissionID = int.parse(extra?['Control_Mission_ID'] ?? '0');
    schoolClassID = int.parse(extra?['School_Class_ID'] ?? '0');
    name = extra?['Name'];
    stage = extra?['Stage'];
    capacity = int.parse(extra?['Capacity'] ?? '0');
  }

  ExamRoomResModel.fromJson(json) {
    id = json['ID'];
    controlMissionID = json['Control_Mission_ID'];
    schoolClassID = json['School_Class_ID'];
    name = json['Name'];
    stage = json['Stage'];
    capacity = json['Capacity'];
    controlMissionResModel = json['control_mission'] == null
        ? null
        : ControlMissionResModel.fromJson(json['control_mission']);
  }

  int? capacity;
  int? controlMissionID;
  int? id;
  String? name;
  int? schoolClassID;
  String? stage;
  ControlMissionResModel? controlMissionResModel;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Control_Mission_ID'] = controlMissionID;
    data['School_Class_ID'] = schoolClassID;
    data['Name'] = name;
    data['Stage'] = stage;
    data['Capacity'] = capacity;
    data['control_mission'] = controlMissionResModel?.toJson();
    return data;
  }

  Map<String, String>? toExtra() {
    return {
      'ID': id.toString(),
      'Control_Mission_ID': controlMissionID.toString(),
      'School_Class_ID': schoolClassID.toString(),
      'Name': name ?? '',
      'Stage': stage ?? '',
      'Capacity': capacity.toString(),
    };
  }
}
