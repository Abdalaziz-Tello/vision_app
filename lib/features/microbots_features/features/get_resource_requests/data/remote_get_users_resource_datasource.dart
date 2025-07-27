// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';

import 'package:vision_app/core/shared/models/resources_model/resource_request_model.dart';

abstract class RemoteGetUsersResourceDatasource {
  Future<List<ResourceRequestModel>> getUsersResourcesRequest();
}

class RemoteGetUsersResourceDatasourceImp
    implements RemoteGetUsersResourceDatasource {
  final SupabaseClient supabase;
  RemoteGetUsersResourceDatasourceImp({required this.supabase});

  @override
  Future<List<ResourceRequestModel>> getUsersResourcesRequest() async {
    try {
      final response = await supabase
          .from('resources_request')
          .select(); //! change this and make it in the key class

      print("Data fetched from 'resources_request':");
      for (var item in response) {
        print(item);
      }

      return response
          .map<ResourceRequestModel>(
            (json) => ResourceRequestModel.fromJson(json),
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
}
