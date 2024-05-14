// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      items: [
        SideMenuItem(
          title: 'Dashboard',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsDashboard),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Students',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsStudent),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Control Batch',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsExam),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Batch Documents',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Certificates',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsCertificates),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Scanning Grades',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsProccess),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'School',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsCampus),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Classrooms',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsClassRooms),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Subject',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsSupject),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Chorts',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsCohort),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Admins',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsAdmin),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Proctors',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Sign Out',
          onTap: (index, _) {
            controller.sideMenuController.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsLogout),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
      ],
    );
  }
}
