import 'package:FGM/shared/constants/app_string.dart';

extension FormValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidEmailAndPhone() {
    return RegExp(r'^(?:\d{11}|\w+@\w+\.\w{2,3})$').hasMatch(this);
  }

  bool isNotEmpty() {
    return RegExp(r'^(?:\d{11}|\w+@\w+\.\w{2,3})$').hasMatch(this);
  }

  bool isValidPhone() {
    return RegExp(r'^\d{11}$').hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])[A-Za-z\d#$@!%&*?]{8,}$")
        .hasMatch(this);
  }

  static RegExp passwordRegex = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])[A-Za-z\d#$@!%&*?]{8,}$");

  bool isValidFullName() {
    return RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
        .hasMatch(this);
  }

  validateEmail(value) {
    if (value!.isEmpty ||
        !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value!)) {
      return AppStrings.enterValidEmail;
    } else {
      return null;
    }
  }
}
