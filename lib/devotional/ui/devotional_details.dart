// ignore_for_file: prefer_const_constructors

import 'package:FGM/devotional/model/all_devotional_model.dart';
import 'package:FGM/home/model/all_wotw_model.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:FGM/shared/ui/appbar.dart';
import 'package:flutter/material.dart';

class DevotionalDetails extends StatelessWidget {
  AllDevotionalModel? devotionalDetails;
  String type;
  AllWotwModel? wotwDetails;
  DevotionalDetails({
    super.key,
    this.devotionalDetails,
    this.type = 'devotional',
    this.wotwDetails,
  });

  @override
  Widget build(BuildContext context) {
    return type == 'devotional'
        ? Scaffold(
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
                    Image.network(
                      '${devotionalDetails!.image?.secureUrl}',
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          AppIcons.errorImg,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 120,
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      devotionalDetails!.date,
                      style: TextThemes(context).getTextStyle(
                        color: AppColors.placeHolderTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      devotionalDetails!.title,
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
                      devotionalDetails!.content,
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
          )
        : Scaffold(
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
                    Image.network(
                      '${wotwDetails!.image?.secureUrl}',
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // Text(
                    //   wotwDetails!.date,
                    //   style: TextThemes(context).getTextStyle(
                    //     color: AppColors.placeHolderTextColor,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //   wotwDetails!.title,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextThemes(context).getTextStyle(
                    //     color: AppColors.primaryTextColor,
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 15,
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${wotwDetails!.content}',
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
