// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:FGM/shared/ui/appbar.dart';
import 'package:flutter/material.dart';

class DevotionalDetails extends StatelessWidget {
  const DevotionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Devotional',
                style: TextThemes(context).getTextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Image.asset(
                AppIcons.dummyImage,
                width: double.infinity,
                height: 72,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Jan 1, 2023',
                style: TextThemes(context).getTextStyle(
                  color: AppColors.placeHolderTextColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Finding God’s joy in your life',
                overflow: TextOverflow.ellipsis,
                style: TextThemes(context).getTextStyle(
                  color: AppColors.primaryTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppStrings.dummyText,
                style: TextThemes(context).getTextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
