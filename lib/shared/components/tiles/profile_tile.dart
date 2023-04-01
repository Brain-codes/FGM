// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileTiles extends StatelessWidget {
  String buttonValue;

  String iconValue;

  String descripionValue;

  ProfileTiles(
      {super.key,
      required this.buttonValue,
      required this.iconValue,
      required this.descripionValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.placeHolderTextColor.withOpacity(0.25),
            width: 1.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
          bottom: 15,
          left: 10,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  iconValue,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buttonValue,
                      style: TextThemes(context).getTextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      descripionValue,
                      style: TextThemes(context).getTextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SvgPicture.asset(
              AppIcons.chevronRight,
              color: AppColors.secondaryTextColor,
            )
          ],
        ),
      ),
    );
  }
}
