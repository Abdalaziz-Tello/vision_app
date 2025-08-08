import 'package:vision_app/core/di_storage_listner/supabase_service.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/core/shared/models/resources_model/resource_request_model.dart';

abstract class RemoteGetUsersResourceDatasource {
  Future<List<ResourceRequestModel>> getUsersResourcesRequest();
}

class RemoteGetUsersResourceDatasourceImp
    implements RemoteGetUsersResourceDatasource {
  // final SupabaseClient supabase;
  final SupabaseService supabaseService;
  RemoteGetUsersResourceDatasourceImp({required this.supabaseService});

  // @override
  // Future<List<ResourceRequestModel>> getUsersResourcesRequest() async {
  //   try {
  //     final response = await supabase
  //         .from(AppKeys.resourcesRequestKey)
  //         .select(); //! change this and make it in the key class

  //     print("Data fetched from 'resources_request':");
  //     for (var item in response) {
  //       print(item);
  //     }

  //     return response
  //         .map<ResourceRequestModel>(
  //           (json) => ResourceRequestModel.fromJson(json),
  //         )
  //         .toList();
  //   } on PostgrestException catch (e) {
  //     print(" PostgrestException: ${e.message}");
  //     throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
  //   } catch (e) {
  //     print("Unexpected error: $e");
  //     throw ServerException(
  //       errorModel: ErrorModel(errorMessage: "Unexpected error: $e"),
  //     );
  //   }
  // }
  @override
  Future<List<ResourceRequestModel>> getUsersResourcesRequest() async {
    try {
      final result = await supabaseService.select(
        from: AppKeys.resourcesRequestKey,
        columns: '*',
      );
      print('resoursec in micro');
      return result.map((json) => ResourceRequestModel.fromJson(json)).toList();
    } catch (e) {
      rethrow; //  SupabaseService handle the exception wrapping
    }
  }
}
