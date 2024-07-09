import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/auth_controller.dart';
import 'package:control_system/domain/controllers/profile_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/resource_manager/assets_manager.dart';
import '../../presentation/resource_manager/routes/index.dart';

class AppMenueItem {
  String pageName;
  String pageNumber;
  String? routeName;
  Widget? iconWidget;
  AppMenueItem({
    required this.pageName,
    required this.pageNumber,
    this.routeName,
    this.iconWidget,
  });
}

class SideMenueGetController extends GetxController {
  int nowIndex = 0;
  late final SideMenuController sideMenuController;
  List<SideMenuItem> userMenue = [];
  List<AppMenueItem> allMenue = [
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.studentScreenName,
        pageNumber: '1000',
        routeName: AppRoutesNamesAndPaths.studentScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsStudent)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.controlBatchScreenName,
        pageNumber: '2000',
        routeName: AppRoutesNamesAndPaths.controlBatchScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsExam)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.batchDocumentsScreenName,
        pageNumber: '3000',
        routeName: AppRoutesNamesAndPaths.batchDocumentsScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc)),
    // AppMenueItem(
    //     pageName: AppRoutesNamesAndPaths.certificateScreenName,
    //     pageNumber: '4000',
    //     routeName: AppRoutesNamesAndPaths.certificateScreenName,
    //     iconWidget: Image.asset(AssetsManager.assetsIconsCertificates)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.setDegreesScreenName,
        pageNumber: '4000',
        routeName: AppRoutesNamesAndPaths.setDegreesScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsProccess)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.schoolsScreenName,
        pageNumber: '5000',
        routeName: AppRoutesNamesAndPaths.schoolsScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsCampus)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.classRoomScreenName,
        pageNumber: '6000',
        routeName: AppRoutesNamesAndPaths.classRoomScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsClassRooms)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.subjectSettingScreenName,
        pageNumber: '7000',
        routeName: AppRoutesNamesAndPaths.subjectSettingScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsSupject)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.cohortSettingScreenName,
        pageNumber: '8000',
        routeName: AppRoutesNamesAndPaths.cohortSettingScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsCohort)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.adminScreenName,
        pageNumber: '9000',
        routeName: AppRoutesNamesAndPaths.adminScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsAdmin)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.proctorScreenName,
        pageNumber: '10000',
        routeName: AppRoutesNamesAndPaths.proctorScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.rolesScreenName,
        pageNumber: '11000',
        routeName: AppRoutesNamesAndPaths.rolesScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsRoles)),
  ];

  @override
  void onClose() {
    sideMenuController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    sideMenuController = SideMenuController();
    super.onInit();
  }

  List<SideMenuItem> getUserMenue(BuildContext context) {
    ProfileController profileController = Get.find();

    final List<SideMenuItem> sideMenueItems = [
      SideMenuItem(
        title: AppRoutesNamesAndPaths.dashBoardScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.dashBoardScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsDashboard),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
    ];

    sideMenueItems.addAll(allMenue
        .where((page) {
          return profileController.cachedUserProfile!.roles!.where((role) {
            var screen = role.screens!.where((screen) {
              return screen.frontId == page.pageNumber;
            }).isNotEmpty;
            return screen;
          }).isNotEmpty;
        })
        .map((page) => SideMenuItem(
              title: page.pageName,
              onTap: (index, _) {
                context.goNamed(page.routeName!);
                changePage(index);
              },
              iconWidget: page.iconWidget,
            ))
        .toList());

    sideMenueItems.add(
      SideMenuItem(
        title: 'Sign Out',
        onTap: (index, _) {
          MyAwesomeDialogue(
            title: "You are about to sign out",
            desc: "Are you sure you want to sign out?",
            dialogType: DialogType.warning,
            btnOkOnPressed: () async {
              await Get.find<AuthController>().signOut().then((value) {
                context.goNamed(AppRoutesNamesAndPaths.loginScreenName);
              });
            },
            btnCancelOnPressed: () {},
          ).showDialogue(context);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsLogout),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
    );
    userMenue = sideMenueItems;
    return userMenue;
  }

  changePage(int currentIndex) {
    sideMenuController.changePage(currentIndex);
  }

  onRouteChange(String name) {
    final index = userMenue.indexWhere((element) => element.title == name);
    if (index != -1) {
      sideMenuController.changePage(index);
    }
  }
}
