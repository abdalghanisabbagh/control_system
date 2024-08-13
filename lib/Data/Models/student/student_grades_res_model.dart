class Cohort {
  List<CohortHasSubjects>? cohortHasSubjects;

  Cohort({this.cohortHasSubjects});

  Cohort.fromJson(json) {
    if (json['cohort_has_subjects'] != null) {
      cohortHasSubjects = <CohortHasSubjects>[];
      json['cohort_has_subjects'].forEach((v) {
        cohortHasSubjects!.add(CohortHasSubjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cohortHasSubjects != null) {
      data['cohort_has_subjects'] =
          cohortHasSubjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CohortHasSubjects {
  Grades? subjects;

  CohortHasSubjects({this.subjects});

  CohortHasSubjects.fromJson(json) {
    subjects =
        json['subjects'] != null ? Grades.fromJson(json['subjects']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.toJson();
    }
    return data;
  }
}

class Grades {
  int? iD;
  String? name;

  Grades({this.iD, this.name});

  Grades.fromJson(json) {
    iD = json['ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    return data;
  }
}

class StudentBarcode {
  Null studentDegree;
  CohortHasSubjects? examMission;

  StudentBarcode({this.studentDegree, this.examMission});

  StudentBarcode.fromJson(json) {
    studentDegree = json['StudentDegree'];
    examMission = json['exam_mission'] != null
        ? CohortHasSubjects.fromJson(json['exam_mission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StudentDegree'] = studentDegree;
    if (examMission != null) {
      data['exam_mission'] = examMission!.toJson();
    }
    return data;
  }
}

class StudentGradesResModel {
  String? firstName;
  String? secondName;
  String? thirdName;
  Grades? grades;
  Grades? schoolClass;
  Cohort? cohort;
  List<StudentSeatNumnbers>? studentSeatNumnbers;

  StudentGradesResModel(
      {this.firstName,
      this.secondName,
      this.thirdName,
      this.grades,
      this.schoolClass,
      this.cohort,
      this.studentSeatNumnbers});

  StudentGradesResModel.fromJson(json) {
    firstName = json['First_Name'];
    secondName = json['Second_Name'];
    thirdName = json['Third_Name'];
    grades = json['grades'] != null ? Grades.fromJson(json['grades']) : null;
    schoolClass = json['school_class'] != null
        ? Grades.fromJson(json['school_class'])
        : null;
    cohort = json['cohort'] != null ? Cohort.fromJson(json['cohort']) : null;
    if (json['student_seat_numnbers'] != null) {
      studentSeatNumnbers = <StudentSeatNumnbers>[];
      json['student_seat_numnbers'].forEach((v) {
        studentSeatNumnbers!.add(StudentSeatNumnbers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['First_Name'] = firstName;
    data['Second_Name'] = secondName;
    data['Third_Name'] = thirdName;
    if (grades != null) {
      data['grades'] = grades!.toJson();
    }
    if (schoolClass != null) {
      data['school_class'] = schoolClass!.toJson();
    }
    if (cohort != null) {
      data['cohort'] = cohort!.toJson();
    }
    if (studentSeatNumnbers != null) {
      data['student_seat_numnbers'] =
          studentSeatNumnbers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentSeatNumnbers {
  List<StudentBarcode>? studentBarcode;
  Grades? examRoom;

  StudentSeatNumnbers({this.studentBarcode, this.examRoom});

  StudentSeatNumnbers.fromJson(json) {
    if (json['student_barcode'] != null) {
      studentBarcode = <StudentBarcode>[];
      json['student_barcode'].forEach((v) {
        studentBarcode!.add(StudentBarcode.fromJson(v));
      });
    }
    examRoom =
        json['exam_room'] != null ? Grades.fromJson(json['exam_room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentBarcode != null) {
      data['student_barcode'] = studentBarcode!.map((v) => v.toJson()).toList();
    }
    if (examRoom != null) {
      data['exam_room'] = examRoom!.toJson();
    }
    return data;
  }
}
