// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/components/buttons/outlined_button.dart';
import 'package:FGM/shared/components/input/feedback_textfield.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:FGM/shared/ui/appbar.dart';
import 'package:flutter/material.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Feedback',
                style: TextThemes(context).getTextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FeedBackTextField(
                textInputType: TextInputType.text,
                actionKeyboard: TextInputAction.done,
                label: AppStrings.password,
                hintText: 'Name',
                // controller: _authController.loginPasswordController,
                // hasError: _passwordHasError,
                // onTyping: (value) => _authController.password.value = value!,
                errorMessage: false ? ' ' : '',
                // enabled: !_authController.isLoading.value,
              ),
              SizedBox(
                height: 20,
              ),
              FeedBackTextField(
                textInputType: TextInputType.text,
                actionKeyboard: TextInputAction.done,
                label: AppStrings.password,
                hintText: 'Phone Number',
                // controller: _authController.loginPasswordController,
                // hasError: _passwordHasError,
                // onTyping: (value) => _authController.password.value = value!,
                errorMessage: false ? ' ' : '',
                // enabled: !_authController.isLoading.value,
              ),
              SizedBox(
                height: 20,
              ),
              FeedBackTextField(
                textInputType: TextInputType.text,
                actionKeyboard: TextInputAction.done,
                label: AppStrings.password,
                hintText: 'Comment',
                numberOfLines: 5,
                // controller: _authController.loginPasswordController,
                // hasError: _passwordHasError,
                // onTyping: (value) => _authController.password.value = value!,
                errorMessage: false ? ' ' : '',
                // enabled: !_authController.isLoading.value,
              ),
              SizedBox(
                height: 50,
              ),
              FilledButton(
                onTaps: () {},
                buttonTitle: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
