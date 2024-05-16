import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}
