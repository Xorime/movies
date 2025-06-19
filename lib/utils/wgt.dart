import 'package:flutter/material.dart';
import 'package:movies/utils/constants.dart';

class Wgt {
  static SizedBox devWatermark(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        kImageDevFlag,
        fit: BoxFit.cover,
        color: Colors.white.withValues(alpha: 0.6),
        colorBlendMode: BlendMode.modulate,
      ),
    );
  }
}
