import 'package:pluto_grid/pluto_grid.dart';

import '../../Data/Models/class_room/class_room_res_model.dart';
import '../../Data/Models/cohort/cohort_res_model.dart';
import '../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../Data/Models/student/student_res_model.dart';
import '../../Data/Models/student_seat/student_seat_res_model.dart';
import '../../Data/Models/system_logger/system_logger_res_model.dart';

extension PlutoRowExtension on List<StudentResModel> {
  /// This function takes a list of students and returns a PlutoRow list based on each student's properties.
  ///
  /// The function will try to find the corresponding cohort, grade and class room for each student.
  /// If the student's properties are not found in the given lists, the function will return an error in the
  /// PlutoRow's cells.
  ///
  /// The function will also return a list of errors for each student that has an empty field.
  ///
  /// The return value is a map containing the list of PlutoRow, the list of students, and the errors.
  ///
  /// The function will return the following errors:
  ///
  /// - errorcohort: true if the function could not find a cohort for a student.
  /// - errorgrade: true if the function could not find a grade for a student.
  /// - errorclass: true if the function could not find a class room for a student.
  /// - errors: a list of strings containing the errors for each student.
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
      // if (secondLang == null || secondLang.isEmpty) {
      //   errors.add('LanguageField is empty');
      // }

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
            'CitizenshipField': PlutoCell(value: element.citizenship ?? ''),
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

  /// This function will convert the current list of [StudentPromoteFileResModel] to a list of [PlutoRow].
  ///
  /// The function will also return a map containing the list of PlutoRow, the list of students, and the errors.
  ///
  /// The return value is a map containing the list of PlutoRow, the list of students, and the errors.
  ///
  /// The function will return the following errors:
  ///
  /// - errorcohort: true if the function could not find a cohort for a student.
  /// - errorgrade: true if the function could not find a grade for a student.
  /// - errorclass: true if the function could not find a class room for a student.
  /// - errorBlbID: true if the function could not find a student with the given BlbId.
  ///
  /// The function will also return a list of students.
  ///
  /// The function will return a list of errors.
  Map<String, dynamic> convertPromoteFileStudentsToPluto({
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
            'LanguageField': PlutoCell(value: element.secondLang ?? ''),
            'ReligionField': PlutoCell(value: element.religion),
            'CitizenshipField': PlutoCell(value: element.citizenship ?? ''),
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

  /// This function will convert the current list of [StudentResModel] to a list of [PlutoRow].
  ///
  /// The function will return a list of [PlutoRow] that can be used to display the data in a table.
  ///
  /// The function will return the following columns:
  ///
  /// - BlbIdField: the blbId of the student.
  /// - FirstNameField: the first name of the student.
  /// - SecondNameField: the second name of the student.
  /// - ThirdNameField: the third name of the student.
  /// - CohortField: the name of the cohort of the student.
  /// - GradeField: the name of the grade of the student.
  /// - ClassRoomField: the name of the class room of the student.
  /// - LanguageField: the language of the student.
  /// - ReligionField: the religion of the student.
  /// - CitizenshipField: the citizenship of the student.
  /// - ActionsField: the actions of the student.
  ///
  /// The function will return a list of [PlutoRow].
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
            'CitizenshipField': PlutoCell(value: element.citizenship),
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
  /// This function will convert the current list of [StudentSeatNumberResModel] to a list of [PlutoRow].
  ///
  /// The function will return a list of [PlutoRow].
  ///
  /// The cells of the [PlutoRow] will contain the following values:
  ///
  /// - IdField: the id of the element.
  /// - BlbIdField: the blb id of the student.
  /// - StudentNameField: the name of the student.
  /// - SeatNumberField: the seat number of the student.
  /// - GradeField: the grade of the student.
  /// - ClassRoomField: the class room of the student.
  /// - CohortField: the cohort of the student.
  /// - ActionsField: the actions of the student.
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

extension PlutoRowSystemLogsExtansion on List<SystemLoggerResModel> {
  /// This function will convert the current list of [SystemLoggerResModel] to a list of [PlutoRow].
  ///
  /// The function will return a list of [PlutoRow].
  ///
  /// The cells of the [PlutoRow] will contain the following values:
  ///
  /// - Ip Field: the ip of the element.
  /// - UserAgent Field: the user agent of the element.
  /// - Body Field: the body of the element.
  /// - Platform Field: the platform of the element.
  /// - Url Field: the url of the element.
  /// - Method Field: the method of the element.
  /// - UserId Field: the user id of the element.
  /// - CreatedAt Field: the created at of the element.
  /// - Id Field: the id of the element.
  /// - ActionsField: the actions of the element.
  List<PlutoRow> convertSystemLogsToRows() {
    List<PlutoRow> rows = [];

    for (var element in this) {
      rows.add(
        PlutoRow(
          cells: {
            'Ip Field': PlutoCell(value: element.ip),
            'UserAgent Field': PlutoCell(value: element.userAgent),
            'Body Field': PlutoCell(value: element.body),
            'Platform Field': PlutoCell(value: element.platform),
            'Url Field': PlutoCell(value: element.url),
            'Method Field': PlutoCell(value: element.method),
            'UserId Field': PlutoCell(value: element.userId),
            'CreatedAt Field': PlutoCell(value: element.createdAt),
            'Id Field': PlutoCell(value: element.id.toString()),
            'ActionsField': PlutoCell(value: "Actions"),
          },
        ),
      );
    }

    return rows;
  }
}
