import 'package:control_system/presentation/views/base_screen.dart';
import 'package:control_system/presentation/views/control_mission/widgets/header_mission_widget.dart';
import 'package:flutter/material.dart';

import '../../resource_manager/color_manager.dart';

class ControlMissionScreen extends StatelessWidget {
  const ControlMissionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const Column(
          children: [
            HeaderMissionWidget(),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Obx(() => creatMissionController.yearList.isEmpty
                  //     ? const Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  //     : DropdownSearch<YearsResponse>(
                  //         items: creatMissionController.yearList,
                  //         itemAsString: (item) => item.year,
                  //         selectedItem:
                  //             creatMissionController.selectedyear !=
                  //                     null
                  //                 ? creatMissionController
                  //                     .selectedyear!.value
                  //                 : null,
                  //         dropdownDecoratorProps:
                  //             DropDownDecoratorProps(
                  //           dropdownSearchDecoration: InputDecoration(
                  //               focusedBorder: OutlineInputBorder(
                  //                   borderSide: BorderSide(
                  //                       color: ColorManager.glodenColor),
                  //                   borderRadius:
                  //                       BorderRadius.circular(10)),
                  //               border: OutlineInputBorder(
                  //                   borderSide: BorderSide(
                  //                       color: ColorManager.glodenColor),
                  //                   borderRadius:
                  //                       BorderRadius.circular(10)),
                  //               hintText: "Select Education Years",
                  //               hintStyle: AppTextStyle.nunitoRegular
                  //                   .copyWith(
                  //                       fontSize: 16,
                  //                       color: ColorManager.black)),
                  //         ),
                  //         onChanged: ((value) {
                  //           controller.selectedyear = value?.obs;
                  //           controller.onChangeYear(value!);
                  //         }),
                  //       )),
                  // Obx(() => controller.missionsLoader.value == false
                  //     ? controller.missions.isEmpty
                  //         ? const Expanded(
                  //             child: Center(
                  //               child: Text("No Mission"),
                  //             ),
                  //           )
                  //         : Expanded(
                  //             child: ListView.builder(
                  //               itemCount: controller.missions.length,
                  //               itemBuilder: (context, index) {
                  //                 log(index.toString());

                  //                 return ControlMissionWidgetQuickReview(
                  //                   missionResponseindex: index,
                  //                 );
                  //               },
                  //             ),
                  //           )
                  //     : const Expanded(
                  //         child: Center(
                  //             child: CircularProgressIndicator()),
                  //       )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
