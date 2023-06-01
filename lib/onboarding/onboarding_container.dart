// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:FGM/auth/ui/login_screen.dart';
import 'package:FGM/auth/ui/signup_screen.dart';
import 'package:FGM/onboarding/board_one.dart';
import 'package:FGM/onboarding/onboard_three.dart';
import 'package:FGM/onboarding/onboard_two.dart';
import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/components/buttons/outlined_button.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // PAGE VIEW
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    onLastPage = (index == 2);
                  });
                },
                children: [
                  FirstOnboardScreen(),
                  SecondOnboardScreen(),
                  ThirdOnboardScreen(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColors.activeDots,
                dotColor: AppColors.inActive,
                dotWidth: 5.0,
                dotHeight: 5.0,
                spacing: 5.0,
                expansionFactor: 7,
              ),
            ),
            SizedBox(
              height: 30,
            ),

            //SPLASH FOOTER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.churchFullName,
                    textAlign: TextAlign.center,
                    style: TextThemes(context).getTextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppStrings.splashDescription,
                    textAlign: TextAlign.center,
                    style: TextThemes(context).getTextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FilledButton(
                    onTaps: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    buttonTitle: AppStrings.createAccount,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  OutlineButtonWidget(
                    onTaps: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    buttonTitle: AppStrings.logIn,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
