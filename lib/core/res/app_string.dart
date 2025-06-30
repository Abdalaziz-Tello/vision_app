// class AppString {
//   static const String login = "Login";
//   static const String signup = "Signup";
// }

import 'package:easy_localization/easy_localization.dart';

class AppString {
  static String get login => 'login'.tr();
  static String get signup => 'signup'.tr();
  static String get createFirstProject => 'create_first_project'.tr();
  static String get projectName => 'project_name'.tr();
  static String get projectField => 'project_field'.tr();
  static String get projectDescription => 'project_description'.tr();
  static String get addAttachments => 'add_attachments'.tr();
  static String get addFiles => 'add_files'.tr();
  static String get addCoverImage => 'add_cover_image'.tr();
  static String get universityStudent => 'university_student'.tr();
  static String get upload => 'upload'.tr();
  static String get showYourProjectNow => 'show_your_project_now'.tr();
  static String get topProjects => 'top_projects'.tr();
  static String get email => 'email'.tr();
  static String get enterEmail => 'enter_email'.tr();
  static String get password => 'password'.tr();
  static String get enterPassword => 'enter_password'.tr();
  static String get emailRequired => 'email_required'.tr();
  static String get emailInvalid => 'email_invalid'.tr();
  static String get passwordRequired => 'password_required'.tr();
  static String get passwordTooShort => 'password_too_short'.tr();
}
