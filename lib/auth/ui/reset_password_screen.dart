// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:FGM/auth/controllers/auth_controller.dart';
import 'package:FGM/auth/ui/auth_screens_header.dart';
import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/components/buttons/filled_loading_button.dart';
import 'package:FGM/shared/components/input/base_textfield.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/extensions/form_validator.dart';
import 'package:FGM/shared/ui/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final AuthController _authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();
  bool _newPasswordHasError = false;
  bool _confirmPasswordHasError = false;
  String _errorMessage = '';

  Future<void> _handleOTP(BuildContext context) async {
    if (FormValidator.passwordRegex
            .hasMatch(_authController.newPasswordController.text) ==
        false) {
      setState(() {
        _newPasswordHasError = true;
        _errorMessage = 'Enter Valid Password eg Sample@1234';
      });
      return;
    }

    if (_authController.newPasswordText.value !=
        _authController.newPasswordConfirmText.value) {
      setState(() {
        _confirmPasswordHasError = true;
        _errorMessage = 'Password does not match';
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      _authController.newPassword(context);
    }
  }

  @override
  void initState() {
    _authController.newPasswordController.addListener(() {
      _newPasswordHasError = false;
    });
    _authController.newPasswordConfirmController.addListener(() {
      _confirmPasswordHasError = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SafeArea(
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
                        heading: AppStrings.changePassword,
                        description: AppStrings.changePasswordDesc,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      BaseTextField(
                        textInputType: TextInputType.text,
                        actionKeyboard: TextInputAction.done,
                        label: AppStrings.newPassword,
                        controller: _authController.newPasswordController,
                        hasError: _newPasswordHasError,
                        onTyping: (value) =>
                            _authController.newPasswordText.value = value!,
                        errorMessage: _newPasswordHasError ? _errorMessage : '',
                        enabled: !_authController.isLoading.value,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BaseTextField(
                        textInputType: TextInputType.text,
                        actionKeyboard: TextInputAction.done,
                        label: AppStrings.confirmPassword,
                        controller:
                            _authController.newPasswordConfirmController,
                        hasError: _confirmPasswordHasError,
                        onTyping: (value) => _authController
                            .newPasswordConfirmText.value = value!,
                        errorMessage:
                            _confirmPasswordHasError ? _errorMessage : '',
                        enabled: !_authController.isLoading.value,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Obx(
                        () => _authController.isLoading.value
                            ? FilledLoadingButtonWidget()
                            : FilledButton(
                                onTaps: () {
                                  _handleOTP(context);
                                },
                                buttonTitle: AppStrings.changePassword,
                              ),
                      ),
                    ],
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
