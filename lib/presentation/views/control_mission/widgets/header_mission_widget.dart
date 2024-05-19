import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';

class HeaderMissionWidget extends StatelessWidget {
  const HeaderMissionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      'Control Mission',
      style: nunitoBlack.copyWith(
        color: ColorManager.bgSideMenu,
        fontSize: 30,
      ),
    );
  }
}
