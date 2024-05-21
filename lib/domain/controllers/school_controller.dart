import 'package:get/get.dart';

class SchoolController extends GetxController {
  List schools = [];
  List schoolType = [];
  bool isLoading = false;

  addNewSchoolType({
    required String schoolType,
  }) async {
    // var response =
    //     await SchoolServices.addNewSchoolType(schoolType: schoolType);
  }

  getSchoolTypes() async {}

  addNewSchool() async {}
  getSchool() async {}
}
