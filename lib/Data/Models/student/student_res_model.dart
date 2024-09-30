import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/controllers/profile_controller.dart';
import '../class_room/class_room_res_model.dart';
import '../cohort/cohort_res_model.dart';
import '../school/grade_response/grade_res_model.dart';

class StudentResModel {
  int? active;

  int? blbId;

  ClassRoomResModel? classRoomResModel;

  int? cohortID;
  String? cohortName;
  CohortResModel? cohortResModel;
  String? createdAt;
  int? createdBy;
  String? email;
  String? firstName;
  String? gradeName;
  GradeResModel? gradeResModel;
  int? gradesID;
  int? iD;
  String? religion;
  int? schoolClassID;
  String? schoolClassName;
  int? schoolsID;
  String? secondLang;
  String? citizenship;
  String? secondName;
  String? thirdName;
  DateTime? updatedAt;
  int? updatedBy;
  StudentResModel({
    this.iD,
    this.blbId,
    this.gradesID,
    this.gradeName,
    this.schoolsID,
    this.cohortID,
    this.cohortName,
    this.schoolClassID,
    this.schoolClassName,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.email,
    this.secondLang,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.gradeResModel,
    this.classRoomResModel,
    this.cohortResModel,
    this.active,
    this.religion,
    this.citizenship,
  });
  factory StudentResModel.fromCsvWithHeaders(
      List<dynamic> row, List<String> headers) {
    Map<String, dynamic> data = {};
    for (int i = 0; i < headers.length; i++) {
      if (row[i] != null && row[i].toString().isNotEmpty) {
        data[headers[i]] = row[i];
      }
    }

    return StudentResModel(
      blbId: data.containsKey('id') ? data['id'] : null,
      firstName: data.containsKey('firstname') ? data['firstname'] : null,
      secondName: data.containsKey('middlename') ? data['middlename'] : null,
      thirdName: data.containsKey('lastname') ? data['lastname'] : null,
      cohortName: data.containsKey('cohort') ? data['cohort'] : null,
      gradeName: data.containsKey('grade') ? data['grade'] : null,
      schoolClassName: data.containsKey('class') ? data['class'] : null,
      secondLang:
          data.containsKey('second_language') ? data['second_language'] : null,
      religion: data.containsKey('religion') ? data['religion'] : null,
      citizenship: data.containsKey('Citizenship') ? data['Citizenship'] : null,
    );
  }
  StudentResModel.fromJson(json) {
    iD = json['ID'];
    blbId = json['Blb_Id'];
    gradesID = json['Grades_ID'];
    schoolsID = json['Schools_ID'];
    cohortID = json['Cohort_ID'];
    schoolClassID = json['School_Class_ID'];
    firstName = json['First_Name'];
    secondName = json['Second_Name'];
    thirdName = json['Third_Name'];
    email = json['Email'];
    secondLang = json['Second_Lang'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    religion = json['Religion'];
    gradeResModel =
        json['grades'] == null ? null : GradeResModel.fromJson(json['grades']);
    classRoomResModel = json['school_class'] == null
        ? null
        : ClassRoomResModel.fromJson(json['school_class']);
    cohortResModel =
        json['cohort'] == null ? null : CohortResModel.fromJson(json['cohort']);
    active = json['Active'];
    if (json['Citizenship'] != null) {
      citizenship = json['Citizenship'];
    }
  }

  @override
  int get hashCode {
    return iD.hashCode ^
        blbId.hashCode ^
        gradesID.hashCode ^
        schoolsID.hashCode ^
        cohortID.hashCode ^
        schoolClassID.hashCode ^
        firstName.hashCode ^
        secondName.hashCode ^
        thirdName.hashCode ^
        email.hashCode ^
        secondLang.hashCode ^
        createdBy.hashCode ^
        createdAt.hashCode ^
        updatedBy.hashCode ^
        updatedAt.hashCode ^
        gradeResModel.hashCode ^
        active.hashCode ^
        religion.hashCode ^
        classRoomResModel.hashCode ^
        cohortResModel.hashCode ^
        citizenship.hashCode;
  }

  @override
  bool operator ==(covariant StudentResModel other) {
    if (identical(this, other)) return true;

    return other.iD == iD &&
        other.blbId == blbId &&
        other.gradesID == gradesID &&
        other.schoolsID == schoolsID &&
        other.cohortID == cohortID &&
        other.schoolClassID == schoolClassID &&
        other.firstName == firstName &&
        other.secondName == secondName &&
        other.thirdName == thirdName &&
        other.email == email &&
        other.secondLang == secondLang &&
        other.createdBy == createdBy &&
        other.createdAt == createdAt &&
        other.updatedBy == updatedBy &&
        other.updatedAt == updatedAt &&
        other.gradeResModel == gradeResModel &&
        other.active == active &&
        other.religion == religion &&
        other.classRoomResModel == classRoomResModel &&
        other.cohortResModel == cohortResModel &&
        other.citizenship == citizenship;
  }

  Map<String, dynamic> importStudentByExcel() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iD != null) data['ID'] = iD;
    data['Blb_Id'] = blbId;
    data['Grades_ID'] = gradesID;
    data['Schools_ID'] = schoolsID ?? Hive.box('School').get('Id');
    data['Cohort_ID'] = cohortID;
    data['School_Class_ID'] = schoolClassID;
    data['First_Name'] = firstName;
    data['Second_Name'] = secondName;
    data['Third_Name'] = thirdName ?? ' ';
    data['Created_By'] = Get.find<ProfileController>().cachedUserProfile?.iD;
    data['Second_Lang'] = secondLang;
    data['Religion'] = religion;
    data['Citizenship'] = citizenship;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Blb_Id'] = blbId;
    data['Grades_ID'] = gradesID;
    data['Schools_ID'] = schoolsID;
    data['Cohort_ID'] = cohortID;
    data['School_Class_ID'] = schoolClassID;
    data['First_Name'] = firstName;
    data['Second_Name'] = secondName;
    data['Third_Name'] = thirdName;
    data['Email'] = email;
    data['Second_Lang'] = secondLang;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    data['grades'] = gradeResModel?.toJson();
    data['Active'] = active;
    data['Religion'] = religion;
    data['school_class'] = classRoomResModel?.toJson();
    data['cohort'] = cohortResModel?.toJson();
    data['Citizenship'] = citizenship;
    return data;
  }
}
