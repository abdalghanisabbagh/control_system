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
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

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

  /// A function that adds the selected students to the control mission with the given [controlMissionId]
  /// and returns a boolean indicating whether the operation was successful.
  ///
  /// The function takes no parameters.
  ///
  /// The function will return false if the user has not selected any students.
  ///
  /// The function will show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will clear the selected students and their IDs from the UI
  /// and notify the listeners of the [includedStudentsStateManager] to update the UI.
  Future<bool> addStudentsToControlMission() async {
    if (includedStudentsRows.isEmpty) {
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

  /// This function excludes a student from the control mission.
  ///
  /// It takes a [PlutoColumnRendererContext] as a parameter.
  ///
  /// The function will remove the student from the [includedStudentsRows] and add it to the [excludedStudentsRows].
  ///
  /// It will also notify the listeners of the [includedStudentsStateManager] and [excludedStudentsStateManager] to update the UI.
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

  /// A function that gets all the grades from the server and returns a boolean indicating whether the grades were retrieved successfully.
  ///
  /// The function takes no parameters.
  ///
  /// The function will show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update the UI with the grades and their IDs.
  ///
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

  /// A function that gets the students that are not included in the control mission
  /// with the given [controlMissionId] and returns a boolean indicating whether
  /// the students were retrieved successfully.
  ///
  /// The function will show a loading indicator while the request is being
  /// processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the
  /// failure message.
  ///
  /// If the response is successful, the function will update the UI with the
  /// students.
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

  /// A function that includes a student from the excluded students list to the
  /// included students list.
  ///
  /// It takes a [PlutoColumnRendererContext] as a parameter.
  ///
  /// The function will remove the student from the [excludedStudentsRows] and add
  /// it to the [includedStudentsRows].
  ///
  /// It will also notify the listeners of the [includedStudentsStateManager] and
  /// [excludedStudentsStateManager] to update the UI.
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

  /// This is the onInit function of the AddNewStudentsToControlMissionController class.
  ///
  /// It is called when the controller is initialized.
  ///
  /// It sets the [isLoading] variable to true and then calls the [getGrades]
  /// function. When the [getGrades] function is finished, it calls the
  /// [getStudents] function. When the [getStudents] function is finished, it sets
  /// the [isLoading] variable to false and updates the UI.
  ///
  /// This function is necessary to load the grades and the students when the
  /// controller is initialized.
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

  /// This function updates the [includedStudentsRows] and [excludedStudentsRows]
  /// variables when the selected grades are changed.
  ///
  /// It takes a list of [ValueItem]s as a parameter which represents the
  /// selected grades.
  ///
  /// It updates the [includedStudentsRows] by filtering the [students] list
  /// based on the selected grades and then converts the filtered list to rows.
  ///
  /// It clears the [excludedStudentsRows] and updates the page of the
  /// [includedStudentsStateManager] and [excludedStudentsStateManager].
  ///
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
