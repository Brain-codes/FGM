// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';

class AuthScreensHeader extends StatelessWidget {
  String heading;
  String description;
  bool showLogo;
  AuthScreensHeader({
    super.key,
    required this.heading,
    required this.description,
    this.showLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: showLogo
              ? Column(
                  children: [
                    Image.asset(
                      AppIcons.appLogo,
                      fit: BoxFit.cover,
                      width: 71,
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                )
              : SizedBox(),
        ),
        Text(
          heading,
          style: TextThemes(context).getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryTextColor,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          description,
          style: TextThemes(context).getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}
