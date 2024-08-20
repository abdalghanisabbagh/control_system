import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../resource_manager/routes/app_routes_names_and_paths.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'NIS Control System',
        style: nunitoBold.copyWith(color: ColorManager.white),
      ),
      backgroundColor: ColorManager.primary,
      actions: [
        IconButton(
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

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
