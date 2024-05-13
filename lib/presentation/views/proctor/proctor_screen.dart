import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';

class ProctorScreen extends StatelessWidget {
  const ProctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: const Center(
        child: Text("Proctor Screen"),
      ),
    );
  }
}
