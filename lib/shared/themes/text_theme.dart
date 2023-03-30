import 'package:FGM/shared/constants/app_color.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class TextThemes {
  TextStyle getTextStyle(
      {double fontSize = 12,
      Color color = AppColors.secondaryTextColor,
      FontWeight fontWeight = FontWeight.w400,
      TextDecoration? decoration,
      double? height,
      double? letterSpacing}) {
    return GoogleFonts.outfit(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
        height: height,
        letterSpacing: letterSpacing);
  }

  TextThemes(BuildContext context);
}

class FormTextThemes {
  TextStyle getFormTextStyle({
    double fontSize = 12,
    Color color = const Color(0xFF161616),
    FontWeight fontWeight = FontWeight.normal,
    TextDecoration? decoration,
    double? height,
  }) {
    return GoogleFonts.outfit(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
        height: height);
  }

  FormTextThemes(BuildContext context);
}
