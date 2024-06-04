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
            'FirstNameField': PlutoCell(value: element.firstName.toString()),
            'SecondNameField': PlutoCell(value: element.secondName.toString()),
            'ThirdNameField': PlutoCell(value: element.thirdName.toString()),
            'CohortField': PlutoCell(
                value: cohorts
                    .firstWhere((item) => item.iD == element.cohortID)
                    .name
                    .toString()),
            // 'ReligionField': PlutoCell(value: element.religion),
            // 'CitizenshipField': PlutoCell(value: element.citizenship),
            'GradeField': PlutoCell(
                value: grades
                    .firstWhere((item) => item.iD == element.gradesID)
                    .name
                    .toString()),
            'ClassRoomField': PlutoCell(
                value: classesRooms
                    .firstWhere((item) => item.iD == element.schoolClassID)
                    .name
                    .toString()),
            'LanguageField': PlutoCell(value: element.secondLang.toString()),
            'ActionsField': PlutoCell(value: 'Actions'),
          },
          // 'BlbId':PlutoCell(value: element.bLBID),
        ),
      );
    }
    return rows;
  }
}
