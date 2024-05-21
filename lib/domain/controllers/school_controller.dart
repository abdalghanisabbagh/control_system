import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

class SchoolController extends GetxController {
  List schools = [];
  List schoolType = [];
  bool isLoading = false;
  RxList<ValueItem> selectedOptions = <ValueItem>[].obs;

  addNewSchoolType({
    required String schoolType,
  }) async {
    // var response =
    //     await SchoolServices.addNewSchoolType(schoolType: schoolType);
  }

  getSchoolTypes() async {}

  addNewSchool() async {}
  getSchool() async {}

  final List<ValueItem> options = const <ValueItem>[
    ValueItem(label: 'Option 1', value: 1),
    ValueItem(label: 'Option 2', value: 2),
    ValueItem(label: 'Option 3', value: 3),
    ValueItem(label: 'Option 4', value: 4),
    ValueItem(label: 'Option 5', value: 5),
    ValueItem(label: 'Option 6', value: 6),
  ];

  void onOptionSelected(List<ValueItem> selectedOptions) {
    this.selectedOptions.value = selectedOptions;
  }
}
