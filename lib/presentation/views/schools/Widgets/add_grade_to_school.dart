import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/school_controller.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/styles_manager.dart';

class AddNewGradeToSchool extends GetView<SchoolController> {
  const AddNewGradeToSchool({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController gradeNameController = TextEditingController();
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
          height: 40,
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
          controller: gradeNameController,
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<SchoolController>(builder: (_) {
          return controller.isLoadingAddGrades
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Row(
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
                          await controller
                              .addNewGrade(name: gradeNameController.text)
                              .then((value) {
                            value
                                ? {
                                    context.pop(),
                                    MyFlashBar.showSuccess(
                                            'The Grade Has Been Added Successfully',
                                            'Success')
                                        .show(context)
                                  }
                                : null;
                          });
                        },
                      ),
                    ),
                  ],
                );
        })
      ],
    );
  }
}
