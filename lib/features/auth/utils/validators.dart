import 'package:vision_app/core/res/app_string.dart';

class AuthValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return AppString.emailRequired;
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) return AppString.emailInvalid;
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) return AppString.nameRequired;
    if (name.trim().length < 2) return AppString.nameMinLength;
    return null;
  }

  static String? validatePassword(String? value, {required bool isLogin}) {
    if (value == null || value.isEmpty) return AppString.passwordRequired;
    if (isLogin) return null;

    if (value.length < 8) return AppString.passwordTooShort;

    final hasUpper = value.contains(RegExp(r'[A-Z]'));
    final hasLower = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'[0-9]'));
    final hasSpecial = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUpper) return AppString.passwordUpper;
    if (!hasLower) return AppString.passwordLower;
    if (!hasDigit) return AppString.passwordNumber;
    if (!hasSpecial) return AppString.passwordSpecial;

    return null;
  }
}
