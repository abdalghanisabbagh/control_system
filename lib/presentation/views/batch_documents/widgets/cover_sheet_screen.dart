import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/profile_controller.dart';
import '../../../../domain/controllers/seating_numbers_controllers/create_covers_sheets_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/index.dart';
import 'add_new_cover_widget.dart';

class CoverSheetsScreen extends GetView<CreateCoversSheetsController> {
  const CoverSheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Cover Sheet",
                  style: nunitoBoldStyle().copyWith(fontSize: 30),
                ),
              ),
            ),
            Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '3100',
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    // Get.defaultDialog(
                    //     title: "Add New Cover",
                    //     content: const AddNewCoverWidget());
                    MyDialogs.showDialog(context, const AddNewCoverWidget());
                  },
                  tooltip: "Add New Cover",
                  icon: const Icon(
                    Icons.add,
                    color: ColorManager.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
