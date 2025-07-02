import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/codes/cubit/codes_cubit.dart';
import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
import 'package:wellnesstrackerapp/features/codes/view/widgets/add_code_widget.dart';
import 'package:wellnesstrackerapp/global/blocs/delete_cubit/cubit/delete_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class UsersViewCallBacks {
  void onAddTap();
  void onEditTap(CodeModel code);
  void onDeleteTap(CodeModel code);
  void onSelectPageTap(int page, int perPage);
  void onSearchChanged(String input);
  Future<void> onRefresh();
  void onTryAgainTap();
}

@RoutePage()
class CodesView extends StatelessWidget {
  const CodesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => get<CodesCubit>()..getCodes(page: 1),
        ),
        BlocProvider(create: (context) => get<DeleteCubit>()),
      ],
      child: const CodesPage(),
    );
  }
}

class CodesPage extends StatefulWidget {
  const CodesPage({super.key});

  @override
  State<CodesPage> createState() => _CodesPageState();
}

class _CodesPageState extends State<CodesPage> implements UsersViewCallBacks {
  late final CodesCubit codesCubit = context.read();
  late final DeleteCubit deleteCubit = context.read();

  int perPage = 10;
  int currentPage = 1;

  @override
  void onAddTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => AddCodeWidget(
        codesCubit: codesCubit,
        isEdit: false,
      ),
    );
  }

  @override
  void onDeleteTap(CodeModel code) {
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
        deleteCubit: deleteCubit,
        item: code,
        onSaveTap: (c) => deleteCubit.deleteItem<CodeModel>(code),
        onSuccess: () => codesCubit.getCodes(page: 1, perPage: 10),
      ),
    );
  }

  @override
  void onEditTap(CodeModel code) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => AddCodeWidget(
        codesCubit: codesCubit,
        code: code,
        isEdit: true,
      ),
    );
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onSelectPageTap(int page, int perPage) {
    setState(() {
      currentPage = page;
      this.perPage = perPage;
    });
    codesCubit.getCodes(page: currentPage, perPage: perPage);
  }

  @override
  void onSearchChanged(String input) => codesCubit.searchCodes(input);

  @override
  void onTryAgainTap() => codesCubit.getCodes(
        page: currentPage,
        perPage: perPage,
      );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text(
          CodeModel.header,
          style: context.tt.titleLarge,
        ),
      ),
      backgroundColor: context.cs.onSurface,
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CodesCubit, GeneralCodesState>(
                builder: (context, state) {
                  if (state is CodesLoading) {
                    return LoadingIndicator(
                      color: context.cs.primary,
                      height: height / 1.2,
                    );
                  } else if (state is CodesSuccess) {
                    return MainDataTable<CodeModel>(
                      titles: CodeModel.titles,
                      items: state.codes,
                      onPageChanged: onSelectPageTap,
                      onEditTap: onEditTap,
                      onDeleteTap: onDeleteTap,
                      emptyMessage: state.emptyMessage,
                      onSearchChanged: onSearchChanged,
                      searchHint: 'search_code',
                    );
                  } else if (state is CodesEmpty) {
                    return MainErrorWidget(
                      error: state.message,
                      onTryAgainTap: onTryAgainTap,
                      isRefresh: true,
                    );
                  } else if (state is CodesFail) {
                    return MainErrorWidget(
                      error: state.error,
                      onTryAgainTap: onTryAgainTap,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: MainFloatingButton(
        onTap: onAddTap,
      ),
    );
  }
}
