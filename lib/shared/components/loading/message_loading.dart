// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MessageLoader extends StatelessWidget {
  const MessageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.secondaryTextColor.withOpacity(0.25),
      highlightColor: Colors.white,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.secondaryTextColor,
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 8,
                    width: MediaQuery.of(context).size.width / 4.5,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryTextColor,
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 8,
                    width: MediaQuery.of(context).size.width / 3.5,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryTextColor,
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 8,
                    width: MediaQuery.of(context).size.width / 6.5,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryTextColor,
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            height: 22,
            width: MediaQuery.of(context).size.width / 7.5,
            decoration: BoxDecoration(
              color: AppColors.secondaryTextColor,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
