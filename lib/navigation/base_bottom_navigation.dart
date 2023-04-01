// ignore_for_file: prefer_const_constructors

import 'package:FGM/event/event_screen.dart';
import 'package:FGM/give/give_screen.dart';
import 'package:FGM/home/home_screen.dart';
import 'package:FGM/media/media_screen.dart';
import 'package:FGM/profile/profile_screen.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseBottomNavigation extends StatefulWidget {
  const BaseBottomNavigation({super.key});

  @override
  State<BaseBottomNavigation> createState() => _BaseBottomNavigationState();
}

class _BaseBottomNavigationState extends State<BaseBottomNavigation> {
  int? active = 0;

  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    EventScreen(),
    GiveScreen(),
    MediaScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.primaryTextColor.withOpacity(0.3),
        selectedLabelStyle: TextThemes(context).getTextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextThemes(context).getTextStyle(
          color: AppColors.primaryTextColor.withOpacity(0.3),
          fontWeight: FontWeight.w500,
        ),
        items: [
          _bottomNavItem(
            AppIcons.navHome,
            AppStrings.navHome,
            _selectedIndex,
            0,
          ),
          _bottomNavItem(
            AppIcons.navEvent,
            AppStrings.navEvent,
            _selectedIndex,
            1,
          ),
          _bottomNavItem(
            AppIcons.navGive,
            AppStrings.navGive,
            _selectedIndex,
            2,
          ),
          _bottomNavItem(
            AppIcons.navMedia,
            AppStrings.navMedia,
            _selectedIndex,
            3,
          ),
          _bottomNavItem(
            AppIcons.navProfile,
            AppStrings.navProfile,
            _selectedIndex,
            4,
          ),
        ],
      ),
    );
  }
}

BottomNavigationBarItem _bottomNavItem(
  String imagePath,
  String label,
  int selectedIndex,
  int navIndex,
) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(
      imagePath,
      color: selectedIndex == navIndex
          ? AppColors.primaryColor
          : AppColors.primaryTextColor.withOpacity(0.3),
    ),
    label: label,
  );
}
