import 'package:control_system/Data/Models/base_model.dart';

class ExamMessionModel extends BaseModel {
  int? subjectsID;
  int? controlMissionID;
  int? gradesID;
  int? educationYearID;
  String? month;
  String? year;
  String? finalDegree;
  int? period;
  int? duration;
  // StartTime? startTime;
  // StartTime? endTime;
  String? pdf;
  String? pdfV2;

  ExamMessionModel({
    this.subjectsID,
    this.controlMissionID,
    this.gradesID,
    this.educationYearID,
    this.month,
    this.year,
    this.finalDegree,
    this.period,
    this.duration,
    // this.startTime,
    // this.endTime,
    this.pdf,
    this.pdfV2,
  });

  ExamMessionModel.fromJson(Map<String, dynamic> json) {
    subjectsID = json['Subjects_ID'];
    controlMissionID = json['Control_Mission_ID'];
    gradesID = json['grades_ID'];
    educationYearID = json['education_year_ID'];
    month = json['Month'];
    year = json['Year'];
    finalDegree = json['FinalDegree'];
    period = json['Period'];
    duration = json['duration'];
    // startTime = json['start_time'] != null ? StartTime.fromJson(json['start_time']) : null;
    // endTime = json['end_time'] != null ? StartTime.fromJson(json['end_time']) : null;
    pdf = json['pdf'];
    pdfV2 = json['pdf_V2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Subjects_ID'] = subjectsID;
    data['Control_Mission_ID'] = controlMissionID;
    data['grades_ID'] = gradesID;
    data['education_year_ID'] = educationYearID;
    data['Month'] = month;
    data['Year'] = year;
    data['FinalDegree'] = finalDegree;
    data['Period'] = period;
    data['duration'] = duration;
    // if (startTime != null) {
    //   data['start_time'] = startTime!.toJson();
    // }
    // if (endTime != null) {
    //   data['end_time'] = endTime!.toJson();
    // }
    data['pdf'] = pdf;
    data['pdf_V2'] = pdfV2;
    return data;
  }
}
