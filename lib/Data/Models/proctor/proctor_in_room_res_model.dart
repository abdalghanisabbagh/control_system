class ProctorInRoomResModel {
  int? id;
  int? proctorsId;
  int? examRoomId;
  String? month;
  String? year;
  int? period;
  String? attendance;
  String? active;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;

  ProctorInRoomResModel({
    this.id,
    this.proctorsId,
    this.examRoomId,
    this.month,
    this.year,
    this.period,
    this.attendance,
    this.active,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  ProctorInRoomResModel.fromJson(json) {
    id = json['ID'];
    proctorsId = json['proctors_ID'];
    examRoomId = json['exam_room_ID'];
    month = json['Month'];
    year = json['Year'];
    period = json['Period'];
    attendance = json['Attendance'];
    active = json['Active'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
  }
}
