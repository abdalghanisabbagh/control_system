import 'package:flutter/material.dart';

import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/color_manager.dart';
import '../../resource_manager/styles_manager.dart';
import '../base_screen.dart';
import 'widgets/add_new_user_widget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Admin",
                  style: nunitoBlack.copyWith(
                    color: ColorManager.bgSideMenu,
                    fontSize: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    MyDialogs.showDialog(
                      context,
                      const AddNewUserWidget(),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.glodenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Add New User",
                          style: nunitoBold.copyWith(
                            color: ColorManager.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
