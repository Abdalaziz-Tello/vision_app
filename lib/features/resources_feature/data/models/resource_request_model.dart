import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/features/resources_feature/domain/entity/resource_request_entity.dart';

class ResourceRequestModel extends ResourceRequestEntity {
  const ResourceRequestModel({
    required super.projectId,
    required super.requestedResourceId,
    required super.requestedBy,
    super.academicDepartmentId,
    super.projectDomainId,
    super.percentageCompleted,
    super.status,
    super.notes,
    super.requestedAt,
    super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'project_id': projectId,
      'requested_resource_id': requestedResourceId,
      'requested_by': requestedBy,
      'academic_department_id': academicDepartmentId,
      'project_domain_id': projectDomainId,
      'percentage_completed': percentageCompleted,
      'status': status,
      'notes': notes,
      'requested_at': requestedAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory ResourceRequestModel.fromEntity(ResourceRequestEntity entity) {
    return ResourceRequestModel(
      projectId: entity.projectId,
      requestedResourceId: entity.requestedResourceId,
      requestedBy: entity.requestedBy,
      academicDepartmentId: entity.academicDepartmentId,
      projectDomainId: entity.projectDomainId,
      percentageCompleted: entity.percentageCompleted,
      status: entity.status ?? AppKeys.pending, //'pending',
      notes: entity.notes,
      requestedAt: entity.requestedAt ?? DateTime.now(),
      updatedAt: entity.updatedAt ?? DateTime.now(),
    );
  }
}
