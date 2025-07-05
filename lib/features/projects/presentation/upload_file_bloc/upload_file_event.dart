// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_file_bloc.dart';

abstract class UploadFileEvent {}

class UploadFileRequested extends UploadFileEvent {
  final PlatformFile file;
  UploadFileRequested({required this.file});
}
