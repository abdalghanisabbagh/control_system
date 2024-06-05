import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/index.dart';
import '../../../resource_manager/validations.dart';

// ignore: must_be_immutable
class AddNewUserWidget extends StatelessWidget {
  AddNewUserWidget({
    super.key,
  });

  final TextEditingController confirmPasswordId = TextEditingController();
  final TextEditingController egyptionId = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController nisId = TextEditingController();
  final TextEditingController passwordId = TextEditingController();
  String? roleType;
  List<String> roleTypes = [
    'Control admin',
    'School Director',
    'Academic Dean',
    'Principal',
    'QR Reader',
    "Vice Principal"
  ];

  List<String> schoolDivision = [
    "Elementary",
    "Middle",
    "High",
    "Key Stage 1",
    "Key Stage 2",
    "Key Stage 3",
    "IGCSE",
  ];

  String? selectedDivision;
  final TextEditingController userNameId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          height: Get.height * 0.70,
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    "Add new user",
                    style: nunitoRegular.copyWith(
                      color: ColorManager.bgSideMenu,
                      fontSize: 25,
                    ),
                  ),
                  FormField<List<ValueItem<dynamic>>>(
                    validator: Validations.multiSelectDropDownRequiredValidator,
                    builder: (formFieldState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MultiSelectDropDownView(
                            options: roleTypes
                                .map((e) => ValueItem(label: e, value: e))
                                .toList(),
                            onOptionSelected: (value) {
                              formFieldState.didChange(value);
                            },
                          ),
                          const SizedBox(height: 10),
                          if (formFieldState.hasError)
                            Text(
                              formFieldState.errorText!,
                              style: nunitoRegular.copyWith(
                                fontSize: FontSize.s10,
                                color: ColorManager.error,
                              ),
                            ).paddingOnly(left: 10),
                        ],
                      );
                    },
                  ),
                  if (roleType == roleTypes[3] || roleType == roleTypes[5])
                    FormField(
                      validator:
                          Validations.multiSelectDropDownRequiredValidator,
                      builder: (formFieldState) {
                        return Column(
                          children: [
                            MultiSelectDropDownView(
                              options: schoolDivision
                                  .map((e) => ValueItem(label: e, value: e))
                                  .toList(),
                              onOptionSelected: (value) {
                                formFieldState.didChange(value);
                              },
                            ),
                            const SizedBox(height: 10),
                            if (formFieldState.hasError)
                              Text(
                                formFieldState.errorText!,
                                style: nunitoRegular.copyWith(
                                  fontSize: FontSize.s10,
                                  color: ColorManager.error,
                                ),
                              ).paddingOnly(left: 10),
                          ],
                        );
                      },
                    ),
                  MytextFormFiled(
                    controller: nisId,
                    title: 'NIS ID',
                    myValidation: Validations.requiredValidator,
                  ),
                  // MytextFormFiled(
                  //   controller: egyptionId,
                  //   title: 'Egyptian ID',
                  //   myValidation: Validations.requiredValidator,
                  // ),
                  MytextFormFiled(
                    controller: egyptionId,
                    title: 'Egyptian ID',
                    myValidation: Validations.requiredValidator,
                  ),
                  MytextFormFiled(
                    controller: fullName,
                    title: 'Full Name',
                    myValidation: Validations.requiredValidator,
                  ),
                  MytextFormFiled(
                    controller: userNameId,
                    title: 'User name',
                    myValidation: Validations.requiredValidator,
                  ),
                  MytextFormFiled(
                    controller: passwordId,
                    title: 'Password',
                    myValidation: Validations.requiredValidator,
                  ),
                  MytextFormFiled(
                    controller: confirmPasswordId,
                    title: 'Confirm Password',
                    myValidation: Validations.requiredValidator,
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: ElevatedBackButton(),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  if (formkey.currentState!.validate() || roleType != null) {
                    ///TODO :: Create Method
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorManager.glodenColor,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Center(
                    child: Text(
                      "Add",
                      style: nunitoRegularStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
