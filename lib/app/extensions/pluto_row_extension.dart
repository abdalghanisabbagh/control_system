import 'package:control_system/Data/Models/student/student_res_model.dart';
import 'package:pluto_grid/pluto_grid.dart';

extension PlutoRowExtension on List<StudentResModel> {
  List<PlutoRow> convertStudentsToRows() {
    List<PlutoRow> rows = [];
    for (var element in this) {
      rows.add(
        PlutoRow(
          cells: {
            // 'Id': PlutoCell(value: element.iD.toString()),
            'FirstNameField': PlutoCell(value: element.firstName.toString()),
            'SecondNameField': PlutoCell(value: element.secondName.toString()),
            'ThirdNameField': PlutoCell(value: element.thirdName.toString()),
            'CohortField': PlutoCell(value: element.cohortID.toString()),
            // 'ReligionField': PlutoCell(value: element.religion),
            // 'CitizenshipField': PlutoCell(value: element.citizenship),
            'GradeField': PlutoCell(value: element.gradesID.toString()),
            'ClassRoomField':
                PlutoCell(value: element.schoolClassID.toString()),
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
