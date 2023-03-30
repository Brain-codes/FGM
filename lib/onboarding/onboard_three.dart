// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_icon.dart';
import 'package:flutter/material.dart';

class ThirdOnboardScreen extends StatefulWidget {
  const ThirdOnboardScreen({super.key});

  @override
  State<ThirdOnboardScreen> createState() => _ThirdOnboardScreenState();
}

class _ThirdOnboardScreenState extends State<ThirdOnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        AppIcons.splashThree,
        fit: BoxFit.cover,
      ),
    );
  }
}
