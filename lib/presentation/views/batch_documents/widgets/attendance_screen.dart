import 'package:control_system/domain/controllers/SeatingNumbersControllers/CreateCoversSheetsController.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:control_system/presentation/resource_manager/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceScreen extends GetView<CreateCoversSheetsController> {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Attendance",
                  style: nunitoBoldStyle()
                      .copyWith(fontSize: 30, color: ColorManager.bgSideMenu),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 20,
        ),
        // const HeaderCoverWidget(text: "Attendance"),
        const SizedBox(
          height: 20,
        ),
        // Obx(() => controller.creatMissionController.yearList.isEmpty
        //     ? const Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : DropdownSearch<YearsResponse>(
        //         items: controller.creatMissionController.yearList,
        //         itemAsString: (item) => item.year,
        //         selectedItem:
        //             controller.creatMissionController.selectedyear != null
        //                 ? controller.creatMissionController.selectedyear!.value
        //                 : null,
        //         dropdownDecoratorProps: DropDownDecoratorProps(
        //           dropdownSearchDecoration: InputDecoration(
        //               focusedBorder: OutlineInputBorder(
        //                   borderSide:
        //                       BorderSide(color: ColorManager.glodenColor),
        //                   borderRadius: BorderRadius.circular(10)),
        //               border: OutlineInputBorder(
        //                   borderSide:
        //                       BorderSide(color: ColorManager.glodenColor),
        //                   borderRadius: BorderRadius.circular(10)),
        //               hintText: "Select Education Years",
        //               hintStyle: nunitoBoldStyle().copyWith(
        //                   fontSize: 30, color: ColorManager.bgSideMenu)),
        //         ),
        //         onChanged: ((value) {
        //           controller.selectedyear = value;
        //           controller.onChangeYear(value!);
        //         }),
        //       )),
        // const SizedBox(
        //   height: 20,
        // ),
        // Obx(
        //   () => controller.missionsController.missions.isEmpty
        //       ? const SizedBox.shrink()
        //       : DropdownSearch<MissionObjectResponse>(
        //           popupProps: PopupProps.menu(
        //             searchFieldProps: TextFieldProps(
        //                 decoration: InputDecoration(
        //                     hintText: "search",
        //                     hintStyle: nunitoBoldStyle().copyWith(
        //                         fontSize: 30, color: ColorManager.bgSideMenu),
        //                     focusedBorder: OutlineInputBorder(
        //                         borderSide:
        //                             BorderSide(color: ColorManager.black),
        //                         borderRadius: BorderRadius.circular(10)),
        //                     enabledBorder: OutlineInputBorder(
        //                         borderSide:
        //                             BorderSide(color: ColorManager.black),
        //                         borderRadius: BorderRadius.circular(10))),
        //                 cursorColor: ColorManager.glodenColor),
        //             showSearchBox: true,
        //           ),
        //           items: controller.missionsController.missions,
        //           itemAsString: (item) => item.name!,
        //           dropdownDecoratorProps: DropDownDecoratorProps(
        //             dropdownSearchDecoration: InputDecoration(
        //                 focusedBorder: OutlineInputBorder(
        //                     borderSide: BorderSide(color: ColorManager.black),
        //                     borderRadius: BorderRadius.circular(10)),
        //                 border: OutlineInputBorder(
        //                     borderSide: BorderSide(color: ColorManager.black),
        //                     borderRadius: BorderRadius.circular(10)),
        //                 hintText: "Select Mission",
        //                 hintStyle: nunitoBoldStyle().copyWith(
        //                     fontSize: 30, color: ColorManager.bgSideMenu)),
        //           ),
        //           onChanged: ((value) {
        //             // controller.selectedExamRoom = null;
        //             // controller.getExamRooms(value!.id!);
        //             // controller.selectMission = value;
        //             // print(value.name);
        //             CompleteMissionsController completeMissionsController =
        //                 Get.find();
        //             completeMissionsController.getDetialsControlMissionById(
        //                 missionId: value!.id!);
        //           }),
        //           selectedItem: controller.selectedMission == null
        //               ? null
        //               : controller.selectedMission!.value,
        //         ),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        // GetBuilder<CompleteMissionsController>(
        //   builder: (controller) => controller.missionDetials == null
        //       ? const SizedBox.shrink()
        //       : DropdownSearch<Examroom>(
        //           popupProps: PopupProps.menu(
        //             searchFieldProps: TextFieldProps(
        //                 decoration: InputDecoration(
        //                     hintText: "search",
        //                     hintStyle: nunitoBoldStyle().copyWith(
        //                         fontSize: 30, color: ColorManager.bgSideMenu),
        //                     focusedBorder: OutlineInputBorder(
        //                         borderSide:
        //                             BorderSide(color: ColorManager.black),
        //                         borderRadius: BorderRadius.circular(10)),
        //                     enabledBorder: OutlineInputBorder(
        //                         borderSide:
        //                             BorderSide(color: ColorManager.black),
        //                         borderRadius: BorderRadius.circular(10))),
        //                 cursorColor: ColorManager.glodenColor),
        //             showSearchBox: true,
        //           ),
        //           items: controller.missionDetials!.examrooms!,
        //           itemAsString: (item) => item.name!,
        //           dropdownDecoratorProps: DropDownDecoratorProps(
        //             dropdownSearchDecoration: InputDecoration(
        //                 focusedBorder: OutlineInputBorder(
        //                     borderSide: BorderSide(color: ColorManager.black),
        //                     borderRadius: BorderRadius.circular(10)),
        //                 border: OutlineInputBorder(
        //                     borderSide: BorderSide(color: ColorManager.black),
        //                     borderRadius: BorderRadius.circular(10)),
        //                 hintText: "Select Exam Room ",
        //                 hintStyle: AppTextStyle.nunitoRegular
        //                     .copyWith(fontSize: 16, color: ColorManager.black)),
        //           ),
        //           onChanged: ((value) {
        //             controller.selectedExamroom = value;
        //             controller.update();
        //           }),
        //           selectedItem: controller.selectedExamroom,
        //         ),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        // GetBuilder<CompleteMissionsController>(
        //     builder: (completeMissionsController) {
        //   if (completeMissionsController.selectedExamroom != null) {
        //     return InkWell(
        //         onTap: () {
        //           completeMissionsController.generateAttendance();
        //         },
        //         child: Container(
        //           decoration: BoxDecoration(
        //               color: ColorManager.bgSideMenu,
        //               borderRadius: BorderRadius.circular(10)),
        //           padding: const EdgeInsets.all(20),
        //           child: Text("Generate Attendance",
        //               style: nunitoBoldStyle().copyWith(
        //                   fontSize: 30, color: ColorManager.bgSideMenu)),
        //         ));
        //   } else {
        //     return const SizedBox.shrink();
        //   }
        // })
      ],
    );
  }
}
