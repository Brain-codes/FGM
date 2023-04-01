// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';

class SmallOutlinedCircularButton extends StatelessWidget {
  String title;
  void Function() onTaps;

  SmallOutlinedCircularButton({
    super.key,
    required this.title,
    required this.onTaps,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaps,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 11,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
            strokeAlign: StrokeAlign.inside,
          ),
        ),
        child: Text(
          title,
          style: TextThemes(context)
              .getTextStyle(fontSize: 10, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
