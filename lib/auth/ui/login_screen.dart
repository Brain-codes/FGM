// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:FGM/auth/ui/auth_footer.dart';
import 'package:FGM/auth/ui/auth_screens_header.dart';
import 'package:FGM/auth/ui/signup_screen.dart';
import 'package:FGM/navigation/base_bottom_navigation.dart';
import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/components/buttons/outlined_button.dart';
import 'package:FGM/shared/components/input/base_textfield.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              children: [
                Column(
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppStrings.forgotPass,
                          style: TextThemes(context).getTextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
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
                      buttonTitle: AppStrings.logIn,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    OutlineButtonWidget(
                      onTaps: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BaseBottomNavigation(),
                          ),
                        );
                      },
                      buttonTitle: AppStrings.continueWithAcc,
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
                AuthFooter(
                  firstText: AppStrings.dontHave,
                  secondText: AppStrings.signUp,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
