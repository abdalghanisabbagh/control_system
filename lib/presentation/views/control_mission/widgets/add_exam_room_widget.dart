import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource_manager/index.dart';

// ignore: must_be_immutable
class AddExamRoomWidget extends StatelessWidget {
  AddExamRoomWidget({
    super.key,
  });

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController newname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Obx(
        //   () => controller.allrooms.isEmpty
        //       ? const Center(
        //           child: CircularProgressIndicator(),
        //         )
        //       : Column(
        //           children: [
        //             DropdownSearch<ClassResponse>(
        //               items: controller.allrooms,
        //               selectedItem: controller.selectedRoom?.value,
        //               itemAsString: (item) =>
        //                   "${item.className} - ${item.floorName} - ${item.buildName}",
        //               dropdownDecoratorProps: DropDownDecoratorProps(
        //                 dropdownSearchDecoration: InputDecoration(
        //                     focusedBorder: OutlineInputBorder(
        //                         borderSide:
        //                             BorderSide(color: ColorManager.glodenColor),
        //                         borderRadius: BorderRadius.circular(10)),
        //                     border: OutlineInputBorder(
        //                         borderSide:
        //                             BorderSide(color: ColorManager.glodenColor),
        //                         borderRadius: BorderRadius.circular(10)),
        //                     hintText: "Select Class Room",
        //                     hintStyle: nunitoRegular.copyWith(
        //                         fontSize: 16, color: ColorManager.black)),
        //               ),
        //               onChanged: (
        //                 (value) {
        //                   controller.selectedRoom = value!.obs;
        //                   controller.selectedRoom!.call();
        //                 },
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 10,
        //             ),
        //             DropdownSearch<String>(
        //               items: controller.roomType,
        //               dropdownDecoratorProps: DropDownDecoratorProps(
        //                 dropdownSearchDecoration: InputDecoration(
        //                     focusedBorder: OutlineInputBorder(
        //                         borderSide:
        //                             BorderSide(color: ColorManager.glodenColor),
        //                         borderRadius: BorderRadius.circular(10)),
        //                     border: OutlineInputBorder(
        //                         borderSide:
        //                             BorderSide(color: ColorManager.glodenColor),
        //                         borderRadius: BorderRadius.circular(10)),
        //                     hintText: "Select Class Type",
        //                     hintStyle: nunitoRegular.copyWith(
        //                         fontSize: 16, color: ColorManager.black)),
        //               ),
        //               onChanged: (
        //                 (value) {
        //                   controller.selectedroomType = value!.obs;
        //                   controller.selectedroomType!.call();
        //                 },
        //               ),
        //             ),
        //           ],
        //         ),
        // ),
        const SizedBox(
          height: 10,
        ),
        Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: newname,
                  decoration: const InputDecoration(hintText: "Room New Name"),
                ),
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(11),
                    ),
                    color: ColorManager.bgSideMenu,
                  ),
                  child: Center(
                    child: Text(
                      "Back",
                      style: nunitoRegular.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                // onTap: () {
                //   if (controller.selectedroomType != null &&
                //       controller.selectedRoom != null) {
                //     controller.sendRoomToServer(ExamRoom(
                //         schoolClassType: controller.selectedroomType!.value,
                //         schoolClassId: controller.selectedRoom!.value.id!,
                //         controlmissionId: controller.missionDetials!.id!,
                //         name: newname.text,
                //         capacity: controller.selectedRoom!.value.maxCapacity));
                //     Get.back();
                //     Get.snackbar("Exam Room", "Added succesfuly",
                //         colorText: Colors.white, backgroundColor: Colors.green);
                //   } else {
                //     Get.snackbar("missing data", "complete data",
                //         colorText: Colors.white, backgroundColor: Colors.red);
                //   }
                // },
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
      ],
    );
  }
}
