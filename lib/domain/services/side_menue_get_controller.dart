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
    // TODO :: Cheke roles
    /*   final List<SideMenuItem> sideMenueItems = [
      SideMenuItem(
        title: AppRoutesNamesAndPaths.dashBoardScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.dashBoardScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsDashboard),
        tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.studentScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.studentScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsStudent),
        tooltipContent: "This is a tooltip for Student item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.controlBatchScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.controlBatchScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsExam),
        tooltipContent: "This is a tooltip for Control Mission item",
      ),
      // SideMenuItem(
      //   title: AppRoutesNamesAndPaths.batchDocumentsScreenName,
      //   onTap: (index, _) {
      //     context.goNamed(AppRoutesNamesAndPaths.batchDocumentsScreenName);
      //     changePage(index);
      //   },
      //   iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
      //   tooltipContent: "This is a tooltip for Batch Documents item",
      // ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.batchDocumentsScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.batchDocumentsScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
        tooltipContent: "This is a tooltip for Batch Documents item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.certificateScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.certificateScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsCertificates),
        tooltipContent: "This is a tooltip for Certificates item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.setDegreesScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.setDegreesScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsProccess),
        tooltipContent: "This is a tooltip for Set Degrees item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.schoolsScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.schoolsScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsCampus),
        tooltipContent: "This is a tooltip for Schools item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.classRoomScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.classRoomScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsClassRooms),
        tooltipContent: "This is a tooltip for Class Rooms item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.subjectSettingScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.subjectSettingScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsSupject),
        tooltipContent: "This is a tooltip for Subjects item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.cohortSettingScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.cohortSettingScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsCohort),
        tooltipContent: "This is a tooltip for Cohort Settings item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.adminScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.adminScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsAdmin),
        tooltipContent: "This is a tooltip for Admin item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.proctorScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.proctorScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
        tooltipContent: "This is a tooltip for Proctor item",
      ),
      SideMenuItem(
        title: AppRoutesNamesAndPaths.rolesScreenName,
        onTap: (index, _) {
          context.goNamed(AppRoutesNamesAndPaths.rolesScreenName);
          changePage(index);
        },
        iconWidget: Image.asset(AssetsManager.assetsIconsRoles),
        tooltipContent: "This is a tooltip for Roles item",
      ),
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
    ];
*/
    // TODO :: Cheke roles
    // .where((element) => element.title!.toLowerCase().contains('s'))
    // .toList();
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
          return profileController.cachedUserProfile!.roles!
                  .firstWhereOrNull((role) {
                var screen = role.screens!.firstWhereOrNull((screen) {
                      return screen.frontId == page.pageNumber;
                    }) !=
                    null;
                return screen;
              }) !=
              null;
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
