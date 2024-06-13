class ExamRoomModel {
  ExamRoomModel({
    this.id,
    this.controlMissionID,
    this.schoolClassID,
    this.name,
    this.stage,
    this.capacity,
  });

  ExamRoomModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    controlMissionID = json['Control_Mission_ID'];
    schoolClassID = json['School_Class_ID'];
    name = json['Name'];
    stage = json['Stage'];
    capacity = json['Capacity'];
  }

  int? capacity;
  int? id;
  int? controlMissionID;
  String? name;
  int? schoolClassID;
  String? stage;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Control_Mission_ID'] = controlMissionID;
    data['School_Class_ID'] = schoolClassID;
    data['Name'] = name;
    data['Stage'] = stage;
    data['Capacity'] = capacity;
    return data;
  }
}
