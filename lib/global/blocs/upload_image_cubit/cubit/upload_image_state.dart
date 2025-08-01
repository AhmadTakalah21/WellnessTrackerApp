part of 'upload_image_cubit.dart';

@immutable
sealed class UploadImageState{}

final class UploadImageInitial extends UploadImageState {}

final class UploadImageLoading extends UploadImageState {}

final class UploadImageSuccess extends UploadImageState {
  UploadImageSuccess({
    required this.image,
    // required this.imagePath, required this.imageName
    });

    final XFile image;

  // final String imagePath;
  // final String imageName;
}

final class UploadImageFail extends UploadImageState {
  UploadImageFail(this.message);

  final String message;
}

