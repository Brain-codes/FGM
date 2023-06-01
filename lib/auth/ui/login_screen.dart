// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:FGM/auth/controllers/auth_controller.dart';
import 'package:FGM/auth/ui/auth_footer.dart';
import 'package:FGM/auth/ui/auth_screens_header.dart';
import 'package:FGM/auth/ui/forgot_password_screen.dart';
import 'package:FGM/auth/ui/signup_screen.dart';
import 'package:FGM/navigation/base_bottom_navigation.dart';
import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/components/buttons/filled_loading_button.dart';
import 'package:FGM/shared/components/buttons/outlined_button.dart';
import 'package:FGM/shared/components/buttons/outlined_loading_button.dart';
import 'package:FGM/shared/components/input/base_textfield.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:FGM/shared/extensions/form_validator.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  bool _emailHasError = false;
  bool _passwordHasError = false;
  bool _isLoading = false;

  Future<void> _handleLogin(BuildContext context) async {
    if (!_authController.loginEmailController.text.isValidEmail()) {
      setState(() {
        _emailHasError = true;
        _errorMessage = 'Enter Valid Email';
      });
      return;
    }

    if (FormValidator.passwordRegex
            .hasMatch(_authController.loginPasswordController.text) ==
        false) {
      setState(() {
        _passwordHasError = true;
        _errorMessage = 'Enter Valid Password eg Sample@1234';
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _emailHasError = false;
        _passwordHasError = false;
      });
      _authController.login(context);
    }
  }

  void initState() {
    _authController.loginEmailController.addListener(() {
      _emailHasError = false;
    });

    _authController.loginPasswordController.addListener(() {
      _passwordHasError = true;
      _errorMessage = 'Enter Valid password';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                          textInputType: TextInputType.emailAddress,
                          actionKeyboard: TextInputAction.next,
                          label: AppStrings.email,
                          controller: _authController.loginEmailController,
                          hasError: _emailHasError,
                          errorMessage: _emailHasError ? _errorMessage : '',
                          onTyping: (value) =>
                              _authController.email.value = value!,
                          enabled: !_authController.isLoading.value,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BaseTextField(
                          textInputType: TextInputType.text,
                          actionKeyboard: TextInputAction.done,
                          label: AppStrings.password,
                          controller: _authController.loginPasswordController,
                          hasError: _passwordHasError,
                          onTyping: (value) =>
                              _authController.password.value = value!,
                          errorMessage: _passwordHasError ? _errorMessage : '',
                          enabled: !_authController.isLoading.value,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppStrings.forgotPass,
                                style: TextThemes(context).getTextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => _authController.isLoading.value
                              ? FilledLoadingButtonWidget()
                              : FilledButton(
                                  onTaps: () {
                                    _handleLogin(context);
                                  },
                                  buttonTitle: AppStrings.logIn,
                                ),
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Obx(
                        //   () => _authController.isLoading.value
                        //       ? OutlineButtonWidget(
                        //           onTaps: () {},
                        //           buttonTitle: AppStrings.continueWithAcc,
                        //         )
                        //       : OutlineButtonWidget(
                        //           onTaps: () {
                        //             Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                 builder: (context) =>
                        //                     const BaseBottomNavigation(),
                        //               ),
                        //             );
                        //           },
                        //           buttonTitle: AppStrings.continueWithAcc,
                        //         ),
                        // ),
                        SizedBox(
                          height: 120,
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
        ),
      ),
    );
  }
}
