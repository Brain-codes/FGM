// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:FGM/auth/controllers/auth_controller.dart';
import 'package:FGM/auth/ui/auth_footer.dart';
import 'package:FGM/auth/ui/auth_screens_header.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  bool _emailHasError = false;
  bool _passwordHasError = false;
  bool _isLoading = false;

  Future<void> _handleForgotPassword(BuildContext context) async {
    if (!_authController.resetEmailController.text.isValidEmail()) {
      setState(() {
        _emailHasError = true;
        _errorMessage = 'Enter Valid Email';
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _emailHasError = false;
        _passwordHasError = false;
      });
      _authController.resetPassword(context);
    }
  }

  void initState() {
    _authController.resetEmailController.addListener(() {
      _emailHasError = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          AuthScreensHeader(
                            heading: AppStrings.forgotPass,
                            description: AppStrings.forgotPassDesc,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          BaseTextField(
                            textInputType: TextInputType.emailAddress,
                            actionKeyboard: TextInputAction.next,
                            label: AppStrings.email,
                            controller: _authController.resetEmailController,
                            hasError: _emailHasError,
                            errorMessage: _emailHasError ? _errorMessage : '',
                            onTyping: (value) =>
                                _authController.resetEmail.value = value!,
                            enabled: !_authController.isLoading.value,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => _authController.isLoading.value
                                ? FilledLoadingButtonWidget()
                                : FilledButton(
                                    onTaps: () {
                                      _handleForgotPassword(context);
                                    },
                                    buttonTitle: AppStrings.reset,
                                  ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AuthFooter(
                    firstText: '',
                    secondText: AppStrings.back,
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const SignupScreen(),
                      //   ),
                      // );
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
    );
  }
}
