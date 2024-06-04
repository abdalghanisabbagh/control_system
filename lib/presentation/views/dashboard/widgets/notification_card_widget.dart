import 'package:flutter/material.dart';

import '../../../resource_manager/assets_manager.dart';
import '../../../resource_manager/index.dart';

class NotificationCardWidget extends StatelessWidget {
  NotificationCardWidget({
    super.key,
    required this.userName,
    required this.schoolName,
  });

  final String userName;
  final String schoolName;

  final DateTime now = DateTime.now();

  String get welcomeMessage => now.hour < 12
      ? 'Good Morning, $userName'
      : now.hour < 17
          ? 'Good Afternoon, $userName'
          : 'Good Evening, $userName';

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
                '$schoolName School',
                style: nunitoBold.copyWith(
                  color: ColorManager.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                welcomeMessage,
                style: nunitoBold.copyWith(
                  color: ColorManager.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
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
