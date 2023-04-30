// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:FGM/shared/components/buttons/small_filled_circular_button.dart';
import 'package:FGM/shared/components/buttons/small_outlined_circular_button.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';

class MessagesTile extends StatelessWidget {
  void Function() onTaps;
  void Function() onTapsDownload;
  String? image;
  String? pastor;
  String? message;
  String? date;
  double? progress;

  MessagesTile({
    super.key,
    required this.onTaps,
    required this.onTapsDownload,
    required this.image,
    required this.pastor,
    required this.message,
    required this.date,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 8,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.placeHolderTextColor.withOpacity(0.25),
            width: 1.5,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  child: Image.network(
                    '$image',
                    fit: BoxFit.cover,
                    width: 56,
                    height: 56,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        AppIcons.appLogo,
                        fit: BoxFit.cover,
                        width: 56,
                        height: 56,
                      );
                    },
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$message',
                          overflow: TextOverflow.ellipsis,
                          style: TextThemes(context).getTextStyle(
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '$pastor',
                          overflow: TextOverflow.ellipsis,
                          style: TextThemes(context).getTextStyle(
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          '$date',
                          overflow: TextOverflow.ellipsis,
                          style: TextThemes(context).getTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: progress != null
                ? ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(200),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 147, 76),
                        borderRadius: BorderRadius.all(
                          Radius.circular(300),
                        ),
                      ),
                      child: Text(
                        '${progress?.round()}%',
                        style: TextThemes(context).getTextStyle(
                          fontSize: 8,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SmallFilledCircularButton(
                        title: 'Play',
                        onTaps: onTaps,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SmallOutlinedCircularButton(
                        title: 'Download',
                        onTaps: onTapsDownload,
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
