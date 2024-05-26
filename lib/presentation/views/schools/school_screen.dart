import 'package:control_system/domain/controllers/school_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/header_widget.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:control_system/presentation/views/schools/Widgets/add_new_school.dart';
import 'package:control_system/presentation/views/schools/Widgets/school_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widgets/grade_system_widget.dart';

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
                IconButton(
                  tooltip: "Add new School",
                  onPressed: () {
                    MyDialogs.showAddDialog(
                        context, const AddNewSchoolWidget());
                  },
                  icon: const Icon(Icons.school),
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
