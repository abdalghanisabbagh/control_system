import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/roles_controller.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/styles_manager.dart';
import '../../../resource_manager/validations.dart';

class AddNewScreenWidget extends StatelessWidget {
  AddNewScreenWidget({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController screenIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add New Screen",
            style: nunitoBlack.copyWith(
              color: ColorManager.bgSideMenu,
              fontSize: 30,
            ),
          ),
          MytextFormFiled(
            myValidation: Validations.requiredValidator,
            controller: nameController,
            title: "Screen Name",
          ),
          MytextFormFiled(
            myValidation: Validations.requiredValidator,
            controller: screenIdController,
            title: "Screen Id",
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<RolesController>(builder: (controller) {
            return controller.addLoading
                ? Center(
                    child: LoadingIndicators.getLoadingIndicator(),
                  )
                : Row(
                    children: [
                      const Expanded(
                        child: ElevatedBackButton(),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedAddButton(
                          onPressed: () async {
                            controller
                                .addNewScreen(
                                    name: nameController.text,
                                    frontId: screenIdController.text)
                                .then((added) {
                              if (added) {
                                nameController.clear();
                                screenIdController.clear();
                                Get.back();
                                MyFlashBar.showSuccess(
                                        'Screen has ben added', 'Screen')
                                    .show(Get.key.currentContext);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  );
          }),
        ],
      ),
    );
  }
}
