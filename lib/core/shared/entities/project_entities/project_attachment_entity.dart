class ProjectAttachmentEntity {
  final String id;
  final String fileUrl;
  final String fileName;
  final String? fileType;
  final int? fileSize;
  final DateTime? uploadedAt;

  const ProjectAttachmentEntity({
    required this.id,
    required this.fileUrl,
    required this.fileName,
    this.fileType,
    this.fileSize,
    this.uploadedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAttachmentEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
