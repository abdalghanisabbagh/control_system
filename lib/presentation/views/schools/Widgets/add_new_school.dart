import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:control_system/presentation/resource_manager/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewSchoolWidget extends StatelessWidget {
  AddNewSchoolWidget({super.key});
  final TextEditingController schoolNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: IconButton(
            alignment: AlignmentDirectional.topEnd,
            color: Colors.black,
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        Text(
          "Add New Shool",
          style: nunitoBlack.copyWith(
            color: ColorManager.bgSideMenu,
            fontSize: 30,
          ),
        ),
        MytextFormFiled(
          controller: schoolNameController,
          title: "School Name",
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () {}, child: const Text("Add New School"))
      ],
    );
  }
}
