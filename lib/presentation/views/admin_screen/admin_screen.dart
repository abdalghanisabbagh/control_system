import 'package:control_system/presentation/resource_manager/styles_manager.dart';
import 'package:control_system/presentation/views/admin_screen/widgets/add_new_user.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        key: key,
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "Add New User", content: AddNewUserWidget());
              },
              child: Text(
                "Add New User",
                style: nunitoLightStyle(),
              ),
            )
          ],
        ));
  }
}
