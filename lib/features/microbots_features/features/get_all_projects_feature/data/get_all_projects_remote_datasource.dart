// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vision_app/core/di_storage_listner/supabase_service.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/core/shared/models/project_models/project_model.dart';

abstract class GetAllProjectsRemoteDatasource {
  Future<List<ProjectModel>> getProjects();
}

class GetAllProjectsRemoteDatasourceImp
    implements GetAllProjectsRemoteDatasource {
  // final SupabaseClient supabase;
  final SupabaseService supabaseService;
  GetAllProjectsRemoteDatasourceImp({required this.supabaseService});

  @override
  Future<List<ProjectModel>> getProjects() async {
    try {
      final result = await supabaseService.select(
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
      );
      print('projects in micro');
      return result.map((json) => ProjectModel.fromJson(json)).toList();
    } catch (e) {
      rethrow; //handled in SupabaseService
    }
  }
}
