// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilledLoadingButtonWidget extends StatelessWidget {
  const FilledLoadingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      // width: size.width,
      // height: size.height * 0.06,
      padding: EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.50),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
          child: SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      )),
    );
  }
}
