// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields

import 'package:FGM/auth/controllers/auth_controller.dart';
import 'package:FGM/auth/ui/auth_footer.dart';
import 'package:FGM/auth/ui/auth_screens_header.dart';
import 'package:FGM/auth/ui/login_screen.dart';
import 'package:FGM/navigation/base_bottom_navigation.dart';
import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/components/buttons/filled_loading_button.dart';
import 'package:FGM/shared/components/buttons/outlined_button.dart';
import 'package:FGM/shared/components/input/base_textfield.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/extensions/form_validator.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  bool _nameHasError = false;
  bool _phoneHasError = false;
  bool _emailHasError = false;
  bool _passwordHasError = false;
  bool _isLoading = false;

  Future<void> _handelSignup(BuildContext context) async {
    if (!_authController.signupNameController.text.isValidFullName()) {
      setState(() {
        _nameHasError = true;
        _errorMessage = 'Enter Valid name';
      });
      return;
    }

    if (!_authController.signupPhoneController.text.isValidPhone()) {
      setState(() {
        _phoneHasError = true;
        _errorMessage = 'Enter Valid Phone';
      });
      return;
    }

    if (!_authController.signupEmailController.text.isValidEmail()) {
      setState(() {
        _emailHasError = true;
        _errorMessage = 'Enter Valid Email';
      });
      return;
    }

    if (_authController.signupPasswordController.text.isValidPassword() ==
        false) {
      setState(() {
        _passwordHasError = true;
        _errorMessage = 'Enter Valid Email eg Sample@1234';
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _nameHasError = false;
        _phoneHasError = false;
        _emailHasError = false;
        _passwordHasError = false;
      });
      _authController.register(context);
    }
  }

  void initState() {
    _authController.signupNameController.addListener(() {
      _nameHasError = false;
    });

    _authController.signupPhoneController.addListener(() {
      _phoneHasError = false;
    });
    _authController.signupEmailController.addListener(() {
      _emailHasError = false;
    });
    _authController.signupPasswordController.addListener(() {
      _passwordHasError = false;
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
                      hintText: 'John Doe',
                      textInputType: TextInputType.name,
                      actionKeyboard: TextInputAction.next,
                      label: AppStrings.name,
                      controller: _authController.signupNameController,
                      hasError: _nameHasError,
                      errorMessage: _nameHasError ? _errorMessage : '',
                      onTyping: (value) => _authController.name.value = value!,
                      enabled: !_authController.isLoading.value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BaseTextField(
                      hintText: '09012345678',
                      textInputType: TextInputType.phone,
                      actionKeyboard: TextInputAction.next,
                      label: AppStrings.phone,
                      controller: _authController.signupPhoneController,
                      hasError: _phoneHasError,
                      errorMessage: _phoneHasError ? _errorMessage : '',
                      onTyping: (value) => _authController.phone.value = value!,
                      enabled: !_authController.isLoading.value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BaseTextField(
                      hintText: 'example@mail.com',
                      textInputType: TextInputType.emailAddress,
                      actionKeyboard: TextInputAction.next,
                      label: AppStrings.email,
                      controller: _authController.signupEmailController,
                      hasError: _emailHasError,
                      errorMessage: _emailHasError ? _errorMessage : '',
                      onTyping: (value) =>
                          _authController.signupEmail.value = value!,
                      enabled: !_authController.isLoading.value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BaseTextField(
                      hintText: '********',
                      textInputType: TextInputType.visiblePassword,
                      actionKeyboard: TextInputAction.done,
                      label: AppStrings.password,
                      controller: _authController.signupPasswordController,
                      hasError: _passwordHasError,
                      errorMessage: _passwordHasError ? _errorMessage : '',
                      onTyping: (value) =>
                          _authController.signupPassword.value = value!,
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
                                _handelSignup(context);
                              },
                              buttonTitle: AppStrings.create,
                            ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
        ),
      ),
    );
  }
}
