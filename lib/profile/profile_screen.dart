// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:FGM/shared/components/tiles/profile_tile.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Profile',
                  style: TextThemes(context).getTextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ProfileTiles(
                  buttonValue: 'Feedback',
                  iconValue: AppIcons.feedback,
                  descripionValue: 'We’ll be glad to hear from you',
                ),
                 InkWell(
                  onTap: () {
                    // _logout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 18.0,
                      bottom: 18,
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcons.logout),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          AppStrings.logout,
                          style: FormTextThemes(context).getFormTextStyle(
                            color: AppColors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
