import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
import 'package:wellnesstrackerapp/features/codes/service/codes_service.dart';

part 'states/codes_state.dart';
part 'states/general_codes_state.dart';

@injectable
class CodesCubit extends Cubit<GeneralCodesState> {
  CodesCubit(this.codeService) : super(GeneralCodesInitial());

  final CodesService codeService;

  int page = 1;
  bool hasMore = true;
  List<CodeModel> codes = [];

  Future<void> getCodes({int perPage = 10, bool isLoadMore = true}) async {
    if (!hasMore && isLoadMore) return;
    if (!isLoadMore) {
      page = 1;
      hasMore = true;
      codes.clear();
    }
    emit(CodesLoading());
    try {
      final newCodes = await codeService.getCodes(page: page, perPage: perPage);
      if (newCodes.data.isEmpty) {
        hasMore = false;
        if (page == 1) emit(CodesEmpty("no_codes".tr()));
      } else {
        codes.addAll(newCodes.data);
        page++;
        emit(CodesSuccess(codes));
      }
    } catch (e) {
      emit(CodesFail(e.toString()));
    }
  }
}
