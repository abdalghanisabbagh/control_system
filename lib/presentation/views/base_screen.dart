import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/extensions/device_type_extension.dart';
import '../../domain/services/side_menue_get_controller.dart';
import '../resource_manager/color_manager.dart';
import '../resource_manager/index.dart';
import 'side_menue/side_menue.dart';

class BaseScreen extends GetView<SideMenueGetController> {
  BaseScreen({
    super.key,
    required this.body,
    this.appbar,
    // this.drawer
  });

  final PreferredSizeWidget? appbar;
  final Widget body;

  // final Widget? drawer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
