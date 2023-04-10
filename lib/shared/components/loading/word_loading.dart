// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WordLoader extends StatelessWidget {
  const WordLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.secondaryTextColor.withOpacity(0.25),
      highlightColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 8,
            width: MediaQuery.of(context).size.width / 5.5,
            decoration: BoxDecoration(
              color: AppColors.secondaryTextColor,
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 8,
            width: MediaQuery.of(context).size.width / 1,
            decoration: BoxDecoration(
              color: AppColors.secondaryTextColor,
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 8,
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
              color: AppColors.secondaryTextColor,
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
