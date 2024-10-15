import 'dart:ui';

import 'package:pdf/pdf.dart';

extension ConvertMaterialColorToPdfColorExtension on Color {
  /// Converts this [Color] to a [PdfColor] using its [value] property.
  ///
  /// The [value] property is an integer that represents the color in its
  /// most compact form. This is the property that is used by the [PdfColor]
  /// class to represent the color.
  ///
  /// This method is useful when you need to convert a [Color] to a [PdfColor]
  /// in order to use it in a PDF document.
  PdfColor toPdfColorFromValue() {
    return PdfColor.fromInt(value);
  }
}
