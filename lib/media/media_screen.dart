// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:FGM/player/player_screen.dart';
import 'package:FGM/shared/components/searchbar/base_searchbar.dart';
import 'package:FGM/shared/components/tiles/messages_tile.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';

import '../shared/ui/appbar.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: BaseSearchField(
                    hintText: 'Search for message title',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Messages',
                  style: TextThemes(context).getTextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: ListView.builder(
                    itemCount: 10,
                    padding: EdgeInsets.only(
                      bottom: 20,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: MessagesTile(
                            image: AppIcons.splashOne,
                            message: 'Sure Mercies of David',
                            pastor: 'Pastor Chijioke Okonkwo',
                            date: 'Jan 1, 2023',
                            onTaps: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AudioScreen(),
                                ),
                              );
                            }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
