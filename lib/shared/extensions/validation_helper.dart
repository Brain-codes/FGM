import 'package:FGM/shared/constants/app_string.dart';

mixin ValidatorHelper {
  static const String minimumLength = 'minimumLength';
  static const String hasDigit = 'hasDigit';
  static const String hasUppercase = 'hasUppercase';
  static const String hasLowercase = 'hasLowercase';
  static const String hasSpecialChar = 'hasSpecialCharacter';
  static const String hasNoSpace = 'hasNoSpace';

  static const String length = 'length';
  static const String digit = 'digit';
  static const String uppercase = 'uppercase';
  static const String lowercase = 'lowercase';
  static const String specialChar = 'specialChar';
  static const String noSpace = 'noSpace';


  static Map<String, String> passwordErrors = <String, String>{
    minimumLength: AppStrings.passwordAtLeast8Character,
    hasDigit: AppStrings.passwordContainANumber,
    hasUppercase: AppStrings.passwordContainUppercase,
    hasLowercase: AppStrings.passwordContainLowercase,
    hasSpecialChar: AppStrings.passwordContainSpecialChar,
    hasNoSpace: AppStrings.passwordContainSpace,
  };

  static Map<String, bool> passwordValidation = <String, bool>{
    length: false,
    digit: false,
    uppercase: false,
    lowercase: false,
    specialChar: false,
    noSpace: false
  };

  static Map<String, bool> getPasswordValidationReport(String password) {
    passwordValidation[length] = password.length >= 8;
    passwordValidation[lowercase] = password.contains(RegExp(r'[a-z]'));
    passwordValidation[uppercase] = password.contains(RegExp(r'[A-Z]'));
    passwordValidation[digit] = password.contains(RegExp(r'[0-9]'));
    passwordValidation[specialChar] =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    passwordValidation[noSpace] =
        password.isNotEmpty && !password.contains(RegExp(' '));

    return passwordValidation;
  }

  static String? getPasswordErrorMessage(String error) {
    switch (error) {
      case ValidatorHelper.minimumLength:
        return ValidatorHelper.passwordErrors[ValidatorHelper.minimumLength];

      case ValidatorHelper.hasDigit:
        return ValidatorHelper.passwordErrors[ValidatorHelper.hasDigit];

      case ValidatorHelper.hasLowercase:
        return ValidatorHelper.passwordErrors[ValidatorHelper.hasLowercase];

      case ValidatorHelper.hasUppercase:
        return ValidatorHelper.passwordErrors[ValidatorHelper.hasUppercase];

      case ValidatorHelper.hasSpecialChar:
        return ValidatorHelper.passwordErrors[ValidatorHelper.hasSpecialChar];

      case ValidatorHelper.hasNoSpace:
        return ValidatorHelper.passwordErrors[ValidatorHelper.hasNoSpace];

      default:
        return error;
    }
  }
}
