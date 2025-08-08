// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';

import 'package:vision_app/core/shared/models/project_models/project_model.dart';

abstract class TopCompletedProjectDatasource {
  Future<List<ProjectModel>> getTopCompletedProjects();
}

class TopCompletedProjectDatasourceImp
    implements TopCompletedProjectDatasource {
  final SupabaseClient supabase;
  TopCompletedProjectDatasourceImp({required this.supabase});

  @override
  Future<List<ProjectModel>> getTopCompletedProjects() async {
    try {
      final response = await supabase
          .from(AppKeys.projectsKey)
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
        ''') //? should we do it in better way ?
          .eq(AppKeys.isPublicKey, true) // Only public projects
          .lte(AppKeys.percentageCompletedKey, 100) // Up to 100%
          .order(
            AppKeys.percentageCompletedKey,
            ascending: false,
          ) // Highest first
          .limit(3); // Top 3 only

      print('top projects : $response');
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
