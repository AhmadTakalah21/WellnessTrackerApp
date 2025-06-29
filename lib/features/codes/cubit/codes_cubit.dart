import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
import 'package:wellnesstrackerapp/features/codes/service/codes_service.dart';
import '../../../global/models/meta_model/meta_model.dart';
import '../../../global/models/paginated_model/paginated_model.dart';

part 'states/codes_state.dart';
part 'states/general_codes_state.dart';

@injectable
class CodesCubit extends Cubit<GeneralCodesState> {
  CodesCubit(this.codeService) : super(GeneralCodesInitial());

  final CodesService codeService;

  // int page = 1;
  // bool hasMore = true;
  List<CodeModel> codes = [];
  String lastQuery = '';
  String? lastStatus;
  String? lastDepartment;

  Future<void> getCodes({
    required int page,
    int perPage = 10,
    //bool isLoadMore = true,
    String query = '',
    String? status,
    String? departmentName,
  }) async {
    // if (!hasMore && isLoadMore) return;

    // if (!isLoadMore) {
    //   page = 1;
    //   hasMore = true;
    //   codes.clear();
    // }

    emit(CodesLoading());
    try {
      if (isClosed) return;
      final result = await codeService.getCodes(page: page, perPage: perPage);
      codes = result.data;
      emit(CodesSuccess(result, result.data.isEmpty ? "no_users".tr() : null));

      // if (result.data.isEmpty && page == 1) {
      //   emit(CodesEmpty("no_codes".tr()));
      //   return;
      // }

      // if (result.data.isEmpty) {
      //   hasMore = false;
      //   return;
      // }

      // codes.addAll(result.data);
      // page++;

      // lastQuery = query;
      // lastStatus = status;
      // lastDepartment = departmentName;

      // final filtered = _applyFilters(codes, query, status, departmentName);
      // final filteredResult = PaginatedModel<CodeModel>(
      //   data: filtered,
      //   meta: MetaModel(
      //     total: filtered.length,
      //     count: filtered.length,
      //     perPage: perPage,
      //     currentPage: 1,
      //     totalPages: 1,
      //   ),
      // );

      // emit(CodesSuccess(filteredResult, filtered.isEmpty ? "no_codes".tr() : null));
    } catch (e) {
      if (isClosed) return;
      emit(CodesFail(e.toString()));
    }
  }

  void searchCodes(String query, {String? status, String? departmentName}) {
    lastQuery = query;
    lastStatus = status;
    lastDepartment = departmentName;

    final filtered = _applyFilters(codes, query, status, departmentName);
    final result = PaginatedModel<CodeModel>(
      data: filtered,
      meta: MetaModel(
        total: filtered.length,
        count: filtered.length,
        perPage: filtered.length,
        currentPage: 1,
        totalPages: 1,
      ),
    );

    emit(CodesSuccess(result, filtered.isEmpty ? "no_codes".tr() : null));
  }

  List<CodeModel> _applyFilters(List<CodeModel> source, String query,
      String? status, String? department) {
    return source.where((code) {
      final matchesQuery =
          code.code.toLowerCase().contains(query.toLowerCase());
      final matchesStatus =
          status == null || code.status.toLowerCase() == status.toLowerCase();
      final matchesDepartment = department == null ||
          code.department.name.toLowerCase() == department.toLowerCase();
      return matchesQuery && matchesStatus && matchesDepartment;
    }).toList();
  }
}
