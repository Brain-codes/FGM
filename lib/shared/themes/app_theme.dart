import 'package:FGM/shared/constants/app_color.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    splashColor: AppColors.primaryColor,
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: AppColors.primaryTextColor,
      selectionColor: AppColors.secondaryTextColor,
    ),
    backgroundColor: AppColors.backgroundColor,
    iconTheme: const IconThemeData(color: AppColors.primaryTextColor),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,

      secondary: AppColors
          .secondaryColor, // on light theme surface = Colors.white by default
    ).copyWith(
      secondary: AppColors.secondaryColor,
    ),
  );
}
