import 'package:flutter/material.dart';

import '../../../resource_manager/index.dart';

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
