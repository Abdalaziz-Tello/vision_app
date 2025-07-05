import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/features/resources_feature/data/models/academic_departments_model.dart';
import 'package:vision_app/features/resources_feature/data/models/requested_resource_model.dart';
import 'package:vision_app/features/resources_feature/data/models/resource_request_model.dart';

abstract class RemoteResources {
  Future<List<AcademicDepartmentsModel>> getAllAcademics();
  Future<List<RequestedResourceModel>> getRequestedResources({
    String? departmentId,
  });
  Future<void> submitResourceRequest(ResourceRequestModel model);
}

class RemoteResourcesImpl implements RemoteResources {
  final SupabaseClient supabase;

  RemoteResourcesImpl({required this.supabase});

  @override
  Future<List<AcademicDepartmentsModel>> getAllAcademics() async {
    try {
      final response = await supabase
          .from('academic_departments')
          .select(); //! change this and make it in the key class

      print("Data fetched from 'academics':");
      for (var item in response) {
        print(item);
      }

      return response
          .map<AcademicDepartmentsModel>(
            (json) => AcademicDepartmentsModel.fromJson(json),
          )
          .toList();
    } on PostgrestException catch (e) {
      print(" PostgrestException: ${e.message}");
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print("Unexpected error: $e");
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected error: $e"),
      );
    }
  }

  //__________________________________________________________
  @override
  Future<List<RequestedResourceModel>> getRequestedResources({
    String? departmentId,
  }) async {
    try {
      final query = supabase
          .from('requested_resources')
          .select(); //! remove the keys form here to the keys app class
      final response = departmentId != null
          ? await query.eq('academic_department_id', departmentId)
          : await query;

      print("📦 Requested Resources fetched:");
      for (var item in response) {
        print(item);
      }

      return response
          .map<RequestedResourceModel>(
            (json) => RequestedResourceModel.fromJson(json),
          )
          .toList();
    } on PostgrestException catch (e) {
      print("Error: ${e.message}");
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print("Unexpected error: $e");
      throw ServerException(errorModel: ErrorModel(errorMessage: "$e"));
    }
  }

  //______________________________________________________
  @override
  Future<void> submitResourceRequest(ResourceRequestModel model) async {
    try {
      final response = await supabase
          .from('resources_request')
          .insert(model.toJson());

      print(" Resource request inserted successfully: $response");
    } on PostgrestException catch (e) {
      print(" PostgrestException: ${e.message}");
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print(" Unexpected error: $e");
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected error: $e"),
      );
    }
  }
}
