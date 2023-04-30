// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_init_to_null

import 'package:FGM/devotional/controller/devotional_controller.dart';
import 'package:FGM/devotional/model/all_devotional_model.dart';
import 'package:FGM/devotional/ui/devotional_details.dart';
import 'package:FGM/shared/components/loading/devotional_loading.dart';
import 'package:FGM/shared/components/loading/message_loading.dart';
import 'package:FGM/shared/components/loading/word_loading.dart';
import 'package:FGM/shared/components/tiles/devotion_tile.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:FGM/shared/ui/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class DevotionalScreen extends StatefulWidget {
  List<AllDevotionalModel>? devotionaItem;

  DevotionalScreen({super.key, this.devotionaItem = null});

  @override
  State<DevotionalScreen> createState() => _DevotionalScreenState();
}

class _DevotionalScreenState extends State<DevotionalScreen> {
  final DevotionalController _DevotionalController =
      Get.put(DevotionalController());
  List<AllDevotionalModel>? _devotionaItem;

  bool _isDropdownOpen = false;
  String _selectedOption = 'January';

  getAllDevotion() async {
    if (widget.devotionaItem == null) {
      await _DevotionalController.getAllDevotional(context);
      setState(() {
        _devotionaItem = _DevotionalController.devotionaItem;
      });
    } else {
      setState(() {
        widget.devotionaItem = _devotionaItem;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.devotionaItem?[0].content);
    getAllDevotion();
  }

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
              Obx(
                () => _DevotionalController.isLoading.value
                    ? SizedBox(
                        child: ListView.builder(
                          itemCount: 4,
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
                              child: DevotionalLoader(),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        child: ListView.builder(
                          itemCount: _devotionaItem?.length,
                          padding: EdgeInsets.only(bottom: 20),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final reversedIndex = _devotionaItem?.length != null
                                ? _devotionaItem!.length - 1 - index
                                : 0;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: DevotionTile(
                                image: _devotionaItem?[reversedIndex].image?.secureUrl,
                                title:
                                    '${_devotionaItem?[reversedIndex].title}',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DevotionalDetails(
                                            devotionalDetails: _devotionaItem![reversedIndex],
                                          ),
                                    ),
                                  );
                                },
                                description:
                                    _devotionaItem?[reversedIndex].content,
                                date: _devotionaItem?[reversedIndex].date,
                              ),
                            );
                          },
                        ),
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
