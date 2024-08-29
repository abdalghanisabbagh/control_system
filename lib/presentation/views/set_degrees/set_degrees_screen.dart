import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/controllers/barcode_controllers/barcode_controller.dart';
import '../../../domain/controllers/profile_controller.dart';
import '../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../base_screen.dart';

// ignore: must_be_immutable
class SetDegreesScreen extends GetView<BarcodeController> {
  var foucsnode = FocusNode();

  SetDegreesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Name : ${controller.barcodeResModel?.student?.firstName} ${controller.barcodeResModel?.student?.secondName} ${controller.barcodeResModel?.student?.thirdName}',
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.bgSideMenu,
                                        fontSize: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "Grade : ${controller.barcodeResModel?.student?.gradeResModel?.name}",
                                        style: nunitoBold.copyWith(
                                          color: ColorManager.bgSideMenu,
                                          fontSize: 35,
                                        ),
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
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Class : ${controller.barcodeResModel?.student?.classRoomResModel?.name}",
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.bgSideMenu,
                                        fontSize: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Subject : ${controller.barcodeResModel?.examMission?.subjectResModel?.name} (${controller.barcodeResModel?.studentsWithDegrees}/${controller.barcodeResModel?.totalStudents})",
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.bgSideMenu,
                                        fontSize: 35,
                                      ),
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
                                          Get.find<ProfileController>()
                                              .canAccessWidget(widgetId: '4020')
                                      ? Container(
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
                                              } else if (int.parse(value) >
                                                  100) {
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
                                                    .then(
                                                  (value) {
                                                    if (value) {
                                                      MyFlashBar.showSuccess(
                                                              'Degree set successfully',
                                                              'Success')
                                                          .show(context.mounted
                                                              ? context
                                                              : Get.key
                                                                  .currentContext!);
                                                    }
                                                  },
                                                );
                                              }
                                            },
                                            style: nunitoRegular.copyWith(
                                              color: int.parse(controller
                                                          .barcodeResModel!
                                                          .studentDegree!) >=
                                                      60
                                                  ? ColorManager.green
                                                  : ColorManager.red,
                                            ),
                                            decoration: const InputDecoration(
                                              counter: SizedBox.shrink(),
                                              border: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
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
                                                  .barcodeResModel!
                                                  .studentDegree!,
                                          ),
                                        )
                                      : controller.barcodeResModel
                                                  ?.studentDegree !=
                                              null
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
                                          : Get.find<ProfileController>()
                                                  .canAccessWidget(
                                                      widgetId: '4010')
                                              ? Container(
                                                  alignment: Alignment.center,
                                                  width: Get.width * 0.05,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: ColorManager
                                                          .bgSideMenu,
                                                    ),
                                                  ),
                                                  child: TextField(
                                                    onSubmitted: (value) {
                                                      if (value.isEmpty ||
                                                          value.length > 3) {
                                                        controller
                                                            .studentDegreeController
                                                            .clear();
                                                        foucsnode
                                                            .requestFocus();
                                                        MyFlashBar.showInfo(
                                                                'Degree',
                                                                'Please enter Valid degree')
                                                            .show(context);
                                                      } else if (int.parse(
                                                              value) >
                                                          100) {
                                                        controller
                                                            .studentDegreeController
                                                            .clear();
                                                        foucsnode
                                                            .requestFocus();
                                                        MyFlashBar.showInfo(
                                                                'Degree',
                                                                'Please enter Valid degree')
                                                            .show(context);
                                                      } else {
                                                        controller
                                                            .setStudentDegree()
                                                            .then(
                                                          (value) {
                                                            if (value) {
                                                              MyFlashBar.showSuccess(
                                                                      'Degree set successfully',
                                                                      'Success')
                                                                  .show(context
                                                                          .mounted
                                                                      ? context
                                                                      : Get.key
                                                                          .currentContext!);
                                                            }
                                                          },
                                                        );
                                                      }
                                                    },
                                                    style:
                                                        nunitoRegular.copyWith(
                                                      color: ColorManager
                                                          .bgSideMenu,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      counter:
                                                          SizedBox.shrink(),
                                                      border: InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                    ),
                                                    maxLines: 1,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    focusNode: foucsnode
                                                      ..requestFocus(),
                                                    controller: controller
                                                        .studentDegreeController,
                                                  ),
                                                )
                                              : Text(
                                                  controller.barcodeResModel
                                                          ?.studentDegree ??
                                                      'N/A',
                                                  style: nunitoRegular.copyWith(
                                                    fontSize: 24,
                                                    color:
                                                        ColorManager.bgSideMenu,
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
                                      child: controller.barcodeResModel
                                                      ?.studentDegree !=
                                                  null &&
                                              Get.find<ProfileController>()
                                                  .canAccessWidget(
                                                      widgetId: '4020')
                                          ? ElevatedEditButton(
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
                                                } else if (int.parse(value) >
                                                    100) {
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
                                                      .then(
                                                    (value) {
                                                      if (value) {
                                                        MyFlashBar.showSuccess(
                                                                'Degree set successfully',
                                                                'Success')
                                                            .show(
                                                          context.mounted
                                                              ? context
                                                              : Get.key
                                                                  .currentContext!,
                                                        );
                                                      }
                                                    },
                                                  );
                                                }
                                              },
                                            )
                                          : Visibility(
                                              visible:
                                                  Get.find<ProfileController>()
                                                          .canAccessWidget(
                                                              widgetId:
                                                                  '4010') &&
                                                      controller.barcodeResModel
                                                              ?.studentDegree ==
                                                          null,
                                              child: ElevatedAddButton(
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
                                                    MyFlashBar.showInfo(
                                                            'Degree',
                                                            'Please enter Valid degree')
                                                        .show(context);
                                                  } else if (int.parse(value) >
                                                      100) {
                                                    controller
                                                        .studentDegreeController
                                                        .clear();
                                                    foucsnode.requestFocus();
                                                    MyFlashBar.showInfo(
                                                            'Degree',
                                                            'Please enter Valid degree')
                                                        .show(context);
                                                  } else {
                                                    controller
                                                        .setStudentDegree()
                                                        .then(
                                                      (value) {
                                                        if (value) {
                                                          MyFlashBar.showSuccess(
                                                                  'Degree set successfully',
                                                                  'Success')
                                                              .show(context
                                                                      .mounted
                                                                  ? context
                                                                  : Get.key
                                                                      .currentContext!);
                                                        }
                                                      },
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                    )
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
