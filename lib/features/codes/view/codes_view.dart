import 'package:auto_route/annotations.dart';
import 'package:auto_route_generator/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/codes/cubit/codes_cubit.dart';
import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
import 'package:wellnesstrackerapp/global/blocs/delete_cubit/cubit/delete_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

@RoutePage()
class CodesView extends StatelessWidget {
  const CodesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => get<CodesCubit>()..getCodes(isLoadMore: false)),
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

class _CodesPageState extends State<CodesPage> {
  late final CodesCubit codesCubit = context.read();
  late final DeleteCubit deleteCubit = context.read();

  int perPage = 10;
  int currentPage = 1;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text(
          'codes_management'.tr(),
          style: context.tt.titleLarge,
        ),
      ),
      backgroundColor: context.cs.onSurface,
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() => searchText = value);
                      codesCubit.searchCodes(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'search_code_hint'.tr(),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<int>(
                  value: perPage,
                  items: [10, 25, 50]
                      .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => perPage = value);
                      codesCubit.getCodes(perPage: value, isLoadMore: false);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                      header: 'codes_management'.tr(),
                      titles: CodeModel.header,
                      items: state.codes,
                      onPageChanged: (page, perPage) {
                        setState(() => currentPage = page);
                        codesCubit.getCodes(perPage: perPage, isLoadMore: false);
                      },
                      onEditTap: (code) {
                        // TODO: Show modal to edit
                      },
                      onDeleteTap: (code) => showDialog(
                        context: context,
                        builder: (_) => InsureDeleteWidget(
                          deleteCubit: deleteCubit,
                          item: code,
                          onSaveTap: (c) => deleteCubit.deleteItem<CodeModel>(code),
                          onSuccess: () => codesCubit.getCodes(isLoadMore: false),
                        ),
                      ),
                      emptyMessage: state.emptyMessage,
                    );

                  } else if (state is CodesEmpty) {
                    return MainErrorWidget(
                      error: state.message,
                      onTryAgainTap: () => codesCubit.getCodes(isLoadMore: false),
                      isRefresh: true,
                    );
                  } else if (state is CodesFail) {
                    return MainErrorWidget(
                      error: state.error,
                      onTryAgainTap: () => codesCubit.getCodes(isLoadMore: false),
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
        onTap: () {
          // TODO: Add modal for adding code
        },
      ),
    );
  }
}
