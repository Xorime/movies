import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension StringParser on String {}

extension TextStyleExt on BuildContext {
  TextStyle? workSans({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
    Paint? foreground,
    double? height,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.workSans(
      color: color,
      decoration: decoration,
      decorationColor: color,
      foreground: foreground,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }
}
