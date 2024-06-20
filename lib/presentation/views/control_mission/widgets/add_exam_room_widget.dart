import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/control_mission/distribution_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/index.dart';

// ignore: must_be_immutable
class AddExamRoomWidget extends GetView<DistributionController> {
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
        GetBuilder<DistributionController>(
          builder: (_) {
            if (controller.isLoadingGetClassRoom) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.optionsClassRoom.isEmpty) {
              return const Text('No items available');
            }

            return SizedBox(
              width: 500,
              child: MultiSelectDropDownView(
                hintText: "Select Education Year",
                onOptionSelected: (selectedItem) {
                  controller.setSelectedItemClassRoom(selectedItem);
                },
                showChipSelect: false,
                options: controller.optionsClassRoom,
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MytextFormFiled(controller: newname, title: "Room Name"),
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Expanded(
              child: ElevatedBackButton(),
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
