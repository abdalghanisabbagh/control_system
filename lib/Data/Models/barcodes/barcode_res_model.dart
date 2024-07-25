import '../exam_mission/exam_mission_res_model.dart';
import '../student/student_res_model.dart';

class BarcodeResModel {
  int? iD;
  int? examMissionID;
  int? studentID;
  int? studentSeatNumnbersID;
  String? barcode;
  int? attendanceStatusId;
  String? studentDegree;
  String? examVersion;
  int? isCheating;
  StudentResModel? student;
  ExamMissionResModel? examMission;

  BarcodeResModel({
    this.iD,
    this.examMissionID,
    this.studentID,
    this.studentSeatNumnbersID,
    this.barcode,
    this.attendanceStatusId,
    this.studentDegree,
    this.examVersion,
    this.isCheating,
    this.student,
    this.examMission,
  });

  BarcodeResModel.fromJson(json) {
    iD = json['ID'];
    examMissionID = json['Exam_Mission_ID'];
    studentID = json['Student_ID'];
    studentSeatNumnbersID = json['student_seat_numnbers_ID'];
    barcode = json['Barcode'];
    attendanceStatusId = json['AttendanceStatusId'];
    studentDegree = json['StudentDegree'];
    examVersion = json['Exam_Version'];
    isCheating = json['isCheating'];
    student = json['student'] != null
        ? StudentResModel.fromJson(json['student'])
        : null;

    examMission = json['exam_mission'] != null
        ? ExamMissionResModel.fromJson(json['exam_mission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Exam_Mission_ID'] = examMissionID;
    data['Student_ID'] = studentID;
    data['student_seat_numnbers_ID'] = studentSeatNumnbersID;
    data['Barcode'] = barcode;
    data['AttendanceStatusId'] = attendanceStatusId;
    data['StudentDegree'] = studentDegree;
    data['Exam_Version'] = examVersion;
    data['isCheating'] = isCheating;
    if (student != null) {
      data['student'] = student!.toJson();
      if (examMission != null) {
        data['exam_mission'] = examMission!.toJson();
      }
    }
    return data;
  }
}
