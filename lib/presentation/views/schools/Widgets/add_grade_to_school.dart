import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/styles_manager.dart';

class AddNewGradeToSchool extends StatelessWidget {
  const AddNewGradeToSchool({
    super.key,
    required this.onPressed,
  });

  final Future<dynamic> Function({required String name}) onPressed;

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectNameController = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Add New Grade",
          style: nunitoRegular.copyWith(
            color: ColorManager.bgSideMenu,
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          cursorColor: ColorManager.bgSideMenu,
          style: nunitoRegular.copyWith(
              fontSize: 14, color: ColorManager.bgSideMenu),
          decoration: InputDecoration(
            hintText: "Grade name",
            hintStyle: nunitoRegular.copyWith(
                fontSize: 14, color: ColorManager.bgSideMenu),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          controller: subjectNameController,
        ),
        const SizedBox(
          height: 20,
        ),
        // Row(
        //   children: [
        //     Text(
        //       "InExam  ",
        //       style: nunitoRegular.copyWith(
        //           fontSize: 14, color: ColorManager.bgSideMenu),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        Row(
          children: [
            const Expanded(
              child: ElevatedBackButton(),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedAddButton(
                onPressed: () async {
                  await onPressed(name: subjectNameController.text);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
