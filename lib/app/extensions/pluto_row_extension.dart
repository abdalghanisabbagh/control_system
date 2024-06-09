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
            'IdField': PlutoCell(value: element.iD.toString()),
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
    Map<String, bool> errorMap = {};

    for (var element in this) {
      String? cohortName;
      bool isDefault = false;

      try {
        cohortName =
            cohorts.firstWhere((item) => item.name == element.cohortName).name;
      } catch (e) {
        cohortName = element.cohortName;
        isDefault = true;
      }

      rows.add(
        PlutoRow(
          cells: {
            'IdField': PlutoCell(value: element.iD.toString()),
            'FirstNameField': PlutoCell(value: element.firstName),
            'SecondNameField': PlutoCell(value: element.secondName),
            'ThirdNameField': PlutoCell(value: element.thirdName),
            'CohortField': PlutoCell(value: cohortName),
            'GradeField': PlutoCell(
              value: grades
                  .firstWhere((item) => item.name == element.gradeName,
                      orElse: () => GradeResModel(name: "Unknown Grade"))
                  .name,
            ),
            'ClassRoomField': PlutoCell(
              value: classesRooms
                  .firstWhere((item) => item.name == element.schoolClassName)
                  .name,
            ),
            'LanguageField': PlutoCell(value: element.secondLang),
            'ActionsField': PlutoCell(value: 'Actions'),
          },
        ),
      );

      errorMap[element.iD.toString()] = isDefault;
    }

    return {
      'rows': rows,
      'errorMap': errorMap,
    };
  }
}
