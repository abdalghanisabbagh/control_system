import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/barcodeController/barcode_controller.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';

class SetDegreesScreen extends GetView<BRCodeController> {
  const SetDegreesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // controller.brCodeFoucs.requestFocus();
    return BaseScreen(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: ColorManager.bgColor,
        child: Column(
          children: [
            const HeaderWidget(text: "Student Grades"),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              cursorColor: ColorManager.bgSideMenu,
              style: nunitoRegular.copyWith(
                  fontSize: 14, color: ColorManager.bgSideMenu),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              // controller: bRCController.barcodeController,
              // focusNode: bRCController.brCodeFoucs,
              // onChanged: (brCodeValue) {
              //   if (brCodeValue.length >= 6) {
              //     bRCController.degreeController.requestFocus();
              //     log('true');
              //   }
              // },
              // onFieldSubmitted: (value) {
              //   if (value.length >= 6) {
              //     bRCController.getDataFromBarcode(value);
              //     bRCController.degreeController.requestFocus();
              //     log('true');
              //   }
              // },
            ),
            const SizedBox(
              height: 30,
            ),
            // const Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       Expanded(
            //         child: Padding(
            //           padding: EdgeInsets.all(10),
            // child: GetBuilder(
            //     builder: (bRCController) => bRCController.buildwidget
            //         ? const BRCodeSubjects()
            //         : Lottie.asset(
            //             Constants.assetsImagesPath +
            //                 Paths.barcodeScanner,
            //           )),
            //     ),
            //   ),
            // ],
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}
