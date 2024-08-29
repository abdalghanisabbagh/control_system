import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

import '../base_screen.dart';

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
