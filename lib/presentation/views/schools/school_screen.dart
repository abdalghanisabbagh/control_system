import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                IconButton(
                  tooltip: "Add new School",
                  onPressed: () {
                    MyDialogs.showDialog(context, const AddNewSchoolWidget());
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
