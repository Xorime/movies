import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/utils/constants.dart';

class Utils {
  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    const lowDivisor = 6;
    const highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: hslColor.withLightness((lightness + (lowStep * 5)).clamp(0.0, 1.0)).toColor(),
      100: hslColor.withLightness((lightness + (lowStep * 4)).clamp(0.0, 1.0)).toColor(),
      200: hslColor.withLightness((lightness + (lowStep * 3)).clamp(0.0, 1.0)).toColor(),
      300: hslColor.withLightness((lightness + (lowStep * 2)).clamp(0.0, 1.0)).toColor(),
      400: hslColor.withLightness((lightness + lowStep).clamp(0.0, 1.0)).toColor(),
      500: color,
      600: hslColor.withLightness((lightness - highStep).clamp(0.0, 1.0)).toColor(),
      700: hslColor.withLightness((lightness - (highStep * 1.5)).clamp(0.0, 1.0)).toColor(),
      800: hslColor.withLightness((lightness - (highStep * 2)).clamp(0.0, 1.0)).toColor(),
      900: hslColor.withLightness((lightness - (highStep * 2.5)).clamp(0.0, 1.0)).toColor(),
    };
  }

  static popUpSuccess({required String body, String? title}) {
    popup(body: body, type: kPopupSuccess);
  }

  static popUpFailed({required String body}) {
    // popUpContext(body: body, type: kPopupFailed);
    popup(body: body, type: kPopupFailed);
  }

  static popup({required String body, required String type, String? title}) {
    Color color = type == kPopupFailed ? Colors.red.withValues(alpha: 0.8) : Colors.green.withValues(alpha: 0.8);

    if (Get.isOverlaysOpen) {
      return;
    }

    Get.snackbar(
      title ?? (type == kPopupFailed ? 'Failed' : 'Success'),
      body,
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      instantInit: false,
      margin: const EdgeInsets.only(bottom: kPadding20, left: kPadding20, right: kPadding20),
    );
  }
}
