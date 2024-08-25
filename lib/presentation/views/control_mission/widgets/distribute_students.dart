import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../Data/Models/student_seat/student_seat_res_model.dart';
import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_back_button.dart';
import 'add_new_students_to_exam_room_widget.dart';
import 'remove_students_from_exam_room_widget.dart';

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
                            SizedBox(
                              width: Get.width * 0.4,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    controller.countByGrade.keys.length,
                                    (index) => IntrinsicHeight(
                                      child: SizedBox(
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1.5,
                                                  ),
                                                  color: ColorManager.yellow,
                                                ),
                                                child: Text(
                                                  '${controller.grades.firstWhere((element) => element.iD.toString() == controller.countByGrade.keys.toList()[index]).name} (${controller.countByGrade.values.toList()[index]})',
                                                  style: nunitoRegular,
                                                ).paddingSymmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1.5,
                                                  ),
                                                  color: ColorManager
                                                          .gradesColor[
                                                      controller.grades
                                                          .firstWhere((element) =>
                                                              element.iD
                                                                  .toString() ==
                                                              controller
                                                                  .countByGrade
                                                                  .keys
                                                                  .toList()[index])
                                                          .name],
                                                ),
                                                child: Text(
                                                  '${controller.grades.firstWhere((element) => element.iD.toString() == controller.countByGrade.keys.toList()[index]).name} (${controller.availableStudents.where((element) => element.gradesID == controller.grades.firstWhere((element) => element.iD.toString() == controller.countByGrade.keys.toList()[index]).iD).length})',
                                                  style: nunitoRegular,
                                                ).paddingSymmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ).paddingSymmetric(horizontal: 10),
                                  )..insert(
                                      0,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Available: ${controller.availableStudentsCount}',
                                            style: nunitoRegular,
                                          ),
                                          Text(
                                            'Current: ${controller.availableStudents.length}',
                                            style: nunitoRegular,
                                          ),
                                          Text(
                                            'Max: ${controller.examRoomResModel.classRoomResModel?.maxCapacity}',
                                            style: nunitoRegular,
                                          ),
                                        ],
                                      ),
                                    ),
                                ),
                              ),
                            ),
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
                                    onPressed: () {},
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
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: Get.height * 0.7,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 20,
                                        offset: const Offset(
                                          2,
                                          15,
                                        ),
                                      ),
                                    ],
                                    color: ColorManager.primary,
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(
                                            'Exam Room Students',
                                            style: nunitoBold.copyWith(
                                              color: ColorManager.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.fill,
                                        child: IconButton(
                                          onPressed: () {
                                            MyDialogs.showDialog(
                                              context,
                                              RemoveStudentsFromExamRoomWidget(),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.person_remove_alt_1,
                                            color: ColorManager.white,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.fill,
                                        child: IconButton(
                                          onPressed: () {
                                            MyDialogs.showDialog(
                                              context,
                                              AddNewStudentsToExamRoomWidget(),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.person_add_alt_1,
                                            color: ColorManager.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.63,
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: List.generate(
                                        controller.availableStudents.length,
                                        (i) {
                                          Widget child = Container(
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            height: Get.height * 0.13,
                                            width: Get.width * 0.2,
                                            decoration: BoxDecoration(
                                              color: ColorManager.gradesColor[
                                                  controller
                                                      .availableStudents[i]
                                                      .student!
                                                      .gradeResModel!
                                                      .name!],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              border: Border.all(
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Student Name: ${controller.availableStudents[i].student?.firstName!} ${controller.availableStudents[i].student?.secondName!} ${controller.availableStudents[i].student?.thirdName!} ',
                                                  style: nunitoBold.copyWith(
                                                    fontSize: 15,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  'Seat NO: ${controller.availableStudents[i].seatNumber}',
                                                  style: nunitoBold.copyWith(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'Grade : ${controller.availableStudents[i].student?.gradeResModel?.name}',
                                                  style: nunitoBold.copyWith(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'Desk NO : ${controller.classDesks.indexWhere((element) => element.id == controller.availableStudents[i].classDeskID) + 1}',
                                                  style: nunitoBold.copyWith(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      FittedBox(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            controller.removeStudentFromExamRoom(
                                                                studentSeatNumberId:
                                                                    controller
                                                                        .availableStudents[
                                                                            i]
                                                                        .iD!);
                                                          },
                                                          icon: const Icon(
                                                            FontAwesomeIcons
                                                                .trashCan,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                          return Draggable<
                                                      StudentSeatNumberResModel>(
                                                  data: controller
                                                      .availableStudents[i],
                                                  feedback: child,
                                                  child: child)
                                              .paddingAll(
                                                5,
                                              )
                                              .paddingOnly(right: 15);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                SizedBox(
                                  height: Get.height * 0.6,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ...List.generate(
                                            controller.numberOrRows,
                                            (i) {
                                              return Row(
                                                children: [
                                                  ...List.generate(
                                                    controller
                                                        .classDeskCollection
                                                        .entries
                                                        .toList()[i]
                                                        .value
                                                        .length,
                                                    (j) {
                                                      return controller
                                                              .blockedClassDesks
                                                              .contains(controller
                                                                  .classDeskCollection
                                                                  .entries
                                                                  .toList()[i]
                                                                  .value[j]
                                                                  .id)
                                                          ? SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.2,
                                                              width: Get.width *
                                                                  0.1,
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                          width:
                                                                              1.5,
                                                                        ),
                                                                        color: ColorManager
                                                                            .yellow,
                                                                      ),
                                                                      child:
                                                                          IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          controller.unBlockClassDesk(
                                                                              classDeskId: controller.classDeskCollection.entries.toList()[i].value[j].id!);
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          FontAwesomeIcons
                                                                              .arrowRotateLeft,
                                                                          color:
                                                                              ColorManager.red,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 5,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                          width:
                                                                              1.5,
                                                                        ),
                                                                        color: ColorManager
                                                                            .red,
                                                                      ),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        '${i != 0 ? i * controller.classDeskCollection.entries.toList()[i - 1].value.length + j + 1 : i * controller.classDeskCollection.entries.toList()[i].value.length + j + 1}',
                                                                        style: nunitoBold
                                                                            .copyWith(
                                                                          color:
                                                                              ColorManager.white,
                                                                          fontSize:
                                                                              20,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ).paddingSymmetric(
                                                              horizontal: 5)
                                                          : (controller
                                                                  .availableStudents
                                                                  .map((element) =>
                                                                      element
                                                                          .classDeskID)
                                                                  .toList()
                                                                  .contains(controller
                                                                      .classDeskCollection
                                                                      .entries
                                                                      .toList()[
                                                                          i]
                                                                      .value[j]
                                                                      .id!))
                                                              ? SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.2,
                                                                  width:
                                                                      Get.width *
                                                                          0.1,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(
                                                                              width: 1.5,
                                                                            ),
                                                                            color:
                                                                                ColorManager.yellow,
                                                                          ),
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Text(
                                                                                '${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).seatNumber}',
                                                                                style: nunitoRegular,
                                                                              ),
                                                                              IconButton(
                                                                                onPressed: () {
                                                                                  controller.removeStudentFromDesk(studentSeatNumberId: controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).iD!);
                                                                                },
                                                                                icon: const Icon(
                                                                                  FontAwesomeIcons.deleteLeft,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 5,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(
                                                                              width: 1.5,
                                                                            ),
                                                                            color:
                                                                                ColorManager.gradesColor[controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).student!.gradeResModel!.name!],
                                                                          ),
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Student Name: ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).student?.firstName!} ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).student?.secondName!} ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).student?.thirdName!} ',
                                                                                style: nunitoBold.copyWith(
                                                                                  fontSize: 14,
                                                                                ),
                                                                                maxLines: 3,
                                                                              ),
                                                                              FittedBox(
                                                                                fit: BoxFit.fill,
                                                                                child: Text(
                                                                                  'Class: ${controller.availableStudents[i].student?.classRoomResModel?.name}',
                                                                                  style: nunitoBold.copyWith(
                                                                                    fontSize: 15,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              FittedBox(
                                                                                fit: BoxFit.fill,
                                                                                child: Text(
                                                                                  'Grade : ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).student?.gradeResModel?.name}',
                                                                                  style: nunitoBold.copyWith(
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ).paddingSymmetric(
                                                                            horizontal:
                                                                                5,
                                                                            vertical:
                                                                                5,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ).paddingSymmetric(
                                                                  horizontal: 5)
                                                              : DragTarget<
                                                                  StudentSeatNumberResModel>(
                                                                  onAcceptWithDetails:
                                                                      (details) {
                                                                    controller
                                                                        .addStudentToDesk(
                                                                      studentSeatNumberId:
                                                                          details
                                                                              .data
                                                                              .iD!,
                                                                      classDeskId: controller
                                                                          .classDeskCollection
                                                                          .entries
                                                                          .toList()[
                                                                              i]
                                                                          .value[
                                                                              j]
                                                                          .id!,
                                                                    );
                                                                  },
                                                                  builder: (BuildContext context,
                                                                          List<StudentSeatNumberResModel?>
                                                                              data,
                                                                          List<dynamic>
                                                                              rejects) =>
                                                                      SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            0.2,
                                                                    width:
                                                                        Get.width *
                                                                            0.1,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                width: 1.5,
                                                                              ),
                                                                              color: ColorManager.yellow,
                                                                            ),
                                                                            child:
                                                                                IconButton(
                                                                              onPressed: () {
                                                                                controller.blockClassDesk(classDeskId: controller.classDeskCollection.entries.toList()[i].value[j].id!);
                                                                              },
                                                                              icon: const Icon(
                                                                                FontAwesomeIcons.ban,
                                                                                color: ColorManager.red,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              5,
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                width: 1.5,
                                                                              ),
                                                                              color: ColorManager.greyA8,
                                                                            ),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                FittedBox(
                                                                              fit: BoxFit.fill,
                                                                              child: Text(
                                                                                '${i != 0 ? i * controller.classDeskCollection.entries.toList()[i - 1].value.length + j + 1 : i * controller.classDeskCollection.entries.toList()[i].value.length + j + 1}',
                                                                                style: nunitoBold.copyWith(
                                                                                  color: ColorManager.white,
                                                                                  fontSize: 20,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ).paddingSymmetric(
                                                                          horizontal:
                                                                              5),
                                                                );
                                                    },
                                                  ),
                                                ],
                                              ).paddingOnly(bottom: 10);
                                            },
                                          ),
                                        ],
                                      ).paddingOnly(top: 20, right: 20),
                                    ),
                                  ),
                                ).paddingOnly(top: 10),
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
