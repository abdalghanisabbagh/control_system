import 'package:pluto_grid/pluto_grid.dart';

import '../../Data/Models/class_room/class_room_res_model.dart';
import '../../Data/Models/cohort/cohort_res_model.dart';
import '../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../Data/Models/student/student_res_model.dart';
import '../../Data/Models/student_seat/student_seat_res_model.dart';

extension PlutoRowExtension on List<StudentResModel> {
  Map<String, dynamic> convertFileStudentsToPluto({
    required List<StudentResModel>? students,
    required List<CohortResModel> cohorts,
    required List<ClassRoomResModel> classesRooms,
    required List<GradeResModel> grades,
  }) {
    List<PlutoRow> rows = [];
    bool errorgrade = false;
    bool errorclass = false;
    bool errorcohort = false;
    List<String> errors = [];

    for (var element in this) {
      String? cohortName;
      int? cohortId;
      String? gradeName;
      int? gradeId;
      String? schoolClassName;
      int? schoolClassId;
      String? blbId;

      try {
        final cohort =
            cohorts.firstWhere((item) => item.name == element.cohortName);

        cohortName = cohort.name;
        cohortId = cohort.iD;

        element.cohortID = cohortId;
      } catch (e) {
        cohortName = '[ERROR] ${element.cohortName}';
        errorcohort = true;
      }

      try {
        final grade =
            grades.firstWhere((item) => item.name == element.gradeName);
        gradeName = grade.name;
        gradeId = grade.iD;
        element.gradesID = gradeId;
      } catch (e) {
        gradeName = '[ERROR] ${element.gradeName}';
        errorgrade = true;
      }
      try {
        final schoolClass = classesRooms
            .firstWhere((item) => item.name == element.schoolClassName);
        schoolClassName = schoolClass.name;
        schoolClassId = schoolClass.iD;
        element.schoolClassID = schoolClassId;
      } catch (e) {
        schoolClassName = '[ERROR] ${element.schoolClassName}';
        errorclass = true;
      }
      String? firstName = element.firstName;
      if (firstName == null || firstName.isEmpty) {
        errors.add('FirstNameField is empty');
        //  hasError = true;
      }

      String? secondName = element.secondName;
      if (secondName == null || secondName.isEmpty) {
        errors.add('SecondNameField is empty');
        //  hasError = true;
      }

      String? thirdName = element.thirdName;
      // if (thirdName == null || thirdName.isEmpty) {
      //   errors.add('ThirdNameField is empty');
      //   //  hasError = true;
      // }

      String? secondLang = element.secondLang;
      if (secondLang == null || secondLang.isEmpty) {
        errors.add('LanguageField is empty');
      }

      try {
        final blb = students!.firstWhere((item) => item.blbId == element.blbId);
        blbId = blb.blbId.toString();
        blbId = "[ERROR] $blbId";
      } catch (e) {
        blbId = " ${element.blbId}";
      }

      rows.add(
        PlutoRow(
          cells: {
            'BlbIdField': PlutoCell(value: blbId),
            'FirstNameField': PlutoCell(value: firstName ?? ''),
            'SecondNameField': PlutoCell(value: secondName ?? ''),
            'ThirdNameField': PlutoCell(value: thirdName ?? ''),
            'CohortField': PlutoCell(value: cohortName),
            'GradeField': PlutoCell(value: gradeName),
            'ClassRoomField': PlutoCell(value: schoolClassName),
            'LanguageField': PlutoCell(value: secondLang ?? ''),
            'ReligionField': PlutoCell(value: element.religion),
            'ActionsField': PlutoCell(value: 'Actions'),
          },
        ),
      );
    }

    return {
      'rows': rows,
      'students': this,
      'errorcohort': errorcohort,
      'errorgrade': errorgrade,
      'errorclass': errorclass,
      'errors': errors,
    };
  }

  Map<String, dynamic> convertPromtoFileStudentsToPluto({
    required List<StudentResModel> students,
    required List<CohortResModel> cohorts,
    required List<ClassRoomResModel> classesRooms,
    required List<GradeResModel> grades,
  }) {
    List<PlutoRow> rows = [];
    bool errorgrade = false;
    bool errorclass = false;
    bool errorcohort = false;
    bool errorBlbID = false;

    for (var element in this) {
      String? cohortName;
      int? cohortId;
      String? gradeName;
      int? gradeId;
      String? schoolClassName;
      int? schoolClassId;
      String? blbId;
      int? studentId;

      try {
        final cohort =
            cohorts.firstWhere((item) => item.name == element.cohortName);

        cohortName = cohort.name;
        cohortId = cohort.iD;

        element.cohortID = cohortId;
      } catch (e) {
        cohortName = '[ERROR] ${element.cohortName}';
        errorcohort = true;
      }

      try {
        final grade =
            grades.firstWhere((item) => item.name == element.gradeName);
        gradeName = grade.name;
        gradeId = grade.iD;
        element.gradesID = gradeId;
      } catch (e) {
        gradeName = '[ERROR] ${element.gradeName}';
        errorgrade = true;
      }
      try {
        final schoolClass = classesRooms
            .firstWhere((item) => item.name == element.schoolClassName);
        schoolClassName = schoolClass.name;
        schoolClassId = schoolClass.iD;
        element.schoolClassID = schoolClassId;
      } catch (e) {
        schoolClassName = '[ERROR] ${element.schoolClassName}';
        errorclass = true;
      }
      try {
        final blb = students.firstWhere((item) => item.blbId == element.blbId);
        blbId = blb.blbId.toString();
        studentId = blb.iD;
        element.iD = studentId;
      } catch (e) {
        blbId = "[ERROR] ${element.blbId}";
        errorBlbID = true;
      }
      rows.add(
        PlutoRow(
          cells: {
            'BlbIdField': PlutoCell(value: blbId),
            'FirstNameField': PlutoCell(value: element.firstName),
            'SecondNameField': PlutoCell(value: element.secondName),
            'ThirdNameField': PlutoCell(value: element.thirdName),
            'CohortField': PlutoCell(value: cohortName),
            'GradeField': PlutoCell(value: gradeName),
            'ClassRoomField': PlutoCell(value: schoolClassName),
            'LanguageField': PlutoCell(value: element.secondLang),
            'ReligionField': PlutoCell(value: element.religion),
            'ActionsField': PlutoCell(value: 'Actions'),
          },
        ),
      );
    }

    return {
      'rows': rows,
      'students': this,
      'errorcohort': errorcohort,
      'errorgrade': errorgrade,
      'errorclass': errorclass,
      'errorBlbID': errorBlbID
    };
  }

  List<PlutoRow> convertStudentsToRows() {
    List<PlutoRow> rows = [];
    for (var element in this) {
      rows.add(
        PlutoRow(
          cells: {
            'BlbIdField': PlutoCell(value: element.blbId.toString()),
            'FirstNameField': PlutoCell(value: element.firstName),
            'SecondNameField': PlutoCell(value: element.secondName),
            'ThirdNameField': PlutoCell(
              value: element.thirdName,
            ),
            'CohortField': PlutoCell(
              value: element.cohortResModel!.name,
            ),
            'GradeField': PlutoCell(
              value: element.gradeResModel!.name,
            ),
            'ClassRoomField': PlutoCell(
              value: element.classRoomResModel!.name,
            ),
            'LanguageField': PlutoCell(value: element.secondLang),
            'ReligionField': PlutoCell(value: element.religion),
            'ActionsField': PlutoCell(value: 'Actions'),
          },
        ),
      );
    }
    return rows;
  }
}

extension PlutoRowStudentSeatsNumbersExtansion
    on List<StudentSeatNumberResModel> {
  List<PlutoRow> convertStudentsToRows() {
    List<PlutoRow> rows = [];

    for (var element in this) {
      rows.add(
        PlutoRow(
          cells: {
            'IdField': PlutoCell(value: element.iD.toString()),
            'BlbIdField': PlutoCell(value: element.student!.blbId.toString()),
            'StudentNameField': PlutoCell(
                value:
                    "${element.student!.firstName} ${element.student!.secondName}"),
            'SeatNumberField': PlutoCell(
              value: element.seatNumber.toString(),
            ),
            'GradeField': PlutoCell(
                value: element.student!.gradeResModel!.name.toString()),
            'ClassRoomField': PlutoCell(
              value: element.student!.classRoomResModel!.name.toString(),
            ),
            'CohortField': PlutoCell(
                value: element.student!.cohortResModel!.name.toString()),
            'ActionsField': PlutoCell(value: element.active.toString()),
          },
        ),
      );
    }

    return rows;
  }
}
