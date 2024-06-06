import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:flutter/material.dart';

import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/color_manager.dart';
import '../../resource_manager/styles_manager.dart';
import '../base_screen.dart';
import 'widgets/add_new_screen_widget.dart';

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: HeaderWidget(text: "Roles"),
                ),
                InkWell(
                  onTap: () {
                    MyDialogs.showDialog(
                      context,
                      const AddNewScreenWidget(),
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
                          "Add New Screen",
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
