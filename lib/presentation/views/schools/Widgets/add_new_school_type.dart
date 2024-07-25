import 'package:flutter/material.dart';

import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';

class AddNewSchoolTypeWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  AddNewSchoolTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MytextFormFiled(controller: nameController),
        ElevatedButton(onPressed: () {}, child: const Text("Add New Type"))
      ],
    );
  }
}
