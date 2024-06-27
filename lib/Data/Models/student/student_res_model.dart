import 'package:control_system/Data/Models/school/grade_response/grade_res_model.dart';

class StudentResModel {
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
    this.active,
  });

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
    gradeResModel =
        json['grades'] == null ? null : GradeResModel.fromJson(json['grades']);
    active = json['Active'];
  }

  int? active;
  int? cohortID;
  String? cohortName;
  String? createdAt;
  int? createdBy;
  String? email;
  String? firstName;
  int? gradesID;
  String? gradeName;
  int? iD;
  int? blbId;
  int? schoolClassID;
  String? schoolClassName;
  int? schoolsID;
  String? secondLang;
  String? secondName;
  String? thirdName;
  DateTime? updatedAt;
  int? updatedBy;
  GradeResModel? gradeResModel;

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
    return data;
  }

  Map<String, dynamic> test() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Blb_Id'] = blbId;
    data['Grades_ID'] = gradesID;
    data['Schools_ID'] = schoolsID ?? 1;
    data['Cohort_ID'] = cohortID;
    data['School_Class_ID'] = schoolClassID;
    data['First_Name'] = firstName;
    data['Second_Name'] = secondName;
    data['Third_Name'] = thirdName;
    data['Created_By'] = createdBy ?? 1;
    data['Second_Lang'] = secondLang;
    return data;
  }

  factory StudentResModel.fromCsvWithHeaders(
      List<dynamic> row, List<String> headers) {
    Map<String, dynamic> data = {};
    for (int i = 0; i < headers.length; i++) {
      data[headers[i]] = row[i];
    }

    return StudentResModel(
      blbId: data['blbid'],
      firstName: data['firstname'],
      secondName: data['middlename'],
      thirdName: data['lastname'],
      cohortName: data['cohort'],
      gradeName: data['grade'],
      schoolClassName: data['class'],
      secondLang: data['second_language'],
    );
  }
}
