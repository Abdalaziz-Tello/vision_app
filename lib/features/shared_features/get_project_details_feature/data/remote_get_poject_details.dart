// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vision_app/core/di_storage_listner/supabase_service.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';

import 'package:vision_app/core/shared/models/project_models/project_model.dart';

abstract class RemoteGetPojectDetails {
  Future<ProjectModel> getProjectById(String projectId);
}

class RemoteGetPojectDetailsImpl implements RemoteGetPojectDetails {
  //final SupabaseClient supabase;
   final SupabaseService supabaseService;
  RemoteGetPojectDetailsImpl({required this.supabaseService});

  // @override
  // Future<ProjectModel> getProjectById(String projectId) async {
  //   try {
  //     final response = await supabase
  //         .from(AppKeys.projectsKey)
  //         .select('''
  //         *,
  //         project_attachments (
  //           id,
  //           file_url,
  //           file_name,
  //           file_type,
  //           file_size,
  //           uploaded_at
  //         )
  //       ''')//? should we do it in better way ?
  //         .eq(AppKeys.idKey, projectId)
  //         .maybeSingle();

  //     if (response == null) {
  //       throw ServerException(
  //         errorModel: ErrorModel(errorMessage: "Project not found"),
  //       );
  //     }
  //     print('successfully>>');
  // }

   @override
  Future<ProjectModel> getProjectById(String projectId) async {
    print("🔍 Fetching project with ID: $projectId");

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
      filters: {
        AppKeys.idKey: projectId,
      },
    );

    if (result.isEmpty) {
      print("❌ Project not found with ID: $projectId");
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Project not found"),
      );
    }

    final json = result.first;
    print("✅ Project fetched successfully: $json");

    return ProjectModel.fromJson(json);
  }
}
