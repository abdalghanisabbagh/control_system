import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/header_widget.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:control_system/presentation/views/schools/Widgets/add_new_school.dart';
import 'package:control_system/presentation/views/schools/Widgets/add_new_school_type.dart';
import 'package:control_system/presentation/views/schools/Widgets/education_system_widget.dart';
import 'package:control_system/presentation/views/schools/Widgets/school_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widgets/grade_system_widget.dart';

class SchoolsScreen extends StatelessWidget {
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
              children: [
                const Expanded(
                  child: HeaderWidget(text: "School Setting"),
                ),
                IconButton(
                  tooltip: "Add new School",
                  onPressed: () {
                    MyDialogs.showAddDialog(context, AddNewSchoolWidget());
                  },
                  icon: const Icon(Icons.school),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SchoolWidget(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: EducationSystemWidget(
                    selectedscool: false,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Expanded(
                  child: GradeSystemWidget(
                    selectedscool: false,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Add New School Type',
                    content: AddNewSchoolTypeWidget(),
                  );
                },
                child: const Text('add New school Type')),
            ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Add New School',
                    content: AddNewSchoolWidget(),
                  );
                },
                child: const Text('add New school')),
          ],
        ),
      ),
    );
  }
}
