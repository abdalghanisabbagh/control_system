import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_back_button.dart';
import 'distribute_students_side_menue.dart';
import 'header_widget.dart';
import 'render_students_in_eaxm_room.dart';

class DistributeStudents extends GetView<DistributeStudentsController> {
  const DistributeStudents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DistributeStudentsController>(
        builder: (_) {
          return controller.isLoading
              ? Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const MyBackButton(),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Exam Room: ${controller.examRoomResModel.name}',
                              style: nunitoBold.copyWith(
                                fontSize: AppSize.s25,
                                color: ColorManager.black,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.1,
                            ),
                            const HeaderWidget(),
                            SizedBox(
                              width: Get.width * 0.2,
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                FittedBox(
                                  child: TextButton(
                                    onPressed: () {
                                      controller.autoGenerateSimple();
                                    },
                                    child: const Text(
                                      'Auto Generate (Simple)',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FittedBox(
                                  child: TextButton(
                                    onPressed: () {
                                      controller.autoGenerateCross();
                                    },
                                    child: const Text(
                                      'Auto Generate (Cross)',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FittedBox(
                                  child: TextButton(
                                    onPressed: () {
                                      controller.autoGenerate();
                                    },
                                    child: const Text(
                                      'Auto Generate',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FittedBox(
                                  child: TextButton(
                                    onPressed: () {
                                      controller.removeAllFromDesks();
                                    },
                                    child: const Text(
                                      'Remove All',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: DistributeStudentsSideMenue(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: Get.height * 0.7,
                            child: Column(
                              children: [
                                Container(
                                  height: Get.height * 0.08,
                                  width: Get.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Smart Board',
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                const RenderStudentsInEaxmRoom()
                                    .paddingOnly(top: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(
                      horizontal: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                controller.exportToPdf();
                              },
                              icon:
                                  const Icon(Icons.print, color: Colors.white),
                              label: const Text('Print'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.glodenColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                fixedSize: Size(Get.width * 0.3, 50),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Get.key.currentState?.pop();
                              },
                              icon: const Icon(Icons.done, color: Colors.white),
                              label: const Text('Finish'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.bgSideMenu,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                fixedSize: Size(Get.width * 0.3, 50),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
