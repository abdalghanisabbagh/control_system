import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: const Center(
        child: Text("Dash Board Screen"),
      ),
    );
  }
}
