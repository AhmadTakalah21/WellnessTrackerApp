import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wellnesstrackerapp/features/ingredients/cubit/ingredients_cubit.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';
import 'package:wellnesstrackerapp/global/models/ingredient_unit_enum.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class AddIngredientViewCallBacks {
  void onCancel();
  void onSave();
}

class AddIngredientView extends StatelessWidget {
  const AddIngredientView({
    super.key,
    required this.ingredientsCubit,
    this.ingredient,
    this.onSuccess,
  });
  final IngredientsCubit ingredientsCubit;
  final IngredientModel? ingredient;
  final void Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ingredientsCubit,
      child: AddIngredientWidget(ingredient: ingredient),
    );
  }
}

class AddIngredientWidget extends StatefulWidget {
  const AddIngredientWidget({super.key, this.ingredient});
  final IngredientModel? ingredient;

  @override
  State<AddIngredientWidget> createState() => _AddIngredientWidgetState();
}

class _AddIngredientWidgetState extends State<AddIngredientWidget>
    implements AddIngredientViewCallBacks {
  late final IngredientsCubit ingredientsCubit = context.read();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ingredientsCubit.setModel(widget.ingredient);
  }

  @override
  void onCancel() => Navigator.pop(context);

  @override
  void onSave() {
    if (_formKey.currentState!.validate()) {
      ingredientsCubit.addIngredient(id: widget.ingredient?.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ingredient = widget.ingredient;
    final selectedUnit = IngredientUnitEnum.values.firstWhereOrNull(
      (unit) => unit.id == ingredient?.unit.id,
    );
    return Dialog(
      insetPadding: const EdgeInsets.all(40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "add_ingredient".tr(),
                  style: context.tt.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.cs.primary,
                  ),
                ),
                const SizedBox(height: 24),
                MainTextField2(
                  initialText: ingredient?.name,
                  onChanged: ingredientsCubit.setName,
                  label: 'name'.tr(),
                  icon: Icons.edit_outlined,
                  validator: (val) =>
                      Utils.validateInput(val, InputTextType.none),
                ),
                const SizedBox(height: 5),
                MainDropDownWidget(
                  selectedValue: selectedUnit,
                  items: IngredientUnitEnum.values,
                  prefixIcon: Icons.scale,
                  hintText: "unit".tr(),
                  labelText: "unit".tr(),
                  onChanged: ingredientsCubit.setUnit,
                ),
                const SizedBox(height: 5),
                MainTextField2(
                  initialText: ingredient?.calories,
                  onChanged: ingredientsCubit.setCalories,
                  label: 'calories'.tr(),
                  icon: Icons.local_fire_department,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (val) =>
                      Utils.validateInput(val, InputTextType.none),
                ),
                const SizedBox(height: 5),
                MainTextField2(
                  initialText: ingredient?.carbs,
                  onChanged: ingredientsCubit.setCarbs,
                  label: 'carbs'.tr(),
                  icon: Icons.bakery_dining,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (val) =>
                      Utils.validateInput(val, InputTextType.none),
                ),
                const SizedBox(height: 5),
                MainTextField2(
                  initialText: ingredient?.proteins,
                  onChanged: ingredientsCubit.setProteins,
                  label: 'proteins'.tr(),
                  icon: FontAwesomeIcons.egg,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (val) =>
                      Utils.validateInput(val, InputTextType.none),
                ),
                const SizedBox(height: 30),
                _buildMainActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: MainActionButton(
            onTap: onCancel,
            text: "cancel".tr(),
            textColor: context.cs.primary,
            buttonColor: context.cs.surface,
            icon: Icon(Icons.close, color: context.cs.primary),
            shadow: AppColors.secondShadow,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: BlocConsumer<IngredientsCubit, GeneralIngredientsState>(
            listener: (context, state) {
              if (state is AddIngredientSuccess) {
                onCancel();
                ingredientsCubit.getIngredients(UserRoleEnum.dietitian);
                MainSnackBar.showSuccessMessage(context, state.message);
              } else if (state is AddIngredientFail) {
                MainSnackBar.showErrorMessage(context, state.error);
              }
            },
            builder: (context, state) {
              return MainActionButton(
                onTap: onSave,
                text: "save".tr(),
                isLoading: state is AddIngredientLoading,
              );
            },
          ),
        )
      ],
    );
  }
}
