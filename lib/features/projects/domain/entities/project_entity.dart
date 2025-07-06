
import 'package:vision_app/features/projects/domain/entities/project_attachment_entity.dart';

class ProjectEntity {
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

  final List<ProjectAttachmentEntity> attachments;

  ProjectEntity({
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProjectEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
