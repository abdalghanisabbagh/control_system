import 'package:control_system/domain/controllers/controllers.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../Data/Models/subject/subject_res_model.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/styles_manager.dart';

// ignore: must_be_immutable
class EditSubjectWidget extends StatelessWidget {
  final SubjectResModel subject;
  List schoolTypes = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditSubjectWidget({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectNameController = TextEditingController()
      ..text = subject.name ?? "";

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Edit Subject",
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
                      optionSelected: subject
                          .schoolTypeHasSubjectsResModel!.schooltypeHasSubjects!
                          .map((type) => ValueItem(
                              label: type.schoolType!.name!,
                              value: type.schoolType!.iD))
                          .toList(),
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
              GetBuilder<SubjectsController>(builder: (controller) {
                return Checkbox(
                  value: subject.inExam == 1 ? true : false,
                  onChanged: (newVal) {
                    subject.inExam = newVal! ? 1 : 0;
                    controller.update();
                  },
                );
              })
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
                          child: ElevatedEditButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (schoolTypes.isEmpty) {
                                  MyFlashBar.showError(
                                          'Please select at least one school type',
                                          'Error')
                                      .show(context);
                                } else {
                                  await controller
                                      .editSubject(
                                          id: subject.iD!,
                                          inExam: subject.inExam!,
                                          name: subjectNameController.text,
                                          schholTypeIds: schoolTypes)
                                      .then(
                                    (value) {
                                      value
                                          ? {
                                              context.pop(),
                                              MyFlashBar.showSuccess(
                                                      'The Subject Has Been Updated Successfully',
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
