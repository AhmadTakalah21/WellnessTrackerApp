import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

part 'share_state.dart';

@injectable
class ShareCubit extends Cubit<ShareState> {
  ShareCubit() : super(ShareInitial());

  Future<void> share(String url, String title) async {
    emit(ShareLoading());
    try {
      await SharePlus.instance.share(ShareParams(title: title, text: url));
      emit(ShareSuccess());
    } catch (e, stack) {
      debugPrint("Stack trace: $stack");
      emit(ShareFail(e.toString()));
    }
  }
}
