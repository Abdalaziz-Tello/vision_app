import 'package:vision_app/features/microbots_features/get_all_projects_feature/di.dart';
import 'package:vision_app/features/microbots_features/get_resource_requests/di.dart';
import 'package:vision_app/features/microbots_features/tools_feature/tools_injuction.dart';

Future<void> initMicrobotsFeatures() async {
  await initTools();
  await initGetAllProjects();
  await initGetAllResourceRequests();
}
