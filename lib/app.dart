// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/screens/root.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/dismiss_keyboard.dart';
import 'package:movies/utils/utils.dart';
import 'package:movies/utils/wgt.dart';

enum Environment {
  development,
  production,
}

class App extends StatelessWidget {
  final Environment flavor;

  const App({
    super.key,
    required this.flavor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          MainApp(
            home: Root(),
          ),
          if (flavor == Environment.development)
            Positioned.fill(child: IgnorePointer(child: Wgt.devWatermark(context))),
        ],
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  final Widget home;

  const MainApp({
    super.key,
    required this.home,
  });

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        theme: ThemeData(
          primaryColor: kColorPrimaryBlue,
          scaffoldBackgroundColor: kColorSoftBlue,
          textTheme: GoogleFonts.poppinsTextTheme(
            const TextTheme(
              displayLarge: headline1,
              displayMedium: headline2,
              displaySmall: headline3,
              headlineMedium: headline4,
              headlineSmall: headline5,
              bodyLarge: bodyText1,
              bodyMedium: bodyText2,
              titleMedium: subtitle1,
              titleSmall: subtitle2,
              labelLarge: button,
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(0xFF00B9CC, Utils.getSwatch(kColorPrimaryBlue)),
            brightness: Brightness.dark,
          ).copyWith(surface: kColorSoftBlue),
        ),
        home: home,
        routes: {
          '/root': (context) => Root(),
        },
      ),
    );
  }
}
