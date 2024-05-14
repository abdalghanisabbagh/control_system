import 'package:control_system/domain/services/side_menue_get_controller_service.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenueWidget extends GetView<SideMenueGetControllerService> {
  const SideMenueWidget({
    super.key,
    required this.isMobile,
  });
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    
    return SideMenu(
      showToggle: true,
      controller: controller.sideMenuController,
      style: SideMenuStyle(
        showTooltip: true,
        hoverColor: ColorManager.darkGrey,
        selectedHoverColor: ColorManager.darkGrey,
        selectedColor: ColorManager.darkPrimary,
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
            child: Image.asset(
              AssetsManager.assetsLogosNIS5,
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "Control System",
              style: nunitoRegulerStyle(
                  color: ColorManager.white, fontSize: AppSize.s18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(
            indent: 8.0,
            endIndent: 8.0,
          ),
        ],
      ),
      items: controller.generateUserMenue(context),
    );
  }
}
