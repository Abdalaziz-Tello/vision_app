// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_file_bloc.dart';

abstract class UploadFileState {}

class UploadFileInitial extends UploadFileState {}

class UploadFileLoading extends UploadFileState {}

class UploadFileSuccess extends UploadFileState {
  final UploadFileEntity file;
  UploadFileSuccess({required this.file});
}

class UploadFileFailure extends UploadFileState {
  final String message;
  UploadFileFailure({required this.message});
}
