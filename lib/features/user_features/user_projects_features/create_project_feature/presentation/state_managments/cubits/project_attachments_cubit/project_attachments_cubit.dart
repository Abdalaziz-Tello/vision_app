import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
part 'project_attachments_state.dart';


class ProjectAttachmentsCubit extends Cubit<ProjectAttachmentsState> {
  ProjectAttachmentsCubit() : super(ProjectAttachmentsState());

  void setCover(PlatformFile? file) => emit(state.copyWith(coverImage: file));
  void setAttachment(PlatformFile? file) =>
      emit(state.copyWith(attachment: file));

  void preload({PlatformFile? initialCover, PlatformFile? initialAttachment}) {
    emit(
      ProjectAttachmentsState(
        coverImage: initialCover,
        attachment: initialAttachment,
      ),
    );
  }
}
