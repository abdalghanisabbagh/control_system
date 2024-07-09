import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

abstract class LoadingIndicators {
  static Widget getLoadingIndicator() => const SizedBox(
        height: 80,
        width: 80,
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
        ),
      );
}
