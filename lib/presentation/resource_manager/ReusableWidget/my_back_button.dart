import 'package:flutter/foundation.dart' show VoidCallback, kIsWeb;
import 'package:flutter/material.dart'
    show BackButton, BuildContext, StatelessWidget, Widget, Color;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_html/html.dart' show window;

class MyBackButton extends StatelessWidget {
  final Color? color;

  final VoidCallback? onPressed;
  const MyBackButton({super.key, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return BackButton(
      color: color,
      onPressed: () {
        onPressed?.call();
        kIsWeb ? window.history.back() : Get.key.currentContext!.pop();
      },
    );
  }
}
