import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart' show MaterialScrollBehavior;

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
