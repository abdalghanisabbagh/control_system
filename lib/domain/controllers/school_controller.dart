import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/school/school_response/school_res_model.dart';
import 'package:control_system/Data/Models/school/school_response/schools_res_model.dart';
import 'package:control_system/Data/Models/user/login_response/login_res_model.dart';
import 'package:control_system/Data/enums/req_type_enum.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../Data/Network/response_handler.dart';

class SchoolController extends GetxController {
  List<SchoolResModel> schools = <SchoolResModel>[];
  List schoolType = [];
  bool isLoading = false;
  RxList<ValueItem> selectedOptions = <ValueItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllSchools();
  }

  addNewSchoolType({
    required String schoolType,
  }) async {
    // var response =
    //     await SchoolServices.addNewSchoolType(schoolType: schoolType);
  }

  getSchoolTypes() async {}

  addNewSchool() async {}
  getSchool() async {}

  // final List<ValueItem> options = const <ValueItem>[
  //   ValueItem(label: 'Option 1', value: 1),
  //   ValueItem(label: 'Option 2', value: 2),
  //   ValueItem(label: 'Option 3', value: 3),
  //   ValueItem(label: 'Option 4', value: 4),
  //   ValueItem(label: 'Option 5', value: 5),
  //   ValueItem(label: 'Option 6', value: 6),
  // ];

  // void onOptionSelected(List<ValueItem> selectedOptions) {
  //   this.selectedOptions.value = selectedOptions;
  // }

  Future<bool> getAllSchools() async {
    isLoading = true;
    update();
    ResponseHandler<SchoolsResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: SchoolsLinks.getAllSchools,
      converter: SchoolsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((fauilr) {
      /// handel error
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }, (result) {
// handel el response

      schools = result.data!;
      isLoading = false;
      update();
    });

    // response.fold(
    //     (l) => MyAwesomeDialogue(
    //           title: 'Error',
    //           desc: l.message,
    //           dialogType: DialogType.error,
    //         ).showDialogue(Get.key.currentContext!), (r) {
    //  print(r.data);
    // r.data?.forEach((element) {
    //   schools.add(element);
    // print(schools.length);
    // });

    // //  isLogin.value = true;
    // // isLoading.value = false;
    // });

    //isLoading.value = false;
    return true;
  }
}
