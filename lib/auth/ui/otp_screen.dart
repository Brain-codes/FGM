// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:FGM/auth/controllers/auth_controller.dart';
import 'package:FGM/auth/ui/auth_screens_header.dart';
import 'package:FGM/shared/components/buttons/filled_button.dart';
import 'package:FGM/shared/components/buttons/filled_loading_button.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:FGM/shared/ui/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final AuthController _authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  Future<void> _handleOTP(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _authController.verifyOTP(context);
    }
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
                        heading: AppStrings.otpV,
                        description: AppStrings.otpDesc,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      OTPTextField(
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 60,
                        otpFieldStyle: OtpFieldStyle(
                          disabledBorderColor: AppColors.inActive,
                          enabledBorderColor: AppColors.inActive,
                          focusBorderColor: AppColors.primaryColor,
                          errorBorderColor: AppColors.red,
                        ),
                        outlineBorderRadius: 5,
                        keyboardType: TextInputType.number,
                        controller: _authController.otpFieldController,
                        style: TextThemes(context).getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryTextColor,
                        ),
                        textFieldAlignment: MainAxisAlignment.spaceBetween,
                        fieldStyle: FieldStyle.box,
                        onCompleted: (pin) {
                          print("Completed: " + pin);
                          _authController.resetOTP.value = pin;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => _authController.isLoading.value
                            ? FilledLoadingButtonWidget()
                            : _authController.resetOTP.toString().length < 4
                                ? FilledButton(
                                    onTaps: () {},
                                    buttonTitle: AppStrings.verify,
                                    colors: AppColors.primaryColor
                                        .withOpacity(0.50),
                                  )
                                : FilledButton(
                                    onTaps: () {
                                      _handleOTP(context);
                                    },
                                    buttonTitle: AppStrings.verify,
                                  ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
