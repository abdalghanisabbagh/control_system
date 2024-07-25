import '../exam_room/exam_room_res_model.dart';
import 'proctor_res_model.dart';

class ProctorInExamRoomResModel {
  String? active;

  String? attendance;

  String? createdAt;
  int? createdBy;
  ExamRoomResModel? examRoom;
  int? examRoomId;
  int? id;
  String? month;
  bool? period;
  ProctorResModel? proctor;
  int? proctorsId;
  String? updatedAt;
  int? updatedBy;
  String? year;
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
    this.examRoom,
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
    examRoom = json['exam_room'] != null
        ? ExamRoomResModel.fromJson(json['exam_room'])
        : null;
  }
}
