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
  static String get nameRequired => 'name_required'.tr();

  static String get advancedResourcesRequest =>
      'advanced_resources_request'.tr();
  static String get project => 'project'.tr();
  static String get completedPartOfProject => 'completed_part_of_project'.tr();
  static String get selectEducationEntity => 'select_education_entity'.tr();
  static String get educationEntity => 'education_entity'.tr();
  static String get selectResource => 'select_resource'.tr();
  static String get requiredResource => 'required_resource'.tr();
  static String get pleaseFillRequiredFields =>
      'please_fill_required_fields'.tr();
  static String get submitRequest => 'submit_request'.tr();
  static String get name => 'name'.tr();
  static String get thereAreNoFieldsAvailable =>
      'there_are_no_fields_available'.tr();
  static String get anErrorOccurredTryAgain =>
      'an_error_occurred_tryagain'.tr();
  static String get loading => 'loading'.tr();
  static String get chooseProjectField => 'choose_project_field'.tr();
  static String get pleaseEnterAllFieldsAndAddCoverImage =>
      'please_enter_all_fields_and_add_cover_image'.tr();
}
