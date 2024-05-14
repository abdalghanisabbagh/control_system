import 'package:control_system/presentation/resource_manager/styles_manager.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        key: key,
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Add New User",
                style: nunitoBoldStyle(color: Colors.black),
              ),
            )
          ],
        ));
  }
}
