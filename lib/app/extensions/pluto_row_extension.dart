import 'package:pluto_grid/pluto_grid.dart';

import '../../Data/Models/class_room/class_room_res_model.dart';
import '../../Data/Models/cohort/cohort_res_model.dart';
import '../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../Data/Models/student/student_res_model.dart';

extension PlutoRowExtension on List<StudentResModel> {
  List<PlutoRow> convertStudentsToRows({
    required List<CohortResModel> cohorts,
    required List<ClassRoomResModel> classesRooms,
    required List<GradeResModel> grades,
  }) {
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
              value: cohorts
                  .firstWhere((item) => item.iD == element.cohortID)
                  .name,
            ),
            'GradeField': PlutoCell(
              value:
                  grades.firstWhere((item) => item.iD == element.gradesID).name,
            ),
            'ClassRoomField': PlutoCell(
              value: classesRooms
                  .firstWhere((item) => item.iD == element.schoolClassID)
                  .name,
            ),
            'LanguageField': PlutoCell(value: element.secondLang),
            'ActionsField': PlutoCell(value: 'Actions'),
          },
        ),
      );
    }
    return rows;
  }

  Map<String, dynamic> convertFileStudentsToPluto({
    required List<CohortResModel> cohorts,
    required List<ClassRoomResModel> classesRooms,
    required List<GradeResModel> grades,
  }) {
    List<PlutoRow> rows = [];

    for (var element in this) {
      String? cohortName;
      int? cohortId;
      String? gradeName;
      int? gradeId;
      String? schoolClassName;
      int? schoolClassId;

      try {
        final cohort =
            cohorts.firstWhere((item) => item.name == element.cohortName);

        cohortName = cohort.name;
        cohortId = cohort.iD;

        element.cohortID = cohortId;
      } catch (e) {
        cohortName = '[ERROR] ${element.cohortName}';
      }

      try {
        final grade =
            grades.firstWhere((item) => item.name == element.gradeName);
        gradeName = grade.name;
        gradeId = grade.iD;
        element.gradesID = gradeId;
      } catch (e) {
        gradeName = '[ERROR] ${element.gradeName}';
      }
      try {
        final schoolClass = classesRooms
            .firstWhere((item) => item.name == element.schoolClassName);
        schoolClassName = schoolClass.name;
        schoolClassId = schoolClass.iD;
        element.schoolClassID = schoolClassId;
      } catch (e) {
        schoolClassName = '[ERROR] ${element.schoolClassName}';
      }

      rows.add(
        PlutoRow(
          cells: {
            'BlbIdField': PlutoCell(value: element.blbId.toString()),
            'FirstNameField': PlutoCell(value: element.firstName),
            'SecondNameField': PlutoCell(value: element.secondName),
            'ThirdNameField': PlutoCell(value: element.thirdName),
            'CohortField': PlutoCell(value: cohortName),
            'GradeField': PlutoCell(value: gradeName),
            'ClassRoomField': PlutoCell(value: schoolClassName),
            'LanguageField': PlutoCell(value: element.secondLang),
            'ActionsField': PlutoCell(value: 'Actions'),
          },
        ),
      );
    }

    return {'rows': rows, 'students': this};
  }
}
