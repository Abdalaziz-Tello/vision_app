import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/features/projects/data/models/create_project_model.dart';
import 'package:vision_app/features/projects/data/models/project_domains_model.dart';

abstract class ProjectRemoteDataSource {
  Future<List<ProjectDomainsModel>> getAllProjectDomains();
  Future<String> createProject(CreateProjectModel model);
}

class ProjectDomainRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final SupabaseClient supabase;

  ProjectDomainRemoteDataSourceImpl({required this.supabase});

  @override
  Future<List<ProjectDomainsModel>> getAllProjectDomains() async {
    try {
      final response = await supabase.from('project_domains').select();

      final resultList = response;
      print('sucess getting the data form the back: $resultList');

      return resultList
          .map((json) => ProjectDomainsModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      print(e);
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print(e);
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected error: $e"),
      );
    }
  }

  @override
  Future<String> createProject(CreateProjectModel model) async {
    try {
      print("Calling Supabase RPC 'create_project' with:");
      print(" Payload: ${model.toJson()}");

      final result = await supabase.rpc<String>(
        'create_project',
        params: model.toJson(),
      );

      print(" RPC Response: $result");

      return result;
    } on PostgrestException catch (e) {
      print("PostgrestException: ${e.message}");
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print("Unexpected error: $e");
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected error: $e"),
      );
    }
  }
}
