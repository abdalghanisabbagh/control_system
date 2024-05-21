class StudentMoodel {
  int? gradesID;
  int? schoolsID;
  int? cohortID;
  int? schoolClassID;
  String? firstName;
  String? secondName;
  String? thirdName;
  int? createdBy;

  StudentMoodel({
    this.gradesID,
    this.schoolsID,
    this.cohortID,
    this.schoolClassID,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.createdBy,
  });

  StudentMoodel.fromJson(Map<String, dynamic> json) {
    gradesID = json['Grades_ID'];
    schoolsID = json['Schools_ID'];
    cohortID = json['Cohort_ID'];
    schoolClassID = json['School_Class_ID'];
    firstName = json['First_Name'];
    secondName = json['Second_Name'];
    thirdName = json['Third_Name'];
    createdBy = json['Created_By'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Grades_ID'] = gradesID;
    data['Schools_ID'] = schoolsID;
    data['Cohort_ID'] = cohortID;
    data['School_Class_ID'] = schoolClassID;
    data['First_Name'] = firstName;
    data['Second_Name'] = secondName;
    data['Third_Name'] = thirdName;
    data['Created_By'] = createdBy;
    return data;
  }
}
