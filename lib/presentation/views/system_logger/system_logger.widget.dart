import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

import '../base_screen.dart';

class SystemLoggerWidget extends StatelessWidget {
  const SystemLoggerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}
