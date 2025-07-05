import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vision_app/features/projects/domain/entities/upload_file_entity.dart';
import 'package:vision_app/features/projects/domain/usecase/upload_file_usecase.dart';

part 'upload_file_event.dart';
part 'upload_file_state.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final UploadFileUseCase uploadFileUseCase;

  UploadFileBloc({required this.uploadFileUseCase})
    : super(UploadFileInitial()) {
    on<UploadFileRequested>(_onUploadRequested);
  }

  Future<void> _onUploadRequested(
    UploadFileRequested event,
    Emitter<UploadFileState> emit,
  ) async {
    emit(UploadFileLoading());

    final result = await uploadFileUseCase(event.file);

    result.fold(
      (failure) => emit(UploadFileFailure(message: failure.message)),
      (file) => emit(UploadFileSuccess(file: file)),
    );
  }
}
//! think about it ?!
extension UploadFileBlocHelper on UploadFileBloc {
  Future<UploadFileEntity?> uploadSingleFile(PlatformFile file) async {
    final result = await uploadFileUseCase(file);
    return result.fold((failure) => null, (file) => file);
  }
}
