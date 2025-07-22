import 'package:vision_app/features/user_features/request_resources_feature/resources_di.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/project_injection.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/di.dart';

Future<void> initUserFeatures() async {
  await initResources();
  await initGetProjectsByUserId();
  await initCreateProject();
}
