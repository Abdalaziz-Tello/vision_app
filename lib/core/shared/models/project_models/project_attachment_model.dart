
import 'package:vision_app/core/shared/entities/project_entities/project_attachment_entity.dart';

class ProjectAttachmentModel {
  final String id;
  final String fileUrl;
  final String fileName;
  final String? fileType;
  final int? fileSize;
  final DateTime? uploadedAt;

  ProjectAttachmentModel({
    required this.id,
    required this.fileUrl,
    required this.fileName,
    this.fileType,
    this.fileSize,
    this.uploadedAt,
  });

  factory ProjectAttachmentModel.fromJson(Map<String, dynamic> json) {
    return ProjectAttachmentModel(
      id: json['id'] as String,
      fileUrl: json['file_url'] as String,
      fileName: json['file_name'] as String,
      fileType: json['file_type'] as String?,
      fileSize: json['file_size'] as int?,
      uploadedAt: json['uploaded_at'] != null
          ? DateTime.tryParse(json['uploaded_at'])
          : null,
    );
  }

  ProjectAttachmentEntity toEntity() {
    return ProjectAttachmentEntity(
      id: id,
      fileUrl: fileUrl,
      fileName: fileName,
      fileType: fileType,
      fileSize: fileSize,
      uploadedAt: uploadedAt,
    );
  }
}
