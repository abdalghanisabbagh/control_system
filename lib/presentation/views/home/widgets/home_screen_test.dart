import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/home_controller.dart';
import '../../../resource_manager/ReusableWidget/customized_button.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';

class HomeScreenTest extends GetView<HomeController> {
  const HomeScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MultiSelectDropDownView(
            options: controller.options,
            onOptionSelected: controller.onOptionSelected,
          ),
          CustomizedButton(
            buttonTitle: "Success",
            onPressed: () {
              MyFlashBar.showSuccess("hi", "hello").show(context);
            },
          )
        ],
      ),
    );
  }
}
