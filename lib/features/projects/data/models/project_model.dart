import 'package:vision_app/features/projects/domain/entities/project_entity.dart';

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
    );
  }
}
