import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_back_button.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/system_logger_controller.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';

class UserInfoWidget extends GetView<SystemLoggerController> {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.2,
      height: Get.height * 0.40,
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: GetBuilder<SystemLoggerController>(builder: (_) {
          if (controller.isLoadingGetUserInfo) {
            return Center(child: LoadingIndicators.getLoadingIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'User Information',
                  style: nunitoBoldStyle(
                      fontSize: 30, color: ColorManager.primary),
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.blueAccent),
                  const SizedBox(width: 10),
                  Text(
                    'Username: ',
                    style: nunitoBoldStyle(
                      fontSize: 16,
                      color: ColorManager.black,
                    ),
                  ),
                  Text(controller.userName ?? '', style: nunitoRegularStyle()),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.account_circle, color: Colors.green),
                  const SizedBox(width: 10),
                  Text(
                    'Full Name: ',
                    style: nunitoBoldStyle(
                      fontSize: 16,
                      color: ColorManager.black,
                    ),
                  ),
                  Text(controller.fullName ?? '', style: nunitoRegularStyle()),
                ],
              ),
              const SizedBox(height: 20),
              const ElevatedBackButton()
            ],
          );
        }),
      ),
    );
  }
}
