// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';

class HomeHeadingTile extends StatelessWidget {
  String title;
  void Function()? onTap;
  bool isEmpty;

  HomeHeadingTile(
      {super.key,
      required this.title,
      required this.onTap,
      required this.isEmpty});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextThemes(context).getTextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          child: isEmpty
              ? SizedBox()
              : GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'See all',
                    style: TextThemes(context).getTextStyle(),
                  ),
                ),
        ),
      ],
    );
  }
}
