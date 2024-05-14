import 'package:control_system/app/extensions/device_type_extension.dart';
import 'package:control_system/domain/services/side_menue_get_controller_service.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/views/side_menue/side_menue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScreen extends GetView<SideMenueGetControllerService> {
  final Widget body;
  final PreferredSizeWidget? appbar;
  // final Widget? drawer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BaseScreen({
    super.key,
    required this.body,
    this.appbar,
    // this.drawer
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorManager.background,
      appBar: appbar,
      body: SafeArea(
        child: Row(
          children: [
            if (context.isDesktop)
              Expanded(
                flex: 1,
                child: Container(
                  color: ColorManager.bgSideMenu,
                  child: const SideMenueWidget(
                    isMobile: false,
                  ),
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
      drawer: context.isMobile
          ? const SideMenueWidget(
              isMobile: true,
            )
          : null,
    );
  }
}
