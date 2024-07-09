import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/profile_controller.dart';
import '../../../resource_manager/index.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';

class HeaderMissionWidget extends StatelessWidget {
  const HeaderMissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Control Mission',
          style: nunitoBlack.copyWith(
            color: ColorManager.bgSideMenu,
            fontSize: 30,
          ),
        ),
        Visibility(
          visible: Get.find<ProfileController>().canAccessWidget(
            widgetId: '2100',
          ),
          child: InkWell(
            onTap: () {
              context.goNamed(AppRoutesNamesAndPaths.createMissionScreenName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.glodenColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Create Mission",
                    style: nunitoBold.copyWith(
                      color: ColorManager.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
