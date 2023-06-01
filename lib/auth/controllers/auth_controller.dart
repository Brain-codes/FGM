// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, avoid_print, prefer_const_constructors

import 'package:FGM/auth/model/login_model.dart';
import 'package:FGM/auth/model/signup_model.dart';
import 'package:FGM/auth/services/auth_service.dart';
import 'package:FGM/auth/ui/login_screen.dart';
import 'package:FGM/auth/ui/otp_screen.dart';
import 'package:FGM/auth/ui/reset_password_screen.dart';
import 'package:FGM/navigation/base_bottom_navigation.dart';
import 'package:FGM/shared/components/snackbar/snack_bar.dart';
import 'package:FGM/shared/services/api_service.dart';
import 'package:FGM/shared/services/local_database_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:page_transition/page_transition.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService(ApiService());
  final isLoading = false.obs;

  //LOGIN CREDENTIALS
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  final email = ''.obs;
  final password = ''.obs;
  //END

  //RESET CREDENTIALS
  TextEditingController resetEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmController = TextEditingController();
  OtpFieldController otpFieldController = OtpFieldController();
  final resetEmail = ''.obs;
  final resetOTP = ''.obs;
  final newPasswordText = ''.obs;
  final newPasswordConfirmText = ''.obs;

  //END

  //SIGNUP CREDENTIALS
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  final name = ''.obs;
  final phone = ''.obs;
  final signupEmail = ''.obs;
  final signupPassword = ''.obs;

  Future<void> login(BuildContext context) async {
    isLoading.value = true;
    final response = await _authService.login(
        email.value.toLowerCase().trim(), password.value.trim());
    if (response.success == true) {
      var result = LoginModel.fromJson(response.data);
      LocalDatabaseService().add(DbKeyStrings.loginToken, result.token);
      LocalDatabaseService()
          .add(DbKeyStrings.userDetailsKey, response.data['user']);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const BaseBottomNavigation(),
        ),
        (Route<dynamic> route) => false,
      );
      successSnackBar('Login Successful', response.message);
    } else {
      errorSnackBar('Login Failed', response.message);
      isLoading.value = false;
      print(isLoading.value);
    }
    isLoading.value = false;
  }

  Future<void> resetPassword(BuildContext context) async {
    isLoading.value = true;
    final response = await _authService.resetPassword(
      resetEmail.value.toLowerCase().trim(),
    );
    if (response.success == true) {
      isLoading.value = false;
      LocalDatabaseService().add(DbKeyStrings.emailKey, resetEmail.value);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: OTPScreen(),
        ),
      );
      successSnackBar('OTP Sent', response.message);
    } else {
      errorSnackBar('Oops!', response.message);
      isLoading.value = false;
      print(isLoading.value);
    }
    isLoading.value = false;
  }

  Future<void> verifyOTP(BuildContext context) async {
    isLoading.value = true;
    final response = await _authService.verifyOTP(
      LocalDatabaseService().getData(DbKeyStrings.emailKey),
      resetOTP.value.trim(),
    );
    if (response.success == true) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: ResetPasswordScreen(),
        ),
      );
      successSnackBar('OTP Verified', response.message);
    } else {
      errorSnackBar('OTP Verification Failed', response.message);
      isLoading.value = false;
      print(isLoading.value);
    }
    isLoading.value = false;
  }

  Future<void> newPassword(BuildContext context) async {
    isLoading.value = true;
    final response = await _authService.newPassword(
      LocalDatabaseService().getData(DbKeyStrings.emailKey),
      newPasswordText.value.trim(),
      resetOTP.value.trim(),
    );
    if (response.success == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: ModalRoute.of(context)!.animation!,
              curve: Curves.fastOutSlowIn,
            )),
            child: LoginScreen(),
          ),
        ),
        (Route<dynamic> route) => false,
      );
      // Navigator.push(
      //   context,
      //   PageTransition(
      //     type: PageTransitionType.rightToLeftWithFade,
      //     child: OTPScreen(),
      //   ),
      // );
      successSnackBar('OTP Verified', response.message);
    } else {
      errorSnackBar('OTP Verification Failed', response.message);
      isLoading.value = false;
      print(isLoading.value);
    }
    isLoading.value = false;
  }

  Future<void> register(BuildContext context) async {
    isLoading.value = true;
    final response = await _authService.register(
      name.value.trim(),
      signupEmail.value.toLowerCase().trim(),
      phone.value.trim(),
      signupPassword.value.trim(),
    );
    if (response.code! >= 200 && response.code! < 300) {
      var result = SignupModel.fromJson(response.data);
      print(response.success);
      if (response.success == true) {
        successSnackBar('Registration Successful', response.message);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        errorSnackBar('Login Failed', response.message);
        isLoading.value = false;
      }
    }
    isLoading.value = false;
  }

  Future<void> refreshToken(BuildContext context) async {
    isLoading.value = true;
    var token =
        LocalDatabaseService().getData(DbKeyStrings.loginToken).toString();
    var refreshToken =
        LocalDatabaseService().getData(DbKeyStrings.refreshToken).toString();
    final response = await _authService.refreshToken(token, refreshToken);
    if (response.code == 200) {
      var newToken = LoginModel.fromJson(response.data);
      LocalDatabaseService().edit(DbKeyStrings.loginToken, newToken.token);
      // LocalDatabaseService()
      //     .edit(DbKeyStrings.refreshToken, newToken.refreshToken);
    } else {
      /* Navigator.pushNamedAndRemoveUntil(
          context, ScreenConstant.loginScreen, (Route<dynamic> route) => false);*/
    }
    isLoading.value = false;
  }
}
