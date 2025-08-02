part of 'upload_file_cubit.dart';

@immutable
sealed class UploadFileState {}

final class UploadFileInitial extends UploadFileState {}

final class UploadFileLoading extends UploadFileState {}

final class UploadFileSuccess extends UploadFileState {
  UploadFileSuccess({required this.filePath, required this.fileName});

  final String filePath;
  final String fileName;
}

final class UploadFileFail extends UploadFileState {
  UploadFileFail(this.message);

  final String message;
}
