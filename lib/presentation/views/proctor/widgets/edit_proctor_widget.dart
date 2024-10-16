import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Data/Models/proctor/proctor_res_model.dart';
import '../../../../domain/controllers/proctor_controller.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/validations.dart';

class EditProctorWidget extends GetView<ProctorController> {
  final ProctorResModel proctor;

  const EditProctorWidget({super.key, required this.proctor});

  @override
  Widget build(BuildContext context) {
    controller.fullNameController.text = proctor.fullName ?? '';
    controller.usernameController.text = proctor.userName ?? '';
    controller.passwordController.text = proctor.password ?? '';
    controller.confirmPasswordController.text = proctor.password ?? '';
    // controller.nisIdController.text = proctor.nisId ?? '';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: controller.formKey,
        child: GetBuilder<ProctorController>(
          id: 'updateProctor',
          builder: (proctorController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 450,
                  child: MyTextFormFiled(
                    title: "Proctor Full Name",
                    controller: proctorController.fullNameController,
                    myValidation: Validations.validateName,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 450,
                  child: MyTextFormFiled(
                    title: "Username",
                    controller: proctorController.usernameController,
                    myValidation: Validations.validateUsername,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 450,
                  child: MyTextFormFiled(
                    title: "Password",
                    controller: proctorController.passwordController,
                    myValidation: Validations.requiredValidator,
                    obscureText: proctorController.showPassword,
                    suffixIcon: IconButton(
                      tooltip: "Show Password",
                      icon: Icon(
                        proctorController.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        proctorController.showPassword =
                            !proctorController.showPassword;
                        proctorController.update(
                          [
                            'updateProctor',
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 450,
                  child: MyTextFormFiled(
                    title: "Confirm Password",
                    controller: proctorController.confirmPasswordController,
                    obscureText: proctorController.showConfirmPassword,
                    suffixIcon: IconButton(
                      tooltip: "Show Password",
                      icon: Icon(
                        proctorController.showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        proctorController.showConfirmPassword =
                            !proctorController.showConfirmPassword;
                        proctorController.update(
                          [
                            'updateProctor',
                          ],
                        );
                      },
                    ),
                    myValidation: (value) {
                      return Validations.validateConfirmPassword(
                          value, proctorController.passwordController.text);
                    },
                  ),
                ),
                // const SizedBox(height: 16.0),
                // SizedBox(
                //   width: 450,
                //   child: MytextFormFiled(
                //     title: "NIS Id",
                //     controller: proctorcontroller.nisIdController,
                //     // myValidation: Validations.requiredValidator,
                //   ),
                // ),
                // const SizedBox(height: 16.0),
                /*    SizedBox(
                  width: 450,
                  child: TextFormField(
                    controller: proctorcontroller.nationController,
                    decoration: InputDecoration(
                      labelText: 'National Id',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a National Id';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
            
                GetBuilder<Proctor_controller>(builder: (context) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text('Floor Manager :'),
                          Switch(
                              value: proctorcontroller.isFloorManager,
                              activeColor: ColorManager.glodenColor,
                              onChanged: (newValue) {
                                proctorcontroller.isFloorManager = newValue;
                                proctorcontroller.update();
                              }),
                        ],
                      ),
                      if (proctorcontroller.isFloorManager)
                        SizedBox(
                          width: 450,
                          child: DropdownSearch<String>(
                            items: proctorcontroller.mission.roomType,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: ColorManager.glodenColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: ColorManager.glodenColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Select Stage",
                                  hintStyle: AppTextStyle.nunitoRegular.copyWith(
                                      fontSize: 16, color: ColorManager.black)),
                            ),
                            onChanged: (value) {
                              proctorcontroller.roomTypePrincepl = value;
                            },
                          ),
                        ),
                    ],
                  );
                }),
                */
                const SizedBox(height: 16.0),
                controller.isLoading
                    ? Center(
                        child: LoadingIndicators.getLoadingIndicator(),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: ElevatedBackButton(
                              onPressed: () {
                                controller.fullNameController.clear();
                                controller.usernameController.clear();
                                controller.passwordController.clear();
                                controller.confirmPasswordController.clear();
                                controller.nisIdController.clear();
                              },
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: ElevatedEditButton(
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.editProctor(proctor.iD!).then(
                                    (value) {
                                      if (value) {
                                        Get.back();
                                        MyFlashBar.showSuccess(
                                                'Proctor has been updated successfully',
                                                'Success')
                                            .show(Get.key.currentContext!);
                                      }
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
