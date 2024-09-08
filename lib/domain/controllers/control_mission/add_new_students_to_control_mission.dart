import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/student/student_res_model.dart';
import '../../../Data/Models/student/students_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../app/extensions/pluto_row_extension.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class AddNewStudentsToControlMissionController extends GetxController {
  int controlMissionId = Hive.box('ControlMission').get('Id') ?? 0;
  String controlMissionName = Hive.box('ControlMission').get('Name') ?? '';
  List<PlutoRow> excludedStudentsRows = [];
  PlutoGridStateManager? excludedStudentsStateManager;
  List<GradeResModel> grades = [];
  List<int> includedStudentsIds = [];
  List<PlutoRow> includedStudentsRows = [];
  PlutoGridStateManager? includedStudentsStateManager;
  bool isLoading = false;
  List<ValueItem> optionsGrades = [];
  List<int> selectedGradesIds = [];
  List<StudentResModel> students = [];

  Future<bool> addStudentsToControlMission() async {
    if (includedStudentsIds.isEmpty) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please select students',
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      return false;
    }

    bool success = false;
    isLoading = true;
    update();
    List<int> blbIds = includedStudentsRows
        .map((e) => int.parse(e.cells['BlbIdField']!.value))
        .toList();
    includedStudentsIds = students
        .where((e) => blbIds.contains(e.blbId))
        .map(
          (e) => e.iD!,
        )
        .toList();
    final response = await ResponseHandler<void>().getResponse(
      path: ControlMissionLinks.studentSeatNumbers,
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: {
        'Student_IDs': includedStudentsIds,
        'controlMissionId': controlMissionId,
      },
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
        success = false;
      },
      (r) {
        includedStudentsRows.clear();
        includedStudentsIds.clear();
        includedStudentsStateManager?.notifyListeners();
        success = true;
      },
    );
    isLoading = false;
    update();
    getStudents();
    return success;
  }

  void excludeStudent(PlutoColumnRendererContext rendererContext) {
    excludedStudentsRows.add(includedStudentsRows.firstWhere((element) =>
        element.cells['BlbIdField']!.value ==
        rendererContext.row.cells['BlbIdField']!.value));
    includedStudentsRows.removeWhere((element) =>
        element.cells['BlbIdField']!.value ==
        rendererContext.row.cells['BlbIdField']!.value);
    includedStudentsStateManager?.notifyListeners();
    excludedStudentsStateManager?.setPage(1);
  }

  Future<bool> getGrades() async {
    bool gotData = false;
    update();

    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();
    Either<Failure, GradesResModel> response =
        await responseHandler.getResponse(
      path: GradeLinks.gradesSchools,
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        gotData = false;
      },
      (r) {
        grades = r.data!;
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsGrades = items;
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  Future<bool> getStudents() async {
    bool gotData = false;
    update();

    ResponseHandler<StudentsResModel> responseHandler = ResponseHandler();
    Either<Failure, StudentsResModel> response =
        await responseHandler.getResponse(
      path:
          '${StudentsLinks.student}/excluded/controlMission/$controlMissionId',
      converter: StudentsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        gotData = false;
      },
      (r) {
        students = r.students!;
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  void includeStudent(PlutoColumnRendererContext rendererContext) {
    includedStudentsRows.add(excludedStudentsRows.firstWhere((element) =>
        element.cells['BlbIdField']!.value ==
        rendererContext.row.cells['BlbIdField']!.value));
    excludedStudentsRows.removeWhere((element) =>
        element.cells['BlbIdField']!.value ==
        rendererContext.row.cells['BlbIdField']!.value);
    includedStudentsStateManager?.setPage(1);
    excludedStudentsStateManager?.notifyListeners();
  }

  @override
  void onInit() async {
    isLoading = true;
    update();
    await getGrades().then((_) async {
      await Future.wait(
        [
          getStudents(),
        ],
      );
    });
    isLoading = false;
    update();
    super.onInit();
  }

  void updateSelectedGrades(List<ValueItem> selectedOptions) {
    selectedGradesIds = selectedOptions.map((e) => e.value as int).toList();

    includedStudentsRows.assignAll(
      students
          .where((student) => selectedGradesIds.contains(student.gradesID))
          .toList()
          .convertStudentsToRows(),
    );
    update();
    excludedStudentsRows.clear();
    includedStudentsStateManager?.setPage(1);
    excludedStudentsStateManager?.setPage(1);
  }
}
