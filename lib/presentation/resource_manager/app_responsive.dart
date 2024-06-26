import 'package:flutter/material.dart';

import '../../app/extensions/device_type_extension.dart';
import 'enums/device_type_enum.dart';

class AppResponsive extends StatelessWidget {
  const AppResponsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  final Widget desktop;
  final Widget mobile;
  final Widget tablet;

  @override
  Widget build(BuildContext context) {
    return switch (context.getDeviceType) {
      DeviceTypeEnum.mobile => mobile,
      DeviceTypeEnum.tablet => tablet,
      DeviceTypeEnum.desktop => desktop,
    };
  }
}
