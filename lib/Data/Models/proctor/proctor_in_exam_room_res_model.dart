import 'package:control_system/Data/Models/proctor/proctor_res_model.dart';

class ProctorInExamRoomResModel {
  int? id;
  int? proctorsId;
  int? examRoomId;
  String? month;
  String? year;
  bool? period;
  String? attendance;
  String? active;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  ProctorResModel? proctor;

  ProctorInExamRoomResModel({
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
    this.proctor,
  });

  ProctorInExamRoomResModel.fromJson(json) {
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
    proctor = json['proctors'] != null
        ? ProctorResModel.fromJson(json['proctors'])
        : null;
  }
}
