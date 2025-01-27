import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../domain/services/side_menue_get_controller.dart';
import '../resource_manager/routes/app_routes_names_and_paths.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'NIS Control System',
        style: nunitoBold.copyWith(color: ColorManager.white),
      ),
      backgroundColor: ColorManager.primary,
      leading: GetBuilder<SideMenuGetController>(
        builder: (sideMenueGetController) {
          return IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: sideMenueGetController.menuIconAnimationController,
            ),
            color: ColorManager.white,
            onPressed: () {
              sideMenueGetController.isSideMenuVisible
                  ? sideMenueGetController.menuIconAnimationController.reverse()
                  : sideMenueGetController.menuIconAnimationController
                      .forward();
              sideMenueGetController.toggleSideMenuVisibility();
            },
          );
        },
      ),
      actions: [
        IconButton(
          tooltip: 'Edit Profile',
          icon: const Icon(
            Icons.account_circle,
            size: 30,
            color: ColorManager.white,
          ),
          onPressed: () {
            context.goNamed(AppRoutesNamesAndPaths.profileScreenName);
          },
          padding: const EdgeInsets.only(right: 25),
        ),
      ],
    );
  }
}
