
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/entities/project_domains_entity.dart';

class ProjectDomainsModel {
  final String id;
  final String name;
  final String description;
  final DateTime? createdAt;

  ProjectDomainsModel({
    required this.id,
    required this.name,
    required this.description,
    this.createdAt,
  });

  factory ProjectDomainsModel.fromJson(Map<String, dynamic> json) {
    return ProjectDomainsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  ProjectDomainsEntity toEntity() {
    return ProjectDomainsEntity(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
    );
  }
}
