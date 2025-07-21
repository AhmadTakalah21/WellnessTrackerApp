import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/codes/model/add_code_model/add_code_model.dart';
import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
import 'package:wellnesstrackerapp/features/codes/service/codes_service.dart';
import '../../../global/models/meta_model/meta_model.dart';
import '../../../global/models/paginated_model/paginated_model.dart';

part 'states/codes_state.dart';
part 'states/add_code_state.dart';
part 'states/general_codes_state.dart';

@injectable
class CodesCubit extends Cubit<GeneralCodesState> {
  CodesCubit(this.codeService) : super(GeneralCodesInitial());
  final CodesService codeService;

  AddCodeModel addCodeModel = const AddCodeModel();

  List<CodeModel> codes = [];
  MetaModel? meta;

  String lastQuery = '';
  String? lastStatus;

  void setModel(CodeModel? code) {
    setCode(code?.code);
    setStartDate(code?.startDate);
    setEndDate(code?.endDate);
  }

  void setCode(String? code) {
    addCodeModel = addCodeModel.copyWith(code: () => code);
  }

  void setStartDate(String? startDate) {
    addCodeModel = addCodeModel.copyWith(startDate: () => startDate);
  }

  void setEndDate(String? endDate) {
    addCodeModel = addCodeModel.copyWith(endDate: () => endDate);
  }

  // void setDepartment(DepartmentEnum? department) {
  //   addCodeModel = addCodeModel.copyWith(department: () => department);
  // }

  void resetAddCodeModel() {
    addCodeModel = const AddCodeModel();
  }

  Future<void> getCodes({required int page, int perPage = 10}) async {
    emit(CodesLoading());
    try {
      if (isClosed) return;
      final result = await codeService.getCodes(page: page, perPage: perPage);
      codes = result.data;
      meta = result.meta;
      final message = result.data.isEmpty ? "no_codes".tr() : null;
      if (page == 1 && result.data.isEmpty) {
        emit(CodesEmpty("no_codes".tr()));
      } else {
        emit(CodesSuccess(result, message));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CodesFail(e.toString()));
    }
  }

  void searchCodes(String query, {String? status}) {
    lastQuery = query;
    lastStatus = status;

    final filtered = _applyFilters(codes, query, status);
    final meta = this.meta != null && (query.isEmpty && status == null)
        ? this.meta!
        : MetaModel(
            total: filtered.length,
            count: filtered.length,
            perPage: filtered.length,
            currentPage: 1,
            totalPages: 1,
          );

    final result = PaginatedModel<CodeModel>(data: filtered, meta: meta);
    emit(CodesSuccess(result, filtered.isEmpty ? "no_codes".tr() : null));
  }

  List<CodeModel> _applyFilters(
    List<CodeModel> source,
    String query,
    String? status,
  ) {
    return source.where((code) {
      final matchesQuery =
          code.code.toLowerCase().contains(query.toLowerCase());
      final matchesStatus =
          status == null || code.status.toLowerCase() == status.toLowerCase();
      return matchesQuery && matchesStatus;
    }).toList();
  }

  Future<void> addCode({int? id}) async {
    emit(AddCodeLoading());
    try {
      final response = await codeService.addCode(addCodeModel, id: id);
      final isAdd = id == null;
      final message = isAdd ? "code_added".tr() : "code_updated".tr();
      emit(AddCodeSuccess(response, message));
    } catch (e) {
      emit(AddCodeFail(e.toString()));
    }
  }
}
