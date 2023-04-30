// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';

class WordTile extends StatelessWidget {
  String? image;
  String? title;
  void Function()? onTap;
  WordTile({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                '$image',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 72,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    AppIcons.errorImg,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 72,
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '$title',
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextThemes(context).getTextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
