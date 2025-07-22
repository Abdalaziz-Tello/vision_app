import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/shared/models/project_models/project_model.dart';

abstract class RemoteGetProjectsByUseIdDatasource {
  Future<List<ProjectModel>> getProjectsByUserId(String userId);
}

class RemoteGetProjectsByUseIdDatasourceImp
    implements RemoteGetProjectsByUseIdDatasource {
  final SupabaseClient supabase;

  RemoteGetProjectsByUseIdDatasourceImp({required this.supabase});

  @override
  Future<List<ProjectModel>> getProjectsByUserId(String userId) async {
    try {
      final response = await supabase
          .from('projects')
          .select('''
        *,
        project_attachments (
          id,
          file_url,
          file_name,
          file_type,
          file_size,
          uploaded_at
        )
      ''')
          .eq('created_by', userId);
      print(response);
      return (response as List).map((e) => ProjectModel.fromJson(e)).toList();
    } on PostgrestException catch (e) {
      print(e);
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print(e);
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected: $e"),
      );
    }
  }
}
