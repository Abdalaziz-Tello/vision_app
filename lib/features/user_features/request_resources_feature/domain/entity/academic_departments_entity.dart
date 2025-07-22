class AcademicDepartmentsEntity {
  final String id;
  final String name;
  final String code;
  final String description;
  final bool isActive;

  AcademicDepartmentsEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.isActive,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcademicDepartmentsEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          code == other.code &&
          description == other.description &&
          isActive == other.isActive;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      code.hashCode ^
      description.hashCode ^
      isActive.hashCode;
}
