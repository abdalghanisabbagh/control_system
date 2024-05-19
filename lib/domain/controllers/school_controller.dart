import 'package:control_system/Data/Network/Services/school_services.dart';
import 'package:get/get.dart';

class SchoolController extends GetxController {
  List schools = [];
  List schoolType = [];
  bool isLoading = false;

  addNewSchoolType({
    required String schoolType,
  }) async {
    var response = await SchoolServices.addNewSchoolType(
        token: "token", schoolType: schoolType);
  }

  getSchoolTypes() async {}

  addNewSchool() async {}
  getSchool() async {}

  @override
  void onInit() {
    super.onInit();
  }
}
