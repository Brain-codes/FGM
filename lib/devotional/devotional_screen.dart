// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:FGM/devotional/devotional_details.dart';
import 'package:FGM/shared/components/tiles/devotion_tile.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:FGM/shared/ui/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DevotionalScreen extends StatefulWidget {
  const DevotionalScreen({super.key});

  @override
  State<DevotionalScreen> createState() => _DevotionalScreenState();
}

class _DevotionalScreenState extends State<DevotionalScreen> {
  bool _isDropdownOpen = false;
  String _selectedOption = 'January';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Devotional',
                    style: TextThemes(context).getTextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDropdownOpen = !_isDropdownOpen;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: _isDropdownOpen
                            ? AppColors.faintPrimaryColor
                            : AppColors.placeHolderTextColor.withOpacity(
                                0.2,
                              ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.filter,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            _selectedOption,
                            style: TextThemes(context).getTextStyle(),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset(
                            _isDropdownOpen
                                ? AppIcons.dropdown
                                : AppIcons.dropdown,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (_isDropdownOpen)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _isDropdownOpen ? null : 0,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: _isDropdownOpen ? 1 : 0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.faintPrimaryColor,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    _buildDropdownItem('January'),
                                    _buildDropdownItem('February'),
                                    _buildDropdownItem('March'),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
                      child: DevotionTile(
                        image: AppIcons.dummyImage,
                        title: 'Finding God’s joy in your life',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DevotionalDetails(),
                            ),
                          );
                        },
                        description:
                            'Lorem ipsum dolor sit amet consectetur. Lectus imperdiet a gravida turpis proin. turpis proin....',
                        date: 'Jan 1, 2023',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = option;
          _isDropdownOpen = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Text(option),
      ),
    );
  }
}
