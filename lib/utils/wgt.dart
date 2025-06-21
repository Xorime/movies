import 'package:flutter/material.dart';
import 'package:movies/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class Wgt {
  static AppBar appbar({
    required String title,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    Widget? leading,
    TextStyle? titleStyle,
    bool centerTitle = true,
  }) {
    return AppBar(
      title: Text(
        '$title',
        style: titleStyle ?? headline2,
      ),
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      bottom: bottom,
      leading: leading != null ? leading : null,
      forceMaterialTransparency: true,
    );
  }

  static Widget loaderController({Color color = kColorPrimaryBlue, double weight = 3}) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(kPadding8),
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: weight,
        ),
      ),
    );
  }

  static Widget loaderBox({
    double width = kSizeLoaderBoxWidth,
    double height = kSizeLoaderBoxHeight,
    double borderRadius = kSizeLoaderBoxRadius,
    bool square = false,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Shimmer.fromColors(
        baseColor: kColorCoolGray.withValues(alpha: 0.7),
        highlightColor: kColorCoolGray.withValues(alpha: 0.3),
        child: square
            ? AspectRatio(
                aspectRatio: 1,
                child: SizedBox(
                    width: width,
                    height: height,
                    child: Container(
                      color: kColorCoolGray,
                    )))
            : SizedBox(
                width: width,
                height: height,
                child: Container(
                  color: kColorCoolGray,
                )),
      ),
    );
  }

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
