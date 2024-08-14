import 'package:control_system/Data/Models/barcodes/barcode_res_model.dart';
import 'package:control_system/Data/Models/class_room/class_room_res_model.dart';

class Cohort {
  int? iD;
  String? name;
  List<CohortHasSubjects>? cohortHasSubjects;

  Cohort({this.iD, this.name, this.cohortHasSubjects});

  Cohort.fromJson(json) {
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
  ExamRoom? subjects;

  CohortHasSubjects({this.subjects});

  CohortHasSubjects.fromJson(json) {
    subjects =
        json['subjects'] != null ? ExamRoom.fromJson(json['subjects']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.toJson();
    }
    return data;
  }
}

class ExamMission {
  ExamRoom? subjects;
  ExamRoom? grades;

  ExamMission({this.subjects, this.grades});

  ExamMission.fromJson(json) {
    subjects =
        json['subjects'] != null ? ExamRoom.fromJson(json['subjects']) : null;
    grades = json['grades'] != null ? ExamRoom.fromJson(json['grades']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.toJson();
    }
    if (grades != null) {
      data['grades'] = grades!.toJson();
    }
    return data;
  }
}

class ExamRoom {
  int? iD;
  String? name;

  ExamRoom({this.iD, this.name});

  ExamRoom.fromJson(json) {
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
  String? firstName;
  String? secondName;
  String? thirdName;
  int? iD;
  Cohort? cohort;
  ClassRoomResModel? classRoom;

  Student(
      {this.firstName,
      this.secondName,
      this.thirdName,
      this.iD,
      this.cohort,
      this.classRoom});

  Student.fromJson(json) {
    firstName = json['First_Name'];
    secondName = json['Second_Name'];
    thirdName = json['Third_Name'];
    iD = json['ID'];
    cohort = json['cohort'] != null ? Cohort.fromJson(json['cohort']) : null;
    classRoom = json['school_class'] != null
        ? ClassRoomResModel.fromJson(json['school_class'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['First_Name'] = firstName;
    data['Second_Name'] = secondName;
    data['Third_Name'] = thirdName;
    data['ID'] = iD;
    if (cohort != null) {
      data['cohort'] = cohort!.toJson();
    }
    if (classRoom != null) {
      data['school_class'] = classRoom!.toJson();
    }
    return data;
  }
}

class StudentGradesResModel {
  List<ExamRoom>? examRoom;
  List<ExamMission>? examMission;
  List<StudentSeatNumnbers>? studentSeatNumnbers;

  StudentGradesResModel(
      {this.examRoom, this.examMission, this.studentSeatNumnbers});

  StudentGradesResModel.fromJson(json) {
    if (json['exam_room'] != null) {
      examRoom = <ExamRoom>[];
      json['exam_room'].forEach((v) {
        examRoom!.add(ExamRoom.fromJson(v));
      });
    }
    if (json['exam_mission'] != null) {
      examMission = <ExamMission>[];
      json['exam_mission'].forEach((v) {
        examMission!.add(ExamMission.fromJson(v));
      });
    }
    if (json['student_seat_numnbers'] != null) {
      studentSeatNumnbers = <StudentSeatNumnbers>[];
      json['student_seat_numnbers'].forEach((v) {
        studentSeatNumnbers!.add(StudentSeatNumnbers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examRoom != null) {
      data['exam_room'] = examRoom!.map((v) => v.toJson()).toList();
    }
    if (examMission != null) {
      data['exam_mission'] = examMission!.map((v) => v.toJson()).toList();
    }
    if (studentSeatNumnbers != null) {
      data['student_seat_numnbers'] =
          studentSeatNumnbers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentSeatNumnbers {
  Student? student;
  List<BarcodeResModel>? barcode;

  StudentSeatNumnbers({this.student, this.barcode});

  StudentSeatNumnbers.fromJson(json) {
    student =
        json['student'] != null ? Student.fromJson(json['student']) : null;
    barcode = List<BarcodeResModel>.from(
      json['student_barcode']
          .map((student) => BarcodeResModel.fromJson(student)),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (barcode != null) {
      data['student_barcode'] = barcode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
