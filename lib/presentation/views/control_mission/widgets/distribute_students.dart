import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../Data/Models/student_seat/student_seat_res_model.dart';
import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_back_button.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
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
                    Row(
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
                        const Spacer(),
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
                                                horizontal: 10, vertical: 5),
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
                                              color: ColorManager.gradesColor[
                                                  controller.grades
                                                      .firstWhere((element) =>
                                                          element.iD
                                                              .toString() ==
                                                          controller
                                                              .countByGrade.keys
                                                              .toList()[index])
                                                      .name],
                                            ),
                                            child: Text(
                                              '${controller.grades.firstWhere((element) => element.iD.toString() == controller.countByGrade.keys.toList()[index]).name} (${controller.availableStudents.where((element) => element.gradesID == controller.grades.firstWhere((element) => element.iD.toString() == controller.countByGrade.keys.toList()[index]).iD).length})',
                                              style: nunitoRegular,
                                            ).paddingSymmetric(
                                                horizontal: 10, vertical: 5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ).paddingSymmetric(horizontal: 10),
                              )..insert(
                                  0,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        'Max: ${controller.examRoomResModel.capacity}',
                                        style: nunitoRegular,
                                      ),
                                    ],
                                  ),
                                ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                controller.autoGenerateSimple();
                              },
                              child: const Text(
                                'Auto Generate (Simple)',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Auto Generate (Cross)',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                controller.removeAllFromDesks();
                              },
                              child: const Text(
                                'Remove All',
                              ),
                            ),
                          ],
                        ),
                      ],
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
                                      Text(
                                        'Exam Room Students',
                                        style: nunitoBold.copyWith(
                                          color: ColorManager.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          MyDialogs.showDialog(
                                            context,
                                            RemoveStudentsFromExamRoomWidget(),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.person_remove_alt_1,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          MyDialogs.showDialog(
                                            context,
                                            AddNewStudentsToExamRoomWidget(),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.person_add_alt_1,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.63,
                                  child: SingleChildScrollView(
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
                                                    fontSize: 10,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  'Seat NO: ${controller.availableStudents[i].seatNumber}',
                                                  style: nunitoBold.copyWith(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  'Grade : ${controller.availableStudents[i].student?.gradeResModel?.name}',
                                                  style: nunitoBold.copyWith(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  'Desk NO : ${controller.classDesks.indexWhere((element) => element.id == controller.availableStudents[i].classDeskID) + 1}',
                                                  style: nunitoBold.copyWith(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
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
                                          );
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
                                    child: Column(
                                      children: [
                                        ...List.generate(
                                          controller.numberOrRows,
                                          (i) {
                                            return Row(
                                              children: [
                                                ...List.generate(
                                                  controller
                                                      .classDeskCollection[i]!
                                                      .length,
                                                  (j) {
                                                    return controller
                                                            .blockedClassDesks
                                                            .contains(controller
                                                                .classDesks[
                                                                    i * 6 + j]
                                                                .id)
                                                        ? SizedBox(
                                                            height: Get.height *
                                                                0.2,
                                                            width:
                                                                Get.width * 0.1,
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
                                                                          Border
                                                                              .all(
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
                                                                            classDeskId:
                                                                                controller.classDesks[i * 6 + j].id!);
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        FontAwesomeIcons
                                                                            .arrowRotateLeft,
                                                                        color: ColorManager
                                                                            .red,
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
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            1.5,
                                                                      ),
                                                                      color: ColorManager
                                                                          .red,
                                                                    ),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      '${i * 6 + j + 1}',
                                                                      style: nunitoBold
                                                                          .copyWith(
                                                                        color: ColorManager
                                                                            .white,
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
                                                                    .classDesks[
                                                                        i * 6 +
                                                                            j]
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
                                                                            width:
                                                                                1.5,
                                                                          ),
                                                                          color:
                                                                              ColorManager.yellow,
                                                                        ),
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            Text(
                                                                              '${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDesks[i * 6 + j].id).seatNumber}',
                                                                              style: nunitoRegular,
                                                                            ),
                                                                            IconButton(
                                                                              onPressed: () {
                                                                                controller.removeStudentFromDesk(studentSeatNumberId: controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDesks[i * 6 + j].id).iD!);
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
                                                                            width:
                                                                                1.5,
                                                                          ),
                                                                          color: ColorManager.gradesColor[controller
                                                                              .availableStudents
                                                                              .firstWhere((element) => element.classDeskID == controller.classDesks[i * 6 + j].id)
                                                                              .student!
                                                                              .gradeResModel!
                                                                              .name!],
                                                                        ),
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              'Student Name: ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDesks[i * 6 + j].id).student?.firstName!} ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDesks[i * 6 + j].id).student?.secondName!} ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDesks[i * 6 + j].id).student?.thirdName!} ',
                                                                              style: nunitoBold.copyWith(
                                                                                fontSize: 12,
                                                                              ),
                                                                              maxLines: 3,
                                                                            ),
                                                                            FittedBox(
                                                                              fit: BoxFit.fill,
                                                                              child: Text(
                                                                                'Seat NO: ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDesks[i * 6 + j].id).seatNumber}',
                                                                                style: nunitoBold.copyWith(
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            FittedBox(
                                                                              fit: BoxFit.fill,
                                                                              child: Text(
                                                                                'Grade : ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDesks[i * 6 + j].id).student?.gradeResModel?.name}',
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
                                                                  controller.addStudentToDesk(
                                                                      studentSeatNumberId:
                                                                          details
                                                                              .data
                                                                              .iD!,
                                                                      classDeskIndex:
                                                                          i * 6 +
                                                                              j);
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
                                                                  child: Column(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(
                                                                              width: 1.5,
                                                                            ),
                                                                            color:
                                                                                ColorManager.yellow,
                                                                          ),
                                                                          child:
                                                                              IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              controller.blockClassDesk(classDeskId: controller.classDesks[i * 6 + j].id!);
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              FontAwesomeIcons.ban,
                                                                              color: ColorManager.red,
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
                                                                              width: 1.5,
                                                                            ),
                                                                            color:
                                                                                ColorManager.greyA8,
                                                                          ),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            '${i * 6 + j + 1}',
                                                                            style:
                                                                                nunitoBold.copyWith(
                                                                              color: ColorManager.white,
                                                                              fontSize: 20,
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
                                    ).paddingOnly(top: 20),
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
                                if (controller.availableStudents.any(
                                    (element) => element.classDeskID == null)) {
                                  MyAwesomeDialogue(
                                    title: 'Error',
                                    desc:
                                        'Some students are not distributed. Are you sure you want to finish ?',
                                    dialogType: DialogType.warning,
                                    btnCancelOnPressed: () {},
                                    btnOkOnPressed: () {
                                      controller.finish().then((value) {
                                        if (value) {
                                          MyFlashBar.showSuccess(
                                            'Success',
                                            'Students have been distributed successfully',
                                          ).show(context);
                                        }
                                      });
                                    },
                                  ).showDialogue(context);
                                } else if (controller
                                    .availableStudents.isEmpty) {
                                  MyAwesomeDialogue(
                                    title: 'Error',
                                    desc:
                                        'No students added yet. Are you sure you want to finish ?',
                                    dialogType: DialogType.warning,
                                    btnCancelOnPressed: () {},
                                    btnOkOnPressed: () {
                                      controller.finish().then((value) {
                                        if (value) {
                                          MyFlashBar.showSuccess(
                                            'Success',
                                            'Students have been distributed successfully',
                                          ).show(context);
                                        }
                                      });
                                    },
                                  ).showDialogue(context);
                                } else {
                                  controller.finish().then((value) {
                                    if (value) {
                                      MyFlashBar.showSuccess(
                                        'Success',
                                        'Students have been distributed successfully',
                                      ).show(context);
                                    }
                                  });
                                }
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
