import 'package:control_system/Data/Models/student/student_res_model.dart';

class StudentSeatModel {
  StudentSeatModel({
    this.id,
    this.studentsId,
    this.controlmissionId,
    this.gradesId,
    this.educationsystemId,
    this.seatNumbers,
    this.examRoomId,
    this.students,
    this.examRoomName,
  });

  int? id;
  int? studentsId;
  int? controlmissionId;
  int? gradesId;
  int? educationsystemId;
  String? seatNumbers;
  int? examRoomId;
  StudentResModel? students;
  String? examRoomName;

  factory StudentSeatModel.fromJson(Map<String, dynamic> json) =>
      StudentSeatModel(
        id: json["Id"],
        studentsId: json["Students_Id"],
        controlmissionId: json["controlmission_Id"],
        gradesId: json["Grades_Id"],
        educationsystemId: json["educationsystem_Id"],
        seatNumbers: json["SeatNumbers"],
        examRoomId: json["ExamRoomId"],
        examRoomName:
            json['examrooms'] == null ? null : json['examrooms']['Name'],
        students: json["students"] == null
            ? null
            : StudentResModel.fromJson(json["students"]),
      );
}
