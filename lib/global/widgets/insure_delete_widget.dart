import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/global/blocs/delete_cubit/cubit/delete_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

abstract class DeleteModel {
  String get apiDeleteUrl;
}

class InsureDeleteWidget<T extends DeleteModel> extends StatefulWidget {
  const InsureDeleteWidget({super.key, required this.item, this.onSuccess});

  final T item;
  final VoidCallback? onSuccess;

  @override
  State<InsureDeleteWidget<T>> createState() => _InsureDeleteWidgetState<T>();
}

class _InsureDeleteWidgetState<T extends DeleteModel>
    extends State<InsureDeleteWidget<T>> {
  void onIgnoreTap(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<DeleteCubit>(),
      child: AlertDialog(
        backgroundColor: context.cs.surface,
        insetPadding: AppConstants.padding16,
        contentPadding: AppConstants.padding16,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "insure_delete".tr(),
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () => onIgnoreTap(context),
                  child: const Icon(Icons.close, color: AppColors.greyShade),
                ),
              ],
            ),
            const Divider(height: 30),
            Text(
              "sure_delete_item".tr(),
              style: const TextStyle(color: AppColors.black, fontSize: 16),
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MainActionButton(
                  padding: AppConstants.padding6,
                  text: "cancel".tr(),
                  onTap: () => onIgnoreTap(context),
                  shadow: AppColors.firstShadow,
                ),
                const SizedBox(width: 10),
                BlocConsumer<DeleteCubit, DeleteState>(
                  listener: (context, state) {
                    if (state is DeleteSuccess) {
                      widget.onSuccess?.call();
                      onIgnoreTap(context);
                      MainSnackBar.showSuccessMessage(context, state.message);
                    } else if (state is DeleteFail) {
                      MainSnackBar.showErrorMessage(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    var onTap = context.read<DeleteCubit>().deleteItem<T>;
                    Widget? child;
                    if (state is DeleteLoading) {
                      onTap = (T item) async {};
                      child = const LoadingIndicator();
                    }
                    return MainActionButton(
                      padding: AppConstants.padding6,
                      buttonColor: context.cs.error,
                      onTap: () => onTap(widget.item),
                      text: "save".tr(),
                      shadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(77),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      child: child,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
