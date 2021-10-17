import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'font_family.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData themeData = ThemeData(
    fontFamily: FontFamily.oswald,
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    brightness: Brightness.light,
    primarySwatch: AppColors.primary,
    primaryColor: AppColors.primary[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.primary[500],
    accentColorBrightness: Brightness.light,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData themeDataDark = themeData.copyWith(
    brightness: Brightness.dark,
    primaryColorBrightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
  );
}
