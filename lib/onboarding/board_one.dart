// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_icon.dart';
import 'package:flutter/material.dart';

class FirstOnboardScreen extends StatefulWidget {
  const FirstOnboardScreen({super.key});

  @override
  State<FirstOnboardScreen> createState() => _FirstOnboardScreenState();
}

class _FirstOnboardScreenState extends State<FirstOnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        AppIcons.splashOne,
        fit: BoxFit.cover,
      ),
    );
  }
}
