import 'package:control_system/domain/controllers/SeatingNumbersControllers/CreateCoversSheetsController.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
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
                  style: nunitoBoldStyle()
                      .copyWith(fontSize: 30, color: ColorManager.bgSideMenu),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  // Get.defaultDialog(
                  //     title: "Add New Cover",
                  //     content: const AddNewCoverWidget());
                  MyDialogs.showAddDialog(context, const AddNewCoverWidget());
                },
                tooltip: "Add New Cover",
                icon: Icon(
                  Icons.add,
                  color: ColorManager.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
