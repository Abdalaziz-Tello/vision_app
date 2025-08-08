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

  @override
  Future<List<ResourceRequestModel>> getUsersResourcesRequest() async {
    //  try {
    final result = await supabaseService.select(
      from: AppKeys.resourcesRequestKey,
      columns: '*',
    );
    print('resoursec in micro');
    return result.map((json) => ResourceRequestModel.fromJson(json)).toList();
    // } catch (e) {
    //   rethrow; //  SupabaseService handle the exception wrapping
    // }
  }
}
