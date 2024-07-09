import 'dart:ui';

import 'package:pdf/pdf.dart';

extension ConvertMaterialColorToPdfColorExtension on Color {
  PdfColor toPdfColorFromValue() {
    return PdfColor.fromInt(value);
  }
}
