import '../student/student_res_model.dart';

class StudentSeatNumberResModel {
  StudentSeatNumberResModel({
    this.iD,
    this.classDeskID,
    this.gradesID,
    this.examRoomID,
    this.studentID,
    this.controlMissionID,
    this.seatNumber,
    this.student,
  });

  StudentSeatNumberResModel.fromJson(json) {
    iD = json['ID'];
    classDeskID = json['Class_Desk_ID'];
    gradesID = json['Grades_ID'];
    examRoomID = json['Exam_Room_ID'];
    studentID = json['Student_ID'];
    controlMissionID = json['Control_Mission_ID'];
    seatNumber = json['Seat_Number'];
    student = StudentResModel?.fromJson(json['student']);
  }

  int? classDeskID;
  int? controlMissionID;
  int? examRoomID;
  int? gradesID;
  int? iD;
  String? seatNumber;
  StudentResModel? student;
  int? studentID;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Class_Desk_ID'] = classDeskID;
    data['Grades_ID'] = gradesID;
    data['Exam_Room_ID'] = examRoomID;
    data['Student_ID'] = studentID;
    data['Control_Mission_ID'] = controlMissionID;
    data['Seat_Number'] = seatNumber;
    data['student'] = student?.toJson();
    return data;
  }
}
