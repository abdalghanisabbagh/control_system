import 'package:control_system/domain/controllers/dropdown_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DropDownButtonController>(() => DropDownButtonController());
  }
}
