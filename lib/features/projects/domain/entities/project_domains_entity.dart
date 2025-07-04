class ProjectDomainsEntity {
  final String id;
  final String name;
  final String description;
  final DateTime? createdAt;

  ProjectDomainsEntity({
    required this.id,
    required this.name,
    required this.description,
    this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectDomainsEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ description.hashCode ^ createdAt.hashCode;
}
