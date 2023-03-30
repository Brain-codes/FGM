// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    required this.onTaps,
    required this.buttonTitle,
    this.colors = AppColors.primaryColor,
    this.icon = '',
  });

  final VoidCallback? onTaps;
  final String buttonTitle;
  final Color? colors;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTaps,
      child: Container(
        // width: size.width,
        // height: size.height * 0.06,
        padding: EdgeInsets.symmetric(
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            buttonTitle,
            style: TextThemes(context).getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
