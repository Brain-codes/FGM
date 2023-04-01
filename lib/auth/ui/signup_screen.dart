// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:FGM/auth/ui/auth_footer.dart';
import 'package:FGM/auth/ui/auth_screens_header.dart';
import 'package:FGM/auth/ui/login_screen.dart';
import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/components/buttons/outlined_button.dart';
import 'package:FGM/shared/components/input/base_textfield.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginEmailController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  bool _emailHasError = false;
  bool _isLoading = false;

  void initState() {
    loginEmailController.addListener(() {
      _emailHasError = false;
    });

    loginEmailController.addListener(() {
      _emailHasError = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                AuthScreensHeader(
                  heading: AppStrings.welcome,
                  description: AppStrings.enter,
                ),
                SizedBox(
                  height: 40,
                ),
                BaseTextField(
                  textInputType: TextInputType.visiblePassword,
                  actionKeyboard: TextInputAction.done,
                  label: AppStrings.name,
                  controller: loginEmailController,
                  hasError: _emailHasError,
                  onTyping: (value) => loginEmailController.text = value!,
                  errorMessage: _emailHasError ? _errorMessage : '',
                ),
                SizedBox(
                  height: 20,
                ),
                BaseTextField(
                  textInputType: TextInputType.visiblePassword,
                  actionKeyboard: TextInputAction.done,
                  label: AppStrings.phone,
                  controller: loginEmailController,
                  hasError: _emailHasError,
                  onTyping: (value) => loginEmailController.text = value!,
                  errorMessage: _emailHasError ? _errorMessage : '',
                ),
                SizedBox(
                  height: 20,
                ),
                BaseTextField(
                  textInputType: TextInputType.visiblePassword,
                  actionKeyboard: TextInputAction.done,
                  label: AppStrings.email,
                  controller: loginEmailController,
                  hasError: _emailHasError,
                  onTyping: (value) => loginEmailController.text = value!,
                  errorMessage: _emailHasError ? _errorMessage : '',
                ),
                SizedBox(
                  height: 20,
                ),
                BaseTextField(
                  textInputType: TextInputType.visiblePassword,
                  actionKeyboard: TextInputAction.done,
                  label: AppStrings.password,
                  controller: loginEmailController,
                  hasError: _emailHasError,
                  onTyping: (value) => loginEmailController.text = value!,
                  errorMessage: _emailHasError ? _errorMessage : '',
                ),
                SizedBox(
                  height: 20,
                ),
                FilledButton(
                  onTaps: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  buttonTitle: AppStrings.create,
                ),
                SizedBox(
                  height: 15,
                ),
                OutlineButtonWidget(
                  onTaps: () {},
                  buttonTitle: AppStrings.continueWithAcc,
                ),
                SizedBox(
                  height: 70,
                ),
                AuthFooter(
                  firstText: AppStrings.alreadyHave,
                  secondText: AppStrings.logIn,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
