import 'package:control_system/presentation/views/control_mission/widgets/create_mission_widget.dart';
import 'package:flutter/material.dart';

import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/index.dart';

class HeaderMissionWidget extends StatelessWidget {
  const HeaderMissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Control Mission',
          style: nunitoBlack.copyWith(
            color: ColorManager.bgSideMenu,
            fontSize: 30,
          ),
        ),
        InkWell(
          onTap: () {
            MyDialogs.showDialog(
              context,
              CreateMissionWidget(),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.glodenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Create Mission",
                  style: nunitoBold.copyWith(
                    color: ColorManager.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
