class ProjectEntity {
  final String id;
  final String title;
  final String projectDomainId;
  final int percentageCompleted;
  final String? description;
  final String? status;
  final bool isPublic;// is_approved_for_visitor
  final String? coverImageUrl;
  final bool isUniversityStudent;

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
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProjectEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
