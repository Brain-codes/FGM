// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SmallDetailsEventTile extends StatelessWidget {
  String? title;
  String? value;
  String? icon;
  SmallDetailsEventTile(
      {super.key,
      required this.title,
      required this.value,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('$icon'),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title',
              style: TextThemes(context).getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryTextColor,
              ),
            ),
            Text(
              '$value',
              overflow: TextOverflow.ellipsis,
              style: TextThemes(context).getTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColors.placeHolderTextColor,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class LocationSmallDetailsEventTile extends StatelessWidget {
  String? title;
  String? value;
  String? icon;
  LocationSmallDetailsEventTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: SvgPicture.asset('$icon'),
        ),
        Flexible(
          flex: 0,
          child: SizedBox(
            width: 10,
          ),
        ),
        Flexible(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title',
                style: TextThemes(context).getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryTextColor,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '$value',
                overflow: TextOverflow.visible,
                style: TextThemes(context).getTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.placeHolderTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
