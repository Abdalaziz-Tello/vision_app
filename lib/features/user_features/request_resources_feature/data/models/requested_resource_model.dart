import 'package:vision_app/features/user_features/request_resources_feature/domain/entity/requested_resource_entity.dart';

class RequestedResourceModel {
  final String id;
  final String name;
  final String? description;
  final bool? isActive;
  final String? academicDepartmentId;

  RequestedResourceModel({
    required this.id,
    required this.name,
    this.description,
    this.isActive,
    this.academicDepartmentId,
  });

  factory RequestedResourceModel.fromJson(Map<String, dynamic> json) {
    return RequestedResourceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool?,
      academicDepartmentId: json['academic_department_id'] as String?,
    );
  }

  RequestedResourceEntity toEntity() {
    return RequestedResourceEntity(
      id: id,
      name: name,
      description: description ?? '',
      isActive: isActive ?? false,
      academicDepartmentId: academicDepartmentId,
    );
  }
}
