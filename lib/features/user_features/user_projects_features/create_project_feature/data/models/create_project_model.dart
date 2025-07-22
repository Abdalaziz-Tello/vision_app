class CreateProjectModel {
  final String title;
  final String description;
  final String coverImageUrl;
  final bool isUniversityStudent;
  final String projectDomainId;
  final List<ProjectAttachmentModel> attachments;

  CreateProjectModel({
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.isUniversityStudent,
    required this.projectDomainId,
    required this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'cover_image_url': coverImageUrl,
      'is_university_student': isUniversityStudent,
      'project_domain_id': projectDomainId,
      'attachments': attachments.map((e) => e.toJson()).toList(),
    };
  }
}

class ProjectAttachmentModel {
  final String fileUrl;
  final String fileName;
  final String fileType;
  final int fileSize;

  ProjectAttachmentModel({
    required this.fileUrl,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
  });

  Map<String, dynamic> toJson() => {
        'file_url': fileUrl,
        'file_name': fileName,
        'file_type': fileType,
        'file_size': fileSize,
      };
}
