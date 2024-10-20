import 'package:control_system/Data/Models/exam_mission/exam_mission_res_model.dart';

class Barcode {
  int? id;

  String? studentDegree;

  ExamMissionResModel? examMission;

  Barcode({this.id, this.studentDegree});
  Barcode.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    studentDegree = json['StudentDegree'];
    if (json['exam_mission'] != null) {
      examMission = ExamMissionResModel.fromJson(json['exam_mission']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['StudentDegree'] = studentDegree;
    if (examMission != null) {
      data['exam_mission'] = examMission!.toJson();
    }
    return data;
  }
}

class Cohort {
  List<CohortHasSubjects>? cohortHasSubjects;

  int? iD;

  String? name;
  Cohort({this.iD, this.name, this.cohortHasSubjects});
  Cohort.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    if (json['cohort_has_subjects'] != null) {
      cohortHasSubjects = <CohortHasSubjects>[];
      json['cohort_has_subjects'].forEach((v) {
        cohortHasSubjects!.add(CohortHasSubjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
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

  CohortHasSubjects.fromJson(Map<String, dynamic> json) {
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

class ExamRoom {
  int? iD;

  String? name;

  List<StudentSeatNumbers>? studentSeatNumbers;
  ExamRoom({this.iD, this.name, this.studentSeatNumbers});
  ExamRoom.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    if (json['student_seat_numbers'] != null) {
      studentSeatNumbers = <StudentSeatNumbers>[];
      json['student_seat_numbers'].forEach((v) {
        studentSeatNumbers!.add(StudentSeatNumbers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    if (studentSeatNumbers != null) {
      data['student_seat_numbers'] =
          studentSeatNumbers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grades {
  int? iD;

  String? name;

  Grades({this.iD, this.name});
  Grades.fromJson(Map<String, dynamic> json) {
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

class SchoolClass {
  int? iD;

  String? name;

  SchoolClass({this.iD, this.name});
  SchoolClass.fromJson(Map<String, dynamic> json) {
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

class Student {
  List<Barcode>? barcode;

  Cohort? cohort;

  String? firstName;
  Grades? grades;
  SchoolClass? schoolClass;
  String? secondName;
  String? thirdName;
  Student({
    this.firstName,
    this.secondName,
    this.thirdName,
    this.grades,
    this.schoolClass,
    this.cohort,
    this.barcode,
  });
  Student.fromJson(Map<String, dynamic> json) {
    firstName = json['First_Name'];
    secondName = json['Second_Name'];
    thirdName = json['Third_Name'];
    grades = json['grades'] != null ? Grades.fromJson(json['grades']) : null;
    schoolClass = json['school_class'] != null
        ? SchoolClass.fromJson(json['school_class'])
        : null;
    cohort = json['cohort'] != null ? Cohort.fromJson(json['cohort']) : null;
    if (json['student_barcode'] != null &&
        (json['student_barcode'] as List).isNotEmpty) {
      barcode = List<Barcode>.from(
        json['student_barcode'].map((barcode) => Barcode.fromJson(barcode)),
      );
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
    if (barcode != null) {
      data['student_barcode'] = List.from(barcode!.map((v) => v.toJson()));
    }
    return data;
  }
}

class StudentGradesResModel {
  List<ExamRoom>? examRoom;

  StudentGradesResModel({this.examRoom});

  StudentGradesResModel.fromJson(json) {
    if (json['exam_room'] != null) {
      examRoom = <ExamRoom>[];
      json['exam_room'].forEach((v) {
        examRoom!.add(ExamRoom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examRoom != null) {
      data['exam_room'] = examRoom!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentSeatNumbers {
  int? iD;

  String? seatNumber;

  Student? student;
  StudentSeatNumbers({this.iD, this.seatNumber, this.student});
  StudentSeatNumbers.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    seatNumber = json['Seat_Number'];
    student =
        json['student'] != null ? Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Seat_Number'] = seatNumber;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    return data;
  }
}
