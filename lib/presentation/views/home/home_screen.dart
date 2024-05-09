import 'package:control_system/app/generated/keys.dart';
import 'package:control_system/domain/controllers/home_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.title),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          children: [
            DropDownWidget(),
          ],
        ),
      ),
    );
  }
}
