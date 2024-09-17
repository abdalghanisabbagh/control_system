import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/services/side_menue_get_controller.dart';
import 'custom_app_bar_widget.dart';
import 'side_menue/side_menue.dart';

class BaseScreen extends GetView<SideMenueGetController> {
  final PreferredSizeWidget? appbar;

  final Widget body;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BaseScreen({
    super.key,
    required this.body,
    this.appbar,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GetBuilder<SideMenueGetController>(
          builder: (controller) {
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: ColorManager.bgColor,
              appBar: appbar ?? const CustomAppBar(),
              body: SafeArea(
                child: Row(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1, 0),
                              end: const Offset(0, 0),
                            ).animate(animation),
                            child: child);
                      },
                      child: controller.isSideMenuVisible
                          ? Container(
                              width: constraints.maxWidth * 0.15,
                              color: ColorManager.bgSideMenu,
                              child: const SideMenueWidget(
                                isMobile: false,
                              ),
                            )
                          : SizedBox.shrink(
                              key: ValueKey<bool>(controller.isSideMenuVisible),
                            ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: body,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
