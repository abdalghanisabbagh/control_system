import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_add_button.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/controllers/barcode_controllers/barcode_controller.dart';
import '../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../resource_manager/index.dart';
import '../base_screen.dart';

class SetDegreesScreen extends GetView<BarcodeController> {
  SetDegreesScreen({super.key});

  var foucsnode = FocusNode();
  @override
  Widget build(BuildContext context) {
    // controller.brCodeFoucs.requestFocus();
    return BaseScreen(
      body: GetBuilder<BarcodeController>(
        builder: (_) {
          return Column(
            children: [
              const HeaderWidget(text: "Student Degrees"),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 1,
                child: MytextFormFiled(
                  title: 'Student Barcode',
                  controller: controller.barcodeController,
                  focusNode: FocusNode()..requestFocus(),
                  onFieldSubmitted: (_) {
                    controller.getDataFromBarcode();
                  },
                  isNumber: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 8,
                child: controller.isLoading
                    ? Center(
                        child: LoadingIndicators.getLoadingIndicator(),
                      )
                    : controller.barcodeResModel != null
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Name : ${controller.barcodeResModel?.student?.firstName}+ ${controller.barcodeResModel?.student?.secondName} ${controller.barcodeResModel?.student?.thirdName}',
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.bgSideMenu,
                                        fontSize: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Class : ${controller.barcodeResModel?.student?.classRoomResModel?.name}",
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.bgSideMenu,
                                        fontSize: 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Subject : ${controller.barcodeResModel?.examMission?.subjectResModel?.name}",
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.bgSideMenu,
                                        fontSize: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Grade : ${controller.barcodeResModel?.student?.gradeResModel?.name}",
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.bgSideMenu,
                                        fontSize: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    controller.barcodeResModel?.studentDegree !=
                                                null &&
                                            controller.barcodeResModel!
                                                .studentDegree!.isNotEmpty
                                        ? Row(
                                            children: [
                                              Text(
                                                'Degree : ',
                                                style: nunitoBold.copyWith(
                                                  color:
                                                      ColorManager.bgSideMenu,
                                                  fontSize: 35,
                                                ),
                                              ),
                                              Text(
                                                "${controller.barcodeResModel?.studentDegree}",
                                                style: nunitoRegular.copyWith(
                                                  color: int.parse(controller
                                                              .barcodeResModel!
                                                              .studentDegree!) <
                                                          60
                                                      ? ColorManager.red
                                                      : ColorManager.green,
                                                  fontSize: 35,
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Enter The Degree:",
                                    style: nunitoBold.copyWith(
                                        color: ColorManager.bgSideMenu),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  controller.barcodeResModel?.studentDegree !=
                                              null &&
                                          !controller.isEdit
                                      ? Text(
                                          controller.barcodeResModel
                                                  ?.studentDegree ??
                                              '0',
                                          style: nunitoRegular.copyWith(
                                              fontSize: 24,
                                              color: int.parse(controller
                                                              .barcodeResModel
                                                              ?.studentDegree ??
                                                          '0') >
                                                      59
                                                  ? ColorManager.green
                                                  : ColorManager.red),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          width: Get.width * 0.05,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ColorManager.bgSideMenu,
                                            ),
                                          ),
                                          child: TextField(
                                            onSubmitted: (value) {
                                              if (value.isEmpty ||
                                                  value.length > 3) {
                                                controller
                                                    .studentDegreeController
                                                    .clear();
                                                foucsnode.requestFocus();
                                                MyFlashBar.showInfo('Degree',
                                                        'Please enter Valid degree')
                                                    .show(context);
                                              }
                                              if (int.parse(value) > 100) {
                                                controller
                                                    .studentDegreeController
                                                    .clear();
                                                foucsnode.requestFocus();
                                                MyFlashBar.showInfo('Degree',
                                                        'Please enter Valid degree')
                                                    .show(context);
                                              } else {
                                                controller
                                                    .setStudentDegree()
                                                    .then((value) {
                                                  if (value) {
                                                    MyFlashBar.showSuccess(
                                                            'Degree set successfully',
                                                            'Success')
                                                        .show(context);
                                                  }
                                                });
                                              }
                                            },
                                            style: nunitoRegular.copyWith(
                                              color: controller.barcodeResModel
                                                              ?.studentDegree !=
                                                          null &&
                                                      controller.barcodeResModel
                                                              ?.studentDegree! !=
                                                          ''
                                                  ? int.parse(controller
                                                              .barcodeResModel!
                                                              .studentDegree!) >=
                                                          60
                                                      ? ColorManager.green
                                                      : ColorManager.red
                                                  : ColorManager.bgSideMenu,
                                            ),
                                            decoration: const InputDecoration(
                                              counter: SizedBox.shrink(),
                                              border: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                            // maxLength: 3,
                                            maxLines: 1,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            focusNode: foucsnode
                                              ..requestFocus(),
                                            controller: controller
                                                .studentDegreeController
                                              ..text = controller
                                                              .barcodeResModel
                                                              ?.studentDegree !=
                                                          null &&
                                                      controller
                                                          .barcodeResModel!
                                                          .studentDegree!
                                                          .isNotEmpty
                                                  ? controller.barcodeResModel!
                                                      .studentDegree!
                                                  : '',
                                          ),
                                        ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '/ 100',
                                    style: nunitoRegular.copyWith(fontSize: 24),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              controller.isLoading
                                  ? LoadingIndicators.getLoadingIndicator()
                                  : Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 100,
                                        maxHeight: 70,
                                      ),
                                      child: controller.isEdit &&
                                              controller.barcodeResModel
                                                      ?.studentDegree !=
                                                  null
                                          ? ElevatedAddButton(
                                              onPressed: () {
                                                String? value = controller
                                                    .studentDegreeController
                                                    .text;
                                                if (value.isEmpty ||
                                                    value.length > 3) {
                                                  controller
                                                      .studentDegreeController
                                                      .clear();
                                                  foucsnode.requestFocus();
                                                  MyFlashBar.showInfo('Degree',
                                                          'Please enter Valid degree')
                                                      .show(context);
                                                }
                                                if (int.parse(value) > 100) {
                                                  controller
                                                      .studentDegreeController
                                                      .clear();
                                                  foucsnode.requestFocus();
                                                  MyFlashBar.showInfo('Degree',
                                                          'Please enter Valid degree')
                                                      .show(context);
                                                } else {
                                                  controller
                                                      .setStudentDegree()
                                                      .then((value) {
                                                    if (value) {
                                                      MyFlashBar.showSuccess(
                                                              'Degree set successfully',
                                                              'Success')
                                                          .show(context);
                                                    }
                                                  });
                                                }
                                              },
                                            )
                                          : ElevatedEditButton(
                                              onPressed: () {
                                                controller.isEdit =
                                                    !controller.isEdit;
                                                controller.update();
                                              },
                                            ),
                                    ),
                            ],
                          )
                        : Lottie.asset(AssetsManager.barcodeScanner),
              ),
            ],
          ).paddingSymmetric(horizontal: 20);
        },
      ),
    );
  }
}
