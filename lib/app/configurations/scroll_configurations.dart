import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart' show MaterialScrollBehavior;

/// Scroll configurations for the app
///
/// This class is used to configure the scroll behavior of the app.
///
/// The [dragDevices] property is overridden to allow both touch and
/// mouse drag gestures to be used for scrolling. This allows the app
/// to be used on both touch and desktop devices.
///
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
