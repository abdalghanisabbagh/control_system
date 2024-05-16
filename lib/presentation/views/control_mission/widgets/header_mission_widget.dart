import 'package:control_system/app/extensions/device_type_extension.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';

class HeaderMissionWidget extends StatelessWidget {
  const HeaderMissionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (context.isDesktop)
            IconButton(
              icon: Icon(
                Icons.menu,
                color: ColorManager.black,
              ),
              onPressed: () {},
            ),
          Text(
            'Control Mission',
            style: nunitoBlack.copyWith(
              color: ColorManager.bgSideMenu,
              fontSize: 30,
            ),
          ),
          if (context.isMobile) ...{
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                navigationIcon(
                  icon: Icons.add,
                  onTap: () {
                    // Get.toNamed(Routes.createMission);
                  },
                  tip: "Add new Mission",
                ),
              ],
            )
          }
        ],
      ),
    );
  }

  Widget navigationIcon({icon, onTap, tip}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: onTap,
        tooltip: tip,
        icon: Icon(
          icon,
          color: ColorManager.black,
        ),
      ),
    );
  }
}
