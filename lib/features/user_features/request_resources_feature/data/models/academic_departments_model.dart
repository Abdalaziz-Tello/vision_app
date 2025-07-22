import 'package:vision_app/features/user_features/request_resources_feature/domain/entity/academic_departments_entity.dart';

class AcademicDepartmentsModel {
  final String id;
  final String name;
  final String code;
  final String description;
  final bool isActive;

  AcademicDepartmentsModel({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.isActive,
  });

  factory AcademicDepartmentsModel.fromJson(Map<String, dynamic> json) {
    return AcademicDepartmentsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      description: json['description'] as String,
      isActive: json['is_active'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'code': code,
    'description': description,
    'is_active': isActive,
  };

  AcademicDepartmentsEntity toEntity() {
    return AcademicDepartmentsEntity(
      id: id,
      name: name,
      code: code,
      description: description,
      isActive: isActive,
    );
  }
}
