import 'package:flutter/material.dart';

// Color
const kColorPrimaryBlue = Color(0xFF00B9CC);
const kColorWhite = Color(0xFFFFFFFF);
const kColorAccentYellow = Color(0xFFFFD700);
const kColorDarkTeal = Color(0xFF013A46);
const kColorCoolGray = Color(0xFFB0BEC5);
const kColorSoftBlue = Color(0xFFE0F7FA);
const kColorMintGreen = Color(0xFF00E5A0);

// Padding
const kPadding8 = 8.0;
const kPadding12 = 12.0;
const kPadding16 = 16.0;
const kPadding20 = 20.0;
const kPadding24 = 24.0;
const kPadding32 = 32.0;
const kPadding36 = 36.0;

const kSizeBottomBarHeight = 80.0;

// Styles
const headline1 = TextStyle(fontSize: 24, color: kColorDarkTeal);
const headline2 = TextStyle(fontSize: 18, color: kColorDarkTeal);
const headline3 = TextStyle(fontSize: 16, color: kColorDarkTeal);
const headline4 = TextStyle(fontSize: 14, color: kColorDarkTeal);
const headline5 = TextStyle(fontSize: 12, color: kColorDarkTeal);
const bodyText1 = TextStyle(fontSize: 14, color: kColorDarkTeal);
const bodyText2 = TextStyle(fontSize: 12, color: kColorDarkTeal);
const subtitle1 = TextStyle(fontSize: 10, color: kColorDarkTeal);
const subtitle2 = TextStyle(fontSize: 8, color: kColorDarkTeal);
const button = TextStyle(fontSize: 13.6, color: kColorDarkTeal);

//Images
const kImageDevFlag = 'assets/dev-flag.png';

const kPopupSuccess = 'success';
const kPopupFailed = 'failed';

// constants

const kSizeMinButtonWidth = 100.0;
const kSizeMinButtonHeight = 45.0;

const kSizeRadiusButton = 25.0;

const kIndexHome = 0;
const kIndexFavourite = 1;

const kSizeLoaderBoxWidth = 200.0;
const kSizeLoaderBoxHeight = 50.0;
const kSizeLoaderBoxRadius = 10.0;

//enums

enum ControllerState {
  firstLoad,
  loading,
  loadingSuccess,
  loadingFailed,
  reload,
}
