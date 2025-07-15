part of 'project_attachments_cubit.dart';

class ProjectAttachmentsState {
  final PlatformFile? coverImage;
  final PlatformFile? attachment;

  ProjectAttachmentsState({this.coverImage, this.attachment});

  ProjectAttachmentsState copyWith({
    PlatformFile? coverImage,
    PlatformFile? attachment,
  }) {
    return ProjectAttachmentsState(
      coverImage: coverImage ?? this.coverImage,
      attachment: attachment ?? this.attachment,
    );
  }
}
