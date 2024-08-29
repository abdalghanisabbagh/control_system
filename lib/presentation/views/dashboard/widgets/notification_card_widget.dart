import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

class NotificationCardWidget extends StatelessWidget {
  final DateTime now = DateTime.now();

  final String schoolName;
  final String userName;
  NotificationCardWidget({
    super.key,
    required this.userName,
    required this.schoolName,
  });

  String get welcomeMessage => now.hour < 12
      ? 'Good Morning, $userName'
      : now.hour < 17
          ? 'Good Afternoon, $userName'
          : 'Good Evening, $userName';

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 620;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(2, 15),
          ),
        ],
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
          ),
          if (isWideScreen) ...[
            const SizedBox(width: 20),
            Image.asset(
              AssetsManager.assetsIconsNotificationImage,
              height: 160,
            ),
          ],
        ],
      ),
    );
  }
}
