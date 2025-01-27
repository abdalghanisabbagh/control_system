import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/profile_controller.dart';
import '../../../domain/controllers/school_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../base_screen.dart';
import 'Widgets/add_new_school.dart';
import 'Widgets/grade_system_widget.dart';
import 'Widgets/school_widget.dart';

class SchoolsScreen extends GetView<SchoolController> {
  const SchoolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HeaderWidget(text: "School Setting"),
                Visibility(
                  visible: Get.find<ProfileController>().canAccessWidget(
                    widgetId: '5100',
                  ),
                  child: ElevatedButton.icon(
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.school),
                    label: const Text("Add New School"),
                    onPressed: () {
                      MyDialogs.showDialog(
                        context,
                        const AddNewSchoolWidget(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: SchoolWidget()),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(child: GradeSystemWidget()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
