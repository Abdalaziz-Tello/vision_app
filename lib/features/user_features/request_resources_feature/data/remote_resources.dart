import 'package:vision_app/core/di_storage_listner/supabase_service.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/features/user_features/request_resources_feature/data/models/academic_departments_model.dart';
import 'package:vision_app/features/user_features/request_resources_feature/data/models/requested_resource_model.dart';
import 'package:vision_app/core/shared/models/resources_model/resource_request_model.dart';

abstract class RemoteResources {
  Future<List<AcademicDepartmentsModel>> getAllAcademics();
  Future<List<RequestedResourceModel>> getRequestedResources({
    String? departmentId,
  });
  Future<void> submitResourceRequest(ResourceRequestModel model);
  //_____________________________________________________
  //microbots :
  // Future<List<ResourceRequestModel>> getUsersResourcesRequest();
}

class RemoteResourcesImpl implements RemoteResources {
  final SupabaseService supabaseService;

  RemoteResourcesImpl({required this.supabaseService});

  //______________________________________________________
  @override
  Future<List<AcademicDepartmentsModel>> getAllAcademics() async {
    final response = await supabaseService.select(
      from: AppKeys.academicDepartmentsKey,
      columns: '*',
    );

    print("Data fetched from 'academics':");
    for (var item in response) {
      print(item);
    }

    return response
        .map<AcademicDepartmentsModel>(
          (json) => AcademicDepartmentsModel.fromJson(json),
        )
        .toList();
  }

  //__________________________________________________________
  @override
  Future<List<RequestedResourceModel>> getRequestedResources({
    String? departmentId,
  }) async {
    final response = await supabaseService.select(
      from: AppKeys.requestedResourcesKey,
      columns: '*',
      filters: departmentId != null
          ? {AppKeys.academicDepartmentIdKey: departmentId}
          : null,
    );

    print("📦 Requested Resources fetched:");
    for (var item in response) {
      print(item);
    }

    return response
        .map<RequestedResourceModel>(
          (json) => RequestedResourceModel.fromJson(json),
        )
        .toList();
  }

  //______________________________________________________
  @override
  Future<void> submitResourceRequest(ResourceRequestModel model) async {
    await supabaseService.insert(
      into: AppKeys.resourcesRequestKey,
      data: model.toJson(),
    );

    print("✅ Resource request inserted successfully");
  }

  //________________________________________________________________
}
