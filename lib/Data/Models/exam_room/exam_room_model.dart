class ExamRoomModel {
  int? controlMissionID;
  int? schoolClassID;
  String? name;
  String? stage;
  int? capacity;

  ExamRoomModel({
    this.controlMissionID,
    this.schoolClassID,
    this.name,
    this.stage,
    this.capacity,
  });

  ExamRoomModel.fromJson(Map<String, dynamic> json) {
    controlMissionID = json['Control_Mission_ID'];
    schoolClassID = json['School_Class_ID'];
    name = json['Name'];
    stage = json['Stage'];
    capacity = json['Capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Control_Mission_ID'] = controlMissionID;
    data['School_Class_ID'] = schoolClassID;
    data['Name'] = name;
    data['Stage'] = stage;
    data['Capacity'] = capacity;
    return data;
  }
}
