import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_colors.dart';

class ThemeManager {
  final darkTheme = ThemeData(
    platform: TargetPlatform.iOS,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
    textTheme: TextTheme(
      displayMedium: TextStyle(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.dark(
      background: Colors.blue,
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    primaryColor: AppColors.primary,
    cupertinoOverrideTheme:
        const NoDefaultCupertinoThemeData(brightness: Brightness.dark),
  );

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    platform: TargetPlatform.iOS,
    scaffoldBackgroundColor: Colors.white,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
    colorScheme: ColorScheme.light(
      background: Colors.green,
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    textTheme: TextTheme(
      displayMedium: TextStyle(
        color: Colors.black,
      ),
    ),
    primaryColor: AppColors.primary,
  );
}
