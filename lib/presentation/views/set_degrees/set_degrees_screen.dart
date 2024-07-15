import 'package:control_system/presentation/resource_manager/ReusableWidget/loading_indicators.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/barcode_controllers/barcode_controller.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../resource_manager/index.dart';
import '../base_screen.dart';

class SetDegreesScreen extends GetView<BarcodeController> {
  const SetDegreesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.brCodeFoucs.requestFocus();
    return BaseScreen(
      body: GetBuilder<BarcodeController>(
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(20),
            color: ColorManager.bgColor,
            child: Column(
              children: [
                const HeaderWidget(text: "Student Grades"),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: MytextFormFiled(
                    title: 'Student Barcode',
                    controller: controller.barcodeController,
                    onFieldSubmitted: (_) {
                      controller.getDataFromBarcode();
                    },
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
                      : controller.barcodeResModel?.iD != null
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 50,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 220,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 20,
                                              offset: const Offset(
                                                2,
                                                15,
                                              ), // changes position of shadow
                                            ),
                                          ],
                                          color: ColorManager.ligthBlue,
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Student Name : ${controller.barcodeResModel?.student?.firstName}+ ${controller.barcodeResModel?.student?.secondName} ${controller.barcodeResModel?.student?.thirdName}',
                                                style: nunitoBold.copyWith(
                                                  color:
                                                      ColorManager.bgSideMenu,
                                                  fontSize: 35,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Class : ${controller.barcodeResModel?.student?.classRoomResModel?.name}",
                                                    style:
                                                        nunitoRegular.copyWith(
                                                      color: ColorManager
                                                          .bgSideMenu,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    "Grade : ${controller.barcodeResModel?.student?.gradeResModel?.name}",
                                                    style:
                                                        nunitoRegular.copyWith(
                                                      color: ColorManager
                                                          .bgSideMenu,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  Visibility(
                                                    visible: true,
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorManager
                                                              .glodenColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                              10,
                                                            ),
                                                            child: Text(
                                                              "Edit Student Degrees",
                                                              style: nunitoBold
                                                                  .copyWith(
                                                                color:
                                                                    ColorManager
                                                                        .white,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 100,
                                        right: 0,
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                AssetsManager
                                                    .assetsIconsStudentDegrees,
                                              ),
                                            ),
                                            color: ColorManager.ligthBlue
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(11),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
