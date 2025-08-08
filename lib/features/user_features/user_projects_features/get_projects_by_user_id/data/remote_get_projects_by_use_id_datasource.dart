import 'package:vision_app/core/di_storage_listner/supabase_service.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/core/shared/models/project_models/project_model.dart';

abstract class RemoteGetProjectsByUseIdDatasource {
  Future<List<ProjectModel>> getProjectsByUserId(String userId);
}

class RemoteGetProjectsByUseIdDatasourceImp
    implements RemoteGetProjectsByUseIdDatasource {
  final SupabaseService supabaseService;

  RemoteGetProjectsByUseIdDatasourceImp({required this.supabaseService});

  @override
  Future<List<ProjectModel>> getProjectsByUserId(String userId) async {
    final response = await supabaseService.select(
      from: AppKeys.projectsKey,
      columns: '''
        *,
        project_attachments (
          id,
          file_url,
          file_name,
          file_type,
          file_size,
          uploaded_at
        )
      ''',
      filters: {AppKeys.createdByKey: userId},
    );

    print('user projects : $response');
    return response.map((e) => ProjectModel.fromJson(e)).toList();
  }
}
