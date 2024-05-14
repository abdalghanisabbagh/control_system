import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/routes/index.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SideMenueGetControllerService extends GetxController {
  late final SideMenuController sideMenuController;
  int nowIndex = 0;
  @override
  List<SideMenuItem> getUserMenue(BuildContext context) {
    // TODO :: Cheke roles
    final List<SideMenuItem> sideMenueItems = [
      SideMenuItem(
        title: 'Dashboard',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.dashBoardScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsDashboard),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Students',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.studentScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsStudent),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Control Batch',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.classRoomScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsExam),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Batch Documents',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.classRoomScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Certificates',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.certificateScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsCertificates),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Scanning Grades',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.setDegreesScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsProccess),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'School',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.schoolsScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsCampus),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Classrooms',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.classRoomScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsClassRooms),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Subject',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.subjectSettingScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsSupject),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Cohorts',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.cohortSettingScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsCohort),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Admins',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.userScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsAdmin),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Proctors',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.proctorScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: 'Sign Out',
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.loginScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsLogout),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
    ];

    return sideMenueItems
        .where((element) => element.title!.toLowerCase().contains('s'))
        .toList();
  }

  changePage(int currentIndex) {
    sideMenuController.changePage(currentIndex);
  }

  @override
  void onInit() {
    sideMenuController = SideMenuController();

    super.onInit();
  }

  @override
  void onClose() {
    sideMenuController.dispose();
    super.onClose();
  }
}
