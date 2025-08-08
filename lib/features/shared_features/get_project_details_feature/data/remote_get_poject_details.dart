// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';

import 'package:vision_app/core/shared/models/project_models/project_model.dart';

abstract class RemoteGetPojectDetails {
  Future<ProjectModel> getProjectById(String projectId);
}

class RemoteGetPojectDetailsImpl implements RemoteGetPojectDetails {
  final SupabaseClient supabase;
  RemoteGetPojectDetailsImpl({required this.supabase});

  @override
  Future<ProjectModel> getProjectById(String projectId) async {
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
        ''')//? should we do it in better way ?
          .eq(AppKeys.idKey, projectId)
          .maybeSingle();

      if (response == null) {
        throw ServerException(
          errorModel: ErrorModel(errorMessage: "Project not found"),
        );
      }
      print('successfully>>');
      print(response);
      return ProjectModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected: $e"),
      );
    }
  }
}
