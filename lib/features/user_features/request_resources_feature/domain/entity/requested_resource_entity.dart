class RequestedResourceEntity {
  final String id;
  final String name;
  final String description;
  final bool isActive;
  final String? academicDepartmentId;

  RequestedResourceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.academicDepartmentId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestedResourceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          isActive == other.isActive &&
          academicDepartmentId == other.academicDepartmentId;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      isActive.hashCode ^
      academicDepartmentId.hashCode;
}
