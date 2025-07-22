// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';

import 'package:vision_app/core/shared/models/project_models/project_model.dart';

abstract class GetAllProjectsRemoteDatasource {
  Future<List<ProjectModel>> getProjects();
}

class GetAllProjectsRemoteDatasourceImp
    implements GetAllProjectsRemoteDatasource {
  final SupabaseClient supabase;
  GetAllProjectsRemoteDatasourceImp({required this.supabase});

  @override
  Future<List<ProjectModel>> getProjects() async {
    try {
      final response = await supabase.from('projects').select('''
          *,
          project_attachments (
            id,
            file_url,
            file_name,
            file_type,
            file_size,
            uploaded_at
          )
        ''');

      print('all projects : $response');
      return (response as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
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
