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
}
