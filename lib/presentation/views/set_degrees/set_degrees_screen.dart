import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';

class SetDegreesScreen extends StatelessWidget {
  const SetDegreesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: const Center(
        child: Text("Set Degrees Screen"),
      ),
    );
  }
}
