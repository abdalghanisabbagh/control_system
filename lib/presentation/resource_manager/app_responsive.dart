import 'package:flutter/material.dart';

import '../../app/extensions/device_type_extension.dart';
import 'enums/device_type_enum.dart';

class AppResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const AppResponsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });
  @override
  Widget build(BuildContext context) {
    return switch (context.getDeviceType) {
      DeviceTypeEnum.mobile => mobile,
      DeviceTypeEnum.tablet => tablet,
      DeviceTypeEnum.desktop => desktop,
    };
  }
}
