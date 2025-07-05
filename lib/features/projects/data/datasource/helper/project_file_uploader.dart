import 'dart:io';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vision_app/features/projects/domain/entities/create_project_entity.dart';

class ProjectFileUploader {
  final SupabaseClient supabase;

  ProjectFileUploader(this.supabase);

  Future<(String coverUrl, List<ProjectAttachmentEntity> attachments)> upload({
    required File coverImage,
    required List<PlatformFile> selectedFiles,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    // 1. Upload cover image
    final coverBytes = await coverImage.readAsBytes();
    final coverName = coverImage.path.split('/').last;
    final coverMime =
        lookupMimeType(coverImage.path) ?? 'application/octet-stream';
    final coverPath = '${user.id}/cover_$coverName';

    await supabase.storage
        .from('project-attachments')
        .uploadBinary(
          coverPath,
          coverBytes,
          fileOptions: FileOptions(contentType: coverMime, upsert: true),
        );
    final coverUrl = supabase.storage
        .from('project-attachments')
        .getPublicUrl(coverPath);

    // 2. Upload attachments
    List<ProjectAttachmentEntity> attachments = [];

    for (final file in selectedFiles) {
      if (file.path == null) continue;

      final fileBytes = await File(file.path!).readAsBytes();
      final mime = lookupMimeType(file.path!) ?? 'application/octet-stream';
      final path = '${user.id}/${file.name}';

      await supabase.storage
          .from('project-attachments')
          .uploadBinary(
            path,
            fileBytes,
            fileOptions: FileOptions(contentType: mime, upsert: true),
          );

      final publicUrl = supabase.storage
          .from('project-attachments')
          .getPublicUrl(path);

      attachments.add(
        ProjectAttachmentEntity(
          fileUrl: publicUrl,
          fileName: file.name,
          fileType: mime,
          fileSize: fileBytes.length,
        ),
      );
    }

    return (coverUrl, attachments);
  }
}
