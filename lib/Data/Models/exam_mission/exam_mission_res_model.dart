import 'package:get/get.dart';

import '../../../domain/controllers/profile_controller.dart';

class ExamMissionResModel {
  int? iD;
  int? subjectsID;
  int? controlMissionID;
  int? gradesID;
  int? educationYearID;
  String? month;
  String? year;
  String? finalDegree;
  int? period;
  int? duration;
  String? startTime;
  String? endTime;
  String? pdf;
  String? pdfV2;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  int? active;

  ExamMissionResModel({
    this.iD,
    this.subjectsID,
    this.controlMissionID,
    this.gradesID,
    this.educationYearID,
    this.month,
    this.year,
    this.finalDegree,
    this.period,
    this.duration,
    this.startTime,
    this.endTime,
    this.pdf,
    this.pdfV2,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.active,
  });

  ExamMissionResModel.fromJson(json) {
    iD = json['ID'];
    subjectsID = json['Subjects_ID'];
    controlMissionID = json['Control_Mission_ID'];
    gradesID = json['grades_ID'];
    educationYearID = json['education_year_ID'];
    month = json['Month'];
    year = json['Year'];
    finalDegree = json['FinalDegree'];
    period = json['Period'];
    duration = json['duration'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    pdf = json['pdf'];
    pdfV2 = json['pdf_V2'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    active = json['Active'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  
  if (iD != null) data['ID'] = iD;
  if (subjectsID != null) data['Subjects_ID'] = subjectsID;
  if (controlMissionID != null) data['Control_Mission_ID'] = controlMissionID;
  if (gradesID != null) data['grades_ID'] = gradesID;
  if (educationYearID != null) data['education_year_ID'] = educationYearID;
  if (month != null) data['Month'] = month;
  if (year != null) data['Year'] = year;
  if (finalDegree != null) data['FinalDegree'] = finalDegree;
  if (period != null) data['Period'] = period;
  if (duration != null) data['duration'] = duration;
  if (startTime != null) data['start_time'] = startTime;
  if (endTime != null) data['end_time'] = endTime;
  if (pdf != null) data['pdf'] = pdf;
  if (pdfV2 != null) data['pdf_V2'] = pdfV2;
  if (Get.find<ProfileController>().cachedUserProfile?.iD != null) {
    data['Created_By'] = Get.find<ProfileController>().cachedUserProfile?.iD;
  }
  if (createdAt != null) data['Created_At'] = createdAt;
  if (updatedBy != null) data['Updated_By'] = updatedBy;
  if (updatedAt != null) data['Updated_At'] = updatedAt;
  if (active != null) data['Active'] = active;

  return data;
}

}
