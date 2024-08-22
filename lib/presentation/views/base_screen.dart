import 'package:control_system/presentation/views/custom_app_bar_widget.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/services/side_menue_get_controller.dart';
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
    return GetBuilder<SideMenueGetController>(
      builder: (controller) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: ColorManager.background,
          appBar: appbar ?? const CustomAppBar(),
          body: SafeArea(
            child: Row(
              children: [
                if (controller.isSideMenuVisible) 
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
          
        
        );
      },
    );
  }
}
