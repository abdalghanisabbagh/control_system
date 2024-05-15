import 'package:control_system/presentation/views/base_screen.dart';
import 'package:control_system/presentation/views/schools/Widgets/add_new_school_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolsScreen extends StatelessWidget {
  const SchoolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Add New School Type',
                  content: const AddNewSchoolTypeWidget(),
                );
              },
              child: const Text('add New school Type')),
          ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Add New School',
                  content: const AddNewSchoolTypeWidget(),
                );
              },
              child: const Text('add New school')),
        ],
      ),
    );
  }
}
