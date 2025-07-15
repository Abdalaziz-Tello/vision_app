part of 'dialog_form_cubit.dart';

@immutable
final class DialogFormState {
  final bool isUploading;
  final bool isUniversityStudent;
  final List<PlatformFile> selectedFiles;
  final PlatformFile? coverImage;
  final String? selectedDomainId;
  final String? selectedDomainName;

  const DialogFormState({
    this.isUploading = false,
    this.isUniversityStudent = false,
    this.selectedFiles = const [],
    this.coverImage,
    this.selectedDomainId,
    this.selectedDomainName,
  });

  DialogFormState copyWith({
    bool? isUploading,
    bool? isUniversityStudent,
    List<PlatformFile>? selectedFiles,
    PlatformFile? coverImage,
    String? selectedDomainId,
    String? selectedDomainName,
  }) {
    return DialogFormState(
      isUploading: isUploading ?? this.isUploading,
      isUniversityStudent: isUniversityStudent ?? this.isUniversityStudent,
      selectedFiles: selectedFiles ?? this.selectedFiles,
      coverImage: coverImage ?? this.coverImage,
      selectedDomainId: selectedDomainId ?? this.selectedDomainId,
      selectedDomainName: selectedDomainName ?? this.selectedDomainName,
    );
  }
}
