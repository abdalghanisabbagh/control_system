import 'package:control_system/domain/controllers/home_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/customized_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            MultiSelectDropDownView(
              options: controller.options,
              onOptionSelected: controller.onOptionSelected,
            ),
            CustomizedButton(
              buttonTitle: "lkjhgfds",
              onPressed: () {
                MyReusbleWidget.show(context, "content","dsad");
              },
            )
          ],
        ),
      ),
    );
  }
}
