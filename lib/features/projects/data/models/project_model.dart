
import 'package:vision_app/features/projects/data/models/project_attachment_model.dart';
import 'package:vision_app/features/projects/domain/entities/project_entity.dart' show ProjectEntity;

class ProjectModel {
  final String id;
  final String title;
  final String projectDomainId;
  final int percentageCompleted;
  final String? description;
  final String? status;
  final bool isPublic;
  final String? coverImageUrl;
  final bool isUniversityStudent;

  final String? createdBy;
  final DateTime? createdAt;
  final bool? isApprovedForInvestors;
  final String? projectDomainName;
  final String projectOwnerName;

  // : قائمة المرفقات
  final List<ProjectAttachmentModel> attachments;

  ProjectModel({
    required this.id,
    required this.title,
    required this.projectDomainId,
    required this.percentageCompleted,
    this.description,
    this.status,
    required this.isPublic,
    this.coverImageUrl,
    required this.isUniversityStudent,
    this.createdBy,
    this.createdAt,
    this.isApprovedForInvestors,
    this.projectDomainName,
    required this.projectOwnerName,
    this.attachments = const [],
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      projectDomainId: json['project_domain_id'] as String,
      percentageCompleted: json['percentage_completed'] as int,
      description: json['description'] as String?,
      status: json['status'] as String?,
      isPublic: json['is_public'] as bool,
      coverImageUrl: json['cover_image_url'] as String?,
      isUniversityStudent: json['is_university_student'] as bool,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      isApprovedForInvestors: json['is_approved_for_investors'] as bool?,
      projectDomainName: json['project_domain_name'] as String?,
      projectOwnerName: json['project_owner_name'] as String,
      attachments: (json['project_attachments'] as List<dynamic>? ?? [])
          .map((e) => ProjectAttachmentModel.fromJson(e))
          .toList(),
    );
  }

  ProjectEntity toEntity() {
    return ProjectEntity(
      id: id,
      title: title,
      projectDomainId: projectDomainId,
      percentageCompleted: percentageCompleted,
      description: description,
      status: status,
      isPublic: isPublic,
      coverImageUrl: coverImageUrl,
      isUniversityStudent: isUniversityStudent,
      createdBy: createdBy,
      createdAt: createdAt,
      isApprovedForInvestors: isApprovedForInvestors,
      projectDomainName: projectDomainName,
      projectOwnerName: projectOwnerName,
       attachments: attachments.map((e) => e.toEntity()).toList(),

    );
  }
}
