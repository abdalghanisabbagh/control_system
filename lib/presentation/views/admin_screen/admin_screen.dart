import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_back_button.dart';
import 'package:control_system/presentation/resource_manager/styles_manager.dart';
import 'package:control_system/presentation/views/admin_screen/widgets/add_new_user.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';

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
              MyDialogs.showAddDialog(
                context,
                AddNewUserWidget(),
              );
            },
            child: Text(
              "Add New User",
              style: nunitoLightStyle(),
            ),
          ),
          const MyBackButton()
        ],
      ),
    );
  }
}
