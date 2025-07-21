import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/features/resources_feature/domain/entity/resource_request_entity.dart';

// class ResourceRequestModel extends ResourceRequestEntity {
//   const ResourceRequestModel({
//     required super.projectId,
//     required super.requestedResourceId,
//     required super.requestedBy,
//     super.academicDepartmentId,
//     super.projectDomainId,
//     super.percentageCompleted,
//     super.status,
//     super.notes,
//     super.requestedAt,
//     super.updatedAt,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'project_id': projectId,
//       'requested_resource_id': requestedResourceId,
//       'requested_by': requestedBy,
//       'academic_department_id': academicDepartmentId,
//       'project_domain_id': projectDomainId,
//       'percentage_completed': percentageCompleted,
//       'status': status,
//       'notes': notes,
//       'requested_at': requestedAt?.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//     };
//   }

//   factory ResourceRequestModel.fromEntity(ResourceRequestEntity entity) {
//     return ResourceRequestModel(
//       projectId: entity.projectId,
//       requestedResourceId: entity.requestedResourceId,
//       requestedBy: entity.requestedBy,
//       academicDepartmentId: entity.academicDepartmentId,
//       projectDomainId: entity.projectDomainId,
//       percentageCompleted: entity.percentageCompleted,
//       status: entity.status ?? AppKeys.pending, //'pending',
//       notes: entity.notes,
//       requestedAt: entity.requestedAt ?? DateTime.now(),
//       updatedAt: entity.updatedAt ?? DateTime.now(),
//     );
//   }
// }

class ResourceRequestModel {
  final String projectId;
  final String requestedResourceId;
  final String requestedBy;
  final String? academicDepartmentId;
  final String? projectDomainId;
  final int? percentageCompleted;
  final String? status;
  final String? notes;
  final DateTime? requestedAt;
  final DateTime? updatedAt;

  const ResourceRequestModel({
    required this.projectId,
    required this.requestedResourceId,
    required this.requestedBy,
    this.academicDepartmentId,
    this.projectDomainId,
    this.percentageCompleted,
    this.status,
    this.notes,
    this.requestedAt,
    this.updatedAt,
  });

  factory ResourceRequestModel.fromJson(Map<String, dynamic> json) {
    return ResourceRequestModel(
      projectId: json['project_id'],
      requestedResourceId: json['requested_resource_id'],
      requestedBy: json['requested_by'],
      academicDepartmentId: json['academic_department_id'],
      projectDomainId: json['project_domain_id'],
      percentageCompleted: (json['percentage_completed'] as num?)?.toInt(),
      status: json['status'],
      notes: json['notes'],
      requestedAt: json['requested_at'] != null
          ? DateTime.parse(json['requested_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

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
      status: entity.status ?? AppKeys.pending,
      notes: entity.notes,
      requestedAt: entity.requestedAt ?? DateTime.now(),
      updatedAt: entity.updatedAt ?? DateTime.now(),
    );
  }

  ResourceRequestEntity toEntity() {
    return ResourceRequestEntity(
      projectId: projectId,
      requestedResourceId: requestedResourceId,
      requestedBy: requestedBy,
      academicDepartmentId: academicDepartmentId,
      projectDomainId: projectDomainId,
      percentageCompleted: percentageCompleted,
      status: status,
      notes: notes,
      requestedAt: requestedAt,
      updatedAt: updatedAt,
    );
  }
}
