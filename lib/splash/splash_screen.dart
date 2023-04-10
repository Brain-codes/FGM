// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:FGM/navigation/base_bottom_navigation.dart';
import 'package:FGM/onboarding/onboarding_container.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/services/local_database_services.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/constants/app_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _user = LocalDatabaseService().getData(DbKeyStrings.loginToken);

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(0, 14, 124, 188),
        systemNavigationBarColor: Color.fromARGB(255, 255, 255, 255),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    Timer _timer = Timer(
      Duration(seconds: 4),
      () => _user == null
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OnboardingScreen(),
              ),
            )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BaseBottomNavigation(),
              ),
            ),
    );

    Timer timer = Timer(Duration(seconds: 6), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(0, 14, 124, 188),
          systemNavigationBarColor: Color.fromARGB(255, 0, 0, 0),
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    });

    Future.delayed(Duration(seconds: 6), () {
      timer.cancel();
    });
    super.initState();

    print(_user);
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                AppIcons.appLogo,
                fit: BoxFit.cover,
                width: 136,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Text(
                  'The Force of Grace Ministry',
                  textAlign: TextAlign.center,
                  style: TextThemes(context).getTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
