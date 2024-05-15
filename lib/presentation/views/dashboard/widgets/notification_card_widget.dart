import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(2, 15), // changes position of shadow
          ),
        ],
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'School Name',
                style: nunitoBold.copyWith(
                  color: ColorManager.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Today Will Create Exam Path",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorManager.black,
                  height: 1.5,
                ),
              ),
            ],
          ),
          if (MediaQuery.of(context).size.width >= 620) ...{
            const Spacer(),
            Image.asset(
              AssetsManager.assetsIconsNotificationImage,
              height: 160,
            )
          }
        ],
      ),
    );
  }
}
