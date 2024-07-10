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
    data['Subjects_ID'] = subjectsID;
    data['Control_Mission_ID'] = controlMissionID;
    data['grades_ID'] = gradesID;
    data['education_year_ID'] = educationYearID;
    data['Month'] = month;
    data['Year'] = year;
    data['FinalDegree'] = finalDegree;
    data['Period'] = period;
    data['duration'] = duration;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['pdf'] = pdf;
    data['pdf_V2'] = pdfV2;
    data['Created_By'] = Get.find<ProfileController>().cachedUserProfile?.iD;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    data['Active'] = active;
    return data;
  }
}
