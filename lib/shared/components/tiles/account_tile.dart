// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../themes/text_theme.dart';
import '../buttons/small_outlined_circular_button.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.placeHolderTextColor.withOpacity(0.25),
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bank Transfers',
            style: TextThemes(context).getTextStyle(
              color: AppColors.primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.faintPrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                Flexible(
                  child: Text(
                    '0424983913',
                    style: TextThemes(context).getTextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                Flexible(
                  child: SmallOutlinedCircularButton(
                    title: 'Copy',
                    onTaps: () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'The Force of Grace Ministry',
            style: TextThemes(context).getTextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'Zenith Bank',
            style: TextThemes(context).getTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.placeHolderTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
