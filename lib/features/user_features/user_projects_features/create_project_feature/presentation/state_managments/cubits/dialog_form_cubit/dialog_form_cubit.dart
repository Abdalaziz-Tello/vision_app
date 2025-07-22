import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

part 'dialog_form_state.dart';

//this cubit responsible for the ui updates

class DialogFormCubit extends Cubit<DialogFormState> {
  DialogFormCubit() : super(const DialogFormState());

  void toggleUniversityStudent(bool value) =>
      emit(state.copyWith(isUniversityStudent: value));

  void setCoverImage(PlatformFile file) =>
      emit(state.copyWith(coverImage: file));

  void setAttachments(List<PlatformFile> files) =>
      emit(state.copyWith(selectedFiles: files));

  void setDomain(String domainId, String domainName) => emit(
    state.copyWith(selectedDomainId: domainId, selectedDomainName: domainName),
  );

  void setUploading(bool uploading) =>
      emit(state.copyWith(isUploading: uploading));

  void addAttachment(PlatformFile file) {
    final updatedFiles = [...state.selectedFiles, file];
    emit(state.copyWith(selectedFiles: updatedFiles));
  }
}
