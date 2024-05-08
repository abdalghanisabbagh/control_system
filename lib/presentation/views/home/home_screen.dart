import 'package:control_system/domain/controllers/home_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title').tr(),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.setLocale(const Locale('ar', 'EG'));
              },
              child: const Text(
                'العربية',
              ),
            ),
            TextButton(
              onPressed: () {
                context.setLocale(const Locale('en', 'US'));
              },
              child: const Text(
                'English',
              ),
            ),
          ],
      body: const Center(
        child: Text(
          'HomeScreenn',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
