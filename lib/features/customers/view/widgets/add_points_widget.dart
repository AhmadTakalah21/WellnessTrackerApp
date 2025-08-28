import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class AddPointsView extends StatelessWidget {
  const AddPointsView({
    super.key,
    required this.customersCubit,
    required this.role,
  });

  final CustomersCubit customersCubit;
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: customersCubit,
      child: AddPointsWidget(customersCubit: customersCubit, role: role),
    );
  }
}

class AddPointsWidget extends StatefulWidget {
  const AddPointsWidget({
    super.key,
    required this.customersCubit,
    required this.role,
  });
  final CustomersCubit customersCubit;
  final UserRoleEnum role;

  @override
  State<AddPointsWidget> createState() => _AddPointsWidgetState();
}

class _AddPointsWidgetState extends State<AddPointsWidget> {
  @override
  void dispose() {
    widget.customersCubit.resetAddPointsModel();
    super.dispose();
  }

  void onSave() => widget.customersCubit.addPoints(widget.role);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        padding: AppConstants.padding16,
        child: Column(
          spacing: 20,
          children: [
            Row(
              children: [
                Spacer(),
                SizedBox(width: 16),
                Text(
                  "add_points".tr(),
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: AppColors.greyShade),
                ),
              ],
            ),
            MainTextField2(
              onChanged: widget.customersCubit.setPoints,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              isWithTitle: false,
              label: "points".tr(),
              icon: Icons.point_of_sale,
            ),
            BlocConsumer<CustomersCubit, GeneralCustomersState>(
              listener: (context, state) {
                if (state is AddPointsSuccess) {
                  Navigator.pop(context);
                  MainSnackBar.showSuccessMessage(context, state.message);
                } else if (state is AddPointsFail) {
                  MainSnackBar.showErrorMessage(context, state.error);
                }
              },
              builder: (context, state) {
                bool isLoading = state is AddPointsLoading;
                return MainActionButton(
                  onTap: isLoading ? () {} : onSave,
                  text: "save".tr(),
                  child: isLoading
                      ? LoadingIndicator(size: 20, color: context.cs.surface)
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
