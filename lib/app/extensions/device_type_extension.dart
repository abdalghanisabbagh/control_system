import 'package:flutter/widgets.dart';

import '../../presentation/resource_manager/enums/device_type_enum.dart';

extension DeviceTypeExtension on BuildContext {
  /// This size work for my design, maybe you need some changes depend on your design
  /// make function that can help us later
  DeviceTypeEnum get getDeviceType {
    final width = MediaQuery.sizeOf(this).width;

    if (width >= 1100) {
      return DeviceTypeEnum.desktop;
    } else if (width >= 900) {
      return DeviceTypeEnum.tablet;
    } else {
      return DeviceTypeEnum.mobile;
    }
  }

  bool get isMobile => getDeviceType == DeviceTypeEnum.mobile;

  bool get isTablet => getDeviceType == DeviceTypeEnum.tablet;

  bool get isDesktop => getDeviceType == DeviceTypeEnum.desktop;
}
