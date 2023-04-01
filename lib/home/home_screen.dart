// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:FGM/devotional/devotional_screen.dart';
import 'package:FGM/shared/components/tiles/devotion_tile.dart';
import 'package:FGM/shared/components/tiles/home_heading_tile.dart';
import 'package:FGM/shared/components/tiles/messages_tile.dart';
import 'package:FGM/shared/components/tiles/word_tiles.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Hello Tayo',
                  style: TextThemes(context).getTextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                //WORD FRO THE WEEK
                Text(
                  'Word for the week',
                  style: TextThemes(context).getTextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                // WORD FOR THE WEEK CONTAINER
                WordTile(
                  image: AppIcons.dummyImage,
                  title:
                      'Finally, be strong in the Lord and in His mighty power” (Eph 6:10)"',
                  onTap: () {},
                ),

                SizedBox(
                  height: 30,
                ),

                //DEVOTION HEADER
                HomeHeadingTile(
                  title: 'Devotional',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DevotionalScreen(),
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: 20,
                ),

                //DEVOTIONAL HEADER

                DevotionTile(
                  image: AppIcons.dummyImage,
                  title: 'Finding God’s joy in your life',
                  onTap: () {},
                  description:
                      'Lorem ipsum dolor sit amet consectetur. Lectus imperdiet a gravida turpis proin. turpis proin....',
                  date: 'Jan 19, 2023',
                ),

                SizedBox(
                  height: 30,
                ),

                //DEVOTION HEADER
                HomeHeadingTile(
                  title: 'Messages',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DevotionalScreen(),
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: 20,
                ),

                MessagesTile(
                  image: AppIcons.splashOne,
                  message: 'Sure Mercies of David',
                  pastor: 'Pastor Chijioke Okonkwo',
                  date: 'Jan 1, 2023',
                  onTaps: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                MessagesTile(
                  image: AppIcons.splashOne,
                  message: 'Sure Mercies of David',
                  pastor: 'Pastor Chijioke Okonkwo',
                  date: 'Jan 1, 2023',
                  onTaps: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                MessagesTile(
                  image: AppIcons.splashOne,
                  message: 'Sure Mercies of David',
                  pastor: 'Pastor Chijioke Okonkwo',
                  date: 'Jan 1, 2023',
                  onTaps: () {},
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
