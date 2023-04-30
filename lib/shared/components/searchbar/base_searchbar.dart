// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseSearchField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool enabled;
  final Function(String? value)? onTyping;

  const BaseSearchField({
    super.key,
    this.hintText,
    this.onTyping,
    this.controller,
    this.enabled = true,
  });

  @override
  State<BaseSearchField> createState() => _BaseSearchFieldState();
}

class _BaseSearchFieldState extends State<BaseSearchField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextThemes(context).getTextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      onChanged: (val) => widget.onTyping!(val),
      controller: widget.controller,
      enabled: widget.enabled,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        hintText: widget.hintText,
        hintStyle: TextThemes(context).getTextStyle(
          color: AppColors.placeHolderTextColor,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffE0E0E0),
          ),
          gapPadding: 2,
          borderRadius: BorderRadius.circular(5),
        ),
        alignLabelWithHint: true,
        prefixIcon: Padding(
          padding: EdgeInsets.all(0),
          child: SvgPicture.asset(
            AppIcons.searchIcon,
            fit: BoxFit.scaleDown,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffE0E0E0),
          ),
          gapPadding: 2,
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        // border: InputBorder.none,
      ),
    );
  }
}
