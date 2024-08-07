import 'package:control_system/domain/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/styles_manager.dart';

// ignore: must_be_immutable
class AddSubjectWidget extends StatelessWidget {
  AddSubjectWidget({
    super.key,
  });
  final SubjectsController subjectsController = Get.find();
  List schoolTypes = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectNameController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            cursorColor: ColorManager.bgSideMenu,
            style: nunitoRegular.copyWith(
                fontSize: 14, color: ColorManager.bgSideMenu),
            decoration: InputDecoration(
              hintText: "Subject name",
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Subject name is required';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<SchoolController>(builder: (controller) {
            return controller.isLoadingAddGrades
                ? Center(
                    child: LoadingIndicators.getLoadingIndicator(),
                  )
                : SizedBox(
                    width: 400,
                    child: MultiSelectDropDownView(
                      multiSelect: true,
                      showChipSelect: true,
                      onOptionSelected: (selected) {
                        schoolTypes =
                            selected.map((type) => type.value).toList();
                      },
                      options: controller.options,
                    ),
                  );
          }),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "InExam  ",
                style: nunitoRegular.copyWith(
                    fontSize: 14, color: ColorManager.bgSideMenu),
              ),
              Obx(
                () => Checkbox(
                  value: subjectsController.inExam.value,
                  onChanged: (newVal) {
                    subjectsController.inExam.value = newVal!;
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<SubjectsController>(
            builder: (controller) {
              return controller.addLoading
                  ? Center(
                      child: LoadingIndicators.getLoadingIndicator(),
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
                              if (_formKey.currentState!.validate()) {
                                if (schoolTypes.isEmpty) {
                                  MyFlashBar.showError(
                                          'Please select at least one school type',
                                          'Error')
                                      .show(context);
                                } else {
                                  await controller
                                      .addNewSubject(
                                          name: subjectNameController.text,
                                          inExam:
                                              subjectsController.inExam.value,
                                          schholTypeIds: schoolTypes)
                                      .then(
                                    (value) {
                                      value
                                          ? {
                                              context.pop(),
                                              MyFlashBar.showSuccess(
                                                      'The Subject Has Been Added Successfully',
                                                      'Success')
                                                  .show(context)
                                            }
                                          : MyFlashBar.showError(
                                                  'Something went wrong',
                                                  'Error')
                                              .show(context);
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    );
            },
          )
        ],
      ),
    );
  }
}
