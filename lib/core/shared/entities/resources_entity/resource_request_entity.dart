class ResourceRequestEntity {
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

  const ResourceRequestEntity({
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
}
