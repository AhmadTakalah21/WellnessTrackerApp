import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'upload_file_state.dart';

@injectable
class UploadFileCubit extends Cubit<UploadFileState> {
  UploadFileCubit() : super(UploadFileInitial());

  Future<void> uploadFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      final path = result?.files.single.path;

      if (path != null) {
        emit(
          UploadFileSuccess(
            filePath: path,
            fileName: basename(path),
          ),
        );
      } else {
        emit(UploadFileFail('no_file_chosen'.tr()));
      }
    } catch (e) {
      emit(UploadFileFail('no_file_chosen'.tr()));
    }
  }
}
