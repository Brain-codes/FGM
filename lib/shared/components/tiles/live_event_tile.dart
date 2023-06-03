// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:FGM/shared/components/buttons/small_outlined_circular_button.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LiveEventTile extends StatelessWidget {
  String? image;
  void Function() onTaps;

  LiveEventTile({super.key, required this.image, required this.onTaps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        8,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.placeHolderTextColor.withOpacity(0.25),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              // Container(
              //   width: double.infinity,
              //   height: 104,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       fit: BoxFit.cover,
              //       image: AssetImage(image),
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
                  height: 104,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      AppIcons.errorImg,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 104,
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.recordDot,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: Text(
                          'Live',
                          style: TextThemes(context).getTextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              StreamButton(
                title: 'Stream Live',
                onTaps: () {},
              ),
              SizedBox(
                width: 20,
              ),
              AudioButton(
                title: 'Audio',
                onTaps: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StreamButton extends StatelessWidget {
  String title;
  Function() onTaps;
  double radius;
  StreamButton({
    super.key,
    required this.title,
    required this.onTaps,
    this.radius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaps,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.monitor,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 9,
            ),
            Text(
              title,
              style: TextThemes(context).getTextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AudioButton extends StatelessWidget {
  String title;
  double radius;
  Function() onTaps;

  AudioButton({
    super.key,
    required this.title,
    required this.onTaps,
    this.radius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaps,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          color: AppColors.faintPrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.headPhones,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 9,
            ),
            Text(
              title,
              style: TextThemes(context).getTextStyle(
                fontSize: 10,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
