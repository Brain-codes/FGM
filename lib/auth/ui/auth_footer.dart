// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final String firstText;
  final String secondText;
  final void Function() onTap;
  AuthFooter(
      {required this.firstText, required this.secondText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: TextThemes(context).getTextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            secondText,
            style: TextThemes(context).getTextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
