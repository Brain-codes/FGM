// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_color.dart';
import 'package:flutter/material.dart';
import '../../themes/text_theme.dart';

class OutlineLoadingButtonWidget extends StatelessWidget {
  const OutlineLoadingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1.5,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
