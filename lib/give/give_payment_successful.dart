// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:FGM/navigation/base_bottom_navigation.dart';
import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({super.key});

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'images/card-payment.json',
                  reverse: true,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'PaymentSuccessful',
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
                  'Thank you for partnering with us. We appreciate your generosity and God bless you',
                  textAlign: TextAlign.center,
                  style: TextThemes(context).getTextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                FilledButton(
                  onTaps: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BaseBottomNavigation(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  buttonTitle: 'Proceed',
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
