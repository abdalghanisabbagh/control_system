import 'package:control_system/app/extensions/device_type_extension.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';

import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../base_screen.dart';
import 'widgets/index.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const HeaderWidget(text: "Dashboard"),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          const NotificationCardWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          if (context.isMobile) ...{
                            const CalendarWidget(),
                            const SizedBox(
                              height: 20,
                            ),
                          },
                          const RecruitmentDataWidget(),
                        ],
                      ),
                    ),
                    if (!context.isMobile)
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Column(
                            children: [
                              CalendarWidget(),
                              SizedBox(
                                height: 20,
                              ),
                              ProfileCardWidget(),
                              SizedBox(
                                height: 20,
                              ),
                              ClockWidget(),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
