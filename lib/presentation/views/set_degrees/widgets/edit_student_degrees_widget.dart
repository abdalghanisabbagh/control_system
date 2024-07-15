import 'package:control_system/domain/controllers/barcode_controllers/barcode_controllers.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_back_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_edit_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/styles_manager.dart';

class EditStudentDegreesWidget extends GetView<BarcodeController> {
  const EditStudentDegreesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.25,
      child: GetBuilder<BarcodeController>(
        builder: (_) {
          return Column(
            children: [
              Text(
                '${controller.barcodeResModel?.student?.firstName} ${controller.barcodeResModel?.student?.secondName} ${controller.barcodeResModel?.student?.thirdName}',
                style: nunitoBold,
              ),
              Expanded(
                child: MytextFormFiled(
                  isNumber: true,
                  maxLength: 3,
                  title: "Student Degree",
                  controller: controller.studentDegreeController
                    ..text = controller.barcodeResModel?.studentDegree ?? "",
                ),
              ),
              controller.isLoading
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
                        GetBuilder<BarcodeController>(
                          builder: (_) {
                            return Expanded(
                              child: ElevatedEditButton(
                                onPressed: () async {
                                  await controller.setStudentDegree().then(
                                    (value) {
                                      if (value) {
                                        Get.back();
                                        MyFlashBar.showSuccess(
                                          "Student Degree Set Successfully",
                                          "Success",
                                        ).show(Get.key.currentContext);
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}
