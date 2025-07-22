class CreateProjectEntity {
  final String title;
  final String description;
  final String coverImageUrl;
  final bool isUniversityStudent;
  final String projectDomainId;
  final List<ProjectAttachmentEntityForcreating> attachments;

  CreateProjectEntity({
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.isUniversityStudent,
    required this.projectDomainId,
    required this.attachments,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateProjectEntity &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          coverImageUrl == other.coverImageUrl &&
          isUniversityStudent == other.isUniversityStudent &&
          projectDomainId == other.projectDomainId &&
          attachments == other.attachments;

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
      coverImageUrl.hashCode ^
      isUniversityStudent.hashCode ^
      projectDomainId.hashCode ^
      attachments.hashCode;
}

//_____________________________________________________
class ProjectAttachmentEntityForcreating {
  final String fileUrl;
  final String fileName;
  final String fileType;
  final int fileSize;

  ProjectAttachmentEntityForcreating({
    required this.fileUrl,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
  });
}
