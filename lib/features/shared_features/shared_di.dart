import 'package:vision_app/features/shared_features/auth/utils/auth_injection.dart';
import 'package:vision_app/features/shared_features/get_project_details_feature/di.dart';
import 'package:vision_app/features/shared_features/get_top_3_projects_feature/di.dart';

Future<void> initSharedFeatures() async {
  await initAuth();
  await initProjectDetails();
  await initTopCompletedProjects();
}
