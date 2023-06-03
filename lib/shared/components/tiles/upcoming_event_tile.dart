// ignore_for_file: prefer_const_constructors

import 'package:FGM/event/controller/event_controller.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';

class UpcomingEventTile extends StatelessWidget {
  String? date;
  String? image;
  UpcomingEventTile({
    super.key,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final EventController _EventController = Get.put(EventController());

    return Stack(
      children: <Widget>[
        // Container(
        //   width: double.infinity,
        //   height: 132,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       fit: BoxFit.cover,
        //       image: NetworkImage('$image'),
        //     ),
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        // ),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            '$image',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 132,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Image.asset(
                AppIcons.errorImg,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 132,
              );
            },
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Text(
              _EventController.formatDate(DateTime.parse('$date')),
              style: TextThemes(context).getTextStyle(
                color: AppColors.primaryTextColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
