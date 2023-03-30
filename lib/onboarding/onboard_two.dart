// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_icon.dart';
import 'package:flutter/material.dart';

class SecondOnboardScreen extends StatefulWidget {
  const SecondOnboardScreen({super.key});

  @override
  State<SecondOnboardScreen> createState() => _SecondOnboardScreenState();
}

class _SecondOnboardScreenState extends State<SecondOnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        AppIcons.splashTwo,
        fit: BoxFit.cover,
      ),
    );
  }
}
