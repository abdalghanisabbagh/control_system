import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/app_menue_item_model.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import '../../presentation/resource_manager/routes/index.dart';
import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class SideMenueGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isSideMenuVisible = true;
  late AnimationController menuIconAnimationController;
  int nowIndex = 0;
  final PageStorageBucket sideMenuBucket = PageStorageBucket();
  late final SideMenuController sideMenuController;
  final PageStorageKey sideMenuStorageKey = const PageStorageKey('sideMenuKey');
  List<SideMenuItem> userMenue = [];

  changePage(int currentIndex) {
    Hive.box('SideMenueIndex').put('index', currentIndex);
    sideMenuController.changePage(currentIndex);
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

    sideMenueItems.addAll(AppMenueItem.allMenue
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
                context.mounted
                    ? context.goNamed(AppRoutesNamesAndPaths.loginScreenName)
                    : null;
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

  @override
  void onClose() {
    sideMenuController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    menuIconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 1.0,
    )..addListener(() {
        update();
      });
    sideMenuController = SideMenuController(
      initialPage: Hive.box('SideMenueIndex').get('index') ?? nowIndex,
    );
  }

  onRouteChange(String name) {
    final index = userMenue.indexWhere((element) => element.title == name);
    if (index != -1) {
      sideMenuController.changePage(index);
    }
  }

  void toggleSideMenuVisibility() {
    isSideMenuVisible = !isSideMenuVisible;
    update();
  }
}
