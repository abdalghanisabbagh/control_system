import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_add_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/resource_manager/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/proctor_controller.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';

class AddNewProctor extends GetView<ProctorController> {
  const AddNewProctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: controller.formKey,
        child: GetBuilder<ProctorController>(
          builder: (proctorcontroller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 450,
                  child: MytextFormFiled(
                    title: "Proctor Full Name",
                    controller: proctorcontroller.fullNameController,
                    myValidation: Validations.requiredValidator,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 450,
                  child: MytextFormFiled(
                    title: "Username",
                    controller: proctorcontroller.usernameController,
                    myValidation: Validations.requiredValidator,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 450,
                  child: MytextFormFiled(
                    title: "Password",
                    controller: proctorcontroller.passwordController,
                    myValidation: Validations.requiredValidator,
                    obscureText: proctorcontroller.showPassord,
                    suffixIcon: IconButton(
                      icon: Icon(
                        proctorcontroller.showPassord
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        proctorcontroller.showPassord =
                            !proctorcontroller.showPassord;
                        proctorcontroller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 450,
                  child: MytextFormFiled(
                    title: "Confirm Password",
                    controller: proctorcontroller.confirmPasswordController,
                    obscureText: proctorcontroller.showPassord,
                    suffixIcon: IconButton(
                      icon: Icon(
                        proctorcontroller.showPassord
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        proctorcontroller.showPassord =
                            !proctorcontroller.showPassord;
                        proctorcontroller.update();
                      },
                    ),
                    myValidation: Validations.validateConfirmPassword,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 450,
                  child: MytextFormFiled(
                    title: "NIS Id",
                    controller: proctorcontroller.nisIdController,
                    myValidation: Validations.requiredValidator,
                  ),
                ),
                const SizedBox(height: 16.0),
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
                          const Expanded(
                            child: ElevatedBackButton(),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: ElevatedAddButton(
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.createNewProctor().then((value) {
                                    if (value) {
                                      Get.back();
                                      MyFlashBar.showSuccess(
                                              'Proctor has been created successfully',
                                              'Success')
                                          .show(Get.key.currentContext!);
                                    }
                                  });
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
