import 'package:flutter/material.dart';

import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/my_back_button.dart';
import '../../resource_manager/styles_manager.dart';
import '../base_screen.dart';
import 'widgets/add_new_user.dart';

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
              MyDialogs.showDialog(
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
