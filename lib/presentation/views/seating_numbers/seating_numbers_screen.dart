import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';

class SeatingNumbersScreen extends StatelessWidget {
  const SeatingNumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: const Center(
        child: Text("Seating Numbers Screen"),
      ),
    );
  }
}
