import 'package:flutter/material.dart';

import '../base_screen.dart';

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: const Center(
        child: Text("Roles Screen"),
      ),
    );
  }
}
