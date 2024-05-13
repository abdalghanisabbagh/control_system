import 'package:control_system/presentation/resource_manager/app_responsive.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/views/side_menue/side_menue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
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
            if (AppResponsive.isDesktop(context))
               Expanded(
                flex: 1,
                child: Container(
                  color: ColorManager.bgSideMenu,
                  child:const SideMenueWidget(
                    isMobile: false,
                  ),
                ),
              ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: body),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: AppResponsive.isMobile(context)
          ? const SideMenueWidget(
              isMobile: true,
            )
          : null,
    );
  }
}
