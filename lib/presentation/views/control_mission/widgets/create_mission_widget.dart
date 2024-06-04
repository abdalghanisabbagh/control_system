import 'package:flutter/material.dart';

import '../../../resource_manager/index.dart';

class CreateMissionWidget extends StatelessWidget {
  const CreateMissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Form(
          // key: controller.missionNameFormKey,
          child: Column(
            children: [
              TextFormField(
                // controller: controller.missonNameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.glodenColor),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.glodenColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: const Text("Mission Name"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Obx(() => controller.yearList.isEmpty
              //     ? const SizedBox.shrink()
              //     : DropdownSearch<YearsResponse>(
              //         items: controller.yearList,
              //         itemAsString: (item) => item.year,
              //         selectedItem: controller.selectedyear?.value,
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
              //               hintStyle: nunitoRegular
              //                   .copyWith(fontSize: 16, color: ColorManager.black)),
              //         ),
              //         onChanged: ((value) {
              //           controller.selectedyear = value?.obs;
              //           controller.selectedyear!.value = value!;
              //         }),
              //       )),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
