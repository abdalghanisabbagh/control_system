import 'package:custom_theme/lib.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/services/side_menue_get_controller.dart';

class SideMenueWidget extends GetView<SideMenueGetController> {
  final bool isMobile;

  const SideMenueWidget({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      showToggle: true,
      controller: controller.sideMenuController,
      style: SideMenuStyle(
        showTooltip: true,
        hoverColor: ColorManager.darkGrey,
        selectedHoverColor: ColorManager.darkGrey,
        selectedTitleTextStyle: nunitoBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s16,
        ),
        selectedIconColor: ColorManager.white,
        selectedTitleTextStyleExpandable: nunitoBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s16,
        ),
        unselectedTitleTextStyleExpandable: nunitoBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s16,
        ),
        unselectedTitleTextStyle: nunitoBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s16,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              AssetsManager.assetsLogosNIS5,
            ),
          ),
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                "Control System",
                style: nunitoRegularStyle(
                    color: ColorManager.white, fontSize: AppSize.s18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Divider(
            indent: 8.0,
            endIndent: 8.0,
          ),
        ],
      ),
      items: controller.getUserMenue(context),
    );
  }
}
