import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../domain/controllers/control_mission/distribution_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/index.dart';
import '../../../resource_manager/validations.dart';

// ignore: must_be_immutable
class AddExamRoomWidget extends GetView<DistributionController> {
  AddExamRoomWidget({
    super.key,
  });

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController newRoomName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: GetBuilder<DistributionController>(builder: (_) {
            return controller.isLodingGetStageAndClassRoom
                ? const Center(child: CircularProgressIndicator())
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    FormField<List<ValueItem<dynamic>>>(
                      validator:
                          Validations.multiSelectDropDownRequiredValidator,
                      builder: (formFieldState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 500,
                              child: MultiSelectDropDownView(
                                hintText: "Select Class Room",
                                onOptionSelected: (selectedItem) {
                                  controller.selectedItemClassRoom =
                                      selectedItem.isNotEmpty
                                          ? selectedItem.first
                                          : null;
                                  formFieldState.didChange(selectedItem);
                                },
                                options: controller.optionsClassRoom,
                              ),
                            ),
                            if (formFieldState.hasError)
                              Text(
                                formFieldState.errorText!,
                                style: nunitoRegular.copyWith(
                                  fontSize: FontSize.s10,
                                  color: ColorManager.error,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormField<List<ValueItem<dynamic>>>(
                      validator:
                          Validations.multiSelectDropDownRequiredValidator,
                      builder: (formFieldState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 500,
                              child: MultiSelectDropDownView(
                                hintText: "Select Class Type",
                                onOptionSelected: (selectedItem) {
                                  controller.selectedItemStage =
                                      selectedItem.isNotEmpty
                                          ? selectedItem.first
                                          : null;
                                  formFieldState.didChange(selectedItem);
                                },
                                options: controller.optionsStage,
                              ),
                            ),
                            if (formFieldState.hasError)
                              Text(
                                formFieldState.errorText!,
                                style: nunitoRegular.copyWith(
                                  fontSize: FontSize.s10,
                                  color: ColorManager.error,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    MytextFormFiled(
                        controller: newRoomName,
                        title: "Room Name",
                        myValidation: Validations.requiredValidator),
                    const SizedBox(
                      height: 10,
                    ),
                    controller.isLodingAddExamRoom
                        ? const Center(child: CircularProgressIndicator())
                        : Row(
                            children: [
                              const Expanded(
                                child: ElevatedBackButton(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate() &&
                                        controller.selectedItemClassRoom !=
                                            null &&
                                        controller.selectedItemStage != null) {
                                      controller
                                          .addNewExamRoom(
                                              name: newRoomName.text,
                                              stage: controller
                                                  .selectedItemStage!.label,
                                              capacity: 30,
                                              controlMissionId:
                                                  controller.controlMissionId,
                                              schoolClassId: controller
                                                  .selectedItemClassRoom!.value)
                                          .then(
                                        (value) {
                                          value
                                              ? {
                                                  context.pop(),
                                                  MyFlashBar.showSuccess(
                                                    "The Student has been added successfully",
                                                    "Success",
                                                  ).show(context),
                                                }
                                              : null;
                                        },
                                      );
                                      ;
                                    }
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(11),
                                      ),
                                      color: ColorManager.glodenColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Yes",
                                        style: nunitoRegular.copyWith(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                  ]);
          }),
        ),
      ),
    );
  }
}
