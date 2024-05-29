import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/school/grade_response/grades_res_model.dart';
import 'package:control_system/Data/enums/req_type_enum.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Network/response_handler.dart';

class AddNewStudentController extends GetxController {
  bool isLoadingGrades = false;
  List<ValueItem> options = <ValueItem>[];

  void onInit() {
    super.onInit();
    getGradesBySchoolId();
  }

  Future<bool> getGradesBySchoolId() async {
    isLoadingGrades = true;
    update();
    bool gradeHasBeenAdded = false;
    print(Hive.box('School').get('Id'));

    int selectedSchoolId = Hive.box('School').get('Id');
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: "${SchoolsLinks.gradesSchools}/$selectedSchoolId",
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      gradeHasBeenAdded = false;
    }, (result) {
      List<ValueItem> items = result.data!
          .map((item) => ValueItem(label: item.name!, value: item.iD))
          .toList();
      options = items;
    });
    isLoadingGrades = false;
    gradeHasBeenAdded = true;
    update();
    return gradeHasBeenAdded;
  }
}
