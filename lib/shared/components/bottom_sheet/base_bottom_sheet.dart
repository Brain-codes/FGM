// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:FGM/shared/constants/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseBottomSheet extends StatelessWidget {
  final List<Widget> items;
  BaseBottomSheet({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 20,
              child: SvgPicture.asset(
                AppIcons.topDash,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
