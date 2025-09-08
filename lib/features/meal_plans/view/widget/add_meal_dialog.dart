import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wellnesstrackerapp/features/ingredients/cubit/ingredients_cubit.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';
import 'package:wellnesstrackerapp/features/ingredients/view/widgets/add_ingredient_widget.dart';
import 'package:wellnesstrackerapp/features/meals/cubit/meals_cubit.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/meal_type_enum.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/models/video_type_enum.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/check_box_selector_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/choose_file_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_counter_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';
import 'package:wellnesstrackerapp/global/widgets/mutli_selector_drop_down.dart';

abstract class AddMealViewCallBacks {
  void onVideoTypeChnaged(VideoTypeEnum type);
  void onAddIngredient();
  //void updateQuantityForIngredient(bool isAdd, int index);
  void onLongPress(IngredientModel ingredient);
  void onEditTap(IngredientModel ingredient);
  void onDeleteTap(IngredientModel ingredient);
  void onTryAgainTap();
  void onSave();
}

@RoutePage()
class AddMealView extends StatelessWidget {
  const AddMealView({super.key, required this.mealsCubit, this.meal});
  final MealsCubit mealsCubit;
  final MealModel? meal;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: mealsCubit),
        BlocProvider(create: (context) => get<IngredientsCubit>()),
      ],
      child: AddMealPage(meal: meal),
    );
  }
}

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key, this.meal});
  final MealModel? meal;

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage>
    implements AddMealViewCallBacks {
  late final MealsCubit mealsCubit = context.read();
  late final IngredientsCubit ingredientsCubit = context.read();

  final _formKey = GlobalKey<FormState>();
  bool isLink = true;

  @override
  void initState() {
    super.initState();
    mealsCubit.setModel(widget.meal);
    ingredientsCubit.getIngredients(
      UserRoleEnum.dietitian,
      perPage: 100000,
      meal: widget.meal,
    );
  }

  @override
  void onVideoTypeChnaged(VideoTypeEnum type) {
    setState(() {
      isLink = !isLink;
    });
  }

  @override
  void onAddIngredient() {
    showDialog(
      context: context,
      builder: (_) {
        return AddIngredientView(ingredientsCubit: ingredientsCubit);
      },
    );
  }

  @override
  void onLongPress(IngredientModel ingredient) {
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      context: context,
      builder: (context) {
        return AdditionalOptionsBottomSheet(
          item: ingredient,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
        );
      },
    );
  }

  @override
  void onEditTap(IngredientModel ingredient) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) {
        return AddIngredientView(
          ingredientsCubit: ingredientsCubit,
          ingredient: ingredient,
        );
      },
    );
  }

  @override
  void onDeleteTap(IngredientModel ingredient) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
          item: ingredient,
          onSuccess: () {
            Navigator.pop(context);
            ingredientsCubit.getIngredients(
              UserRoleEnum.dietitian,
              perPage: 10000,
            );
          }),
    );
  }

  @override
  void onTryAgainTap() =>
      ingredientsCubit.getIngredients(UserRoleEnum.dietitian, perPage: 100000);

  @override
  void onSave() {
    if (_formKey.currentState!.validate()) {
      mealsCubit.addMeal(id: widget.meal?.id);
    }
  }

  @override
  void dispose() {
    mealsCubit.resetModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;
    final selectedType = MealTypeEnum.values.firstWhereOrNull(
      (type) => type.id == meal?.type.id,
    );
    return Scaffold(
      appBar: MainAppBar(
        automaticallyImplyLeading: true,
        title: "add_meal".tr(),
        hasLogout: false,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: AppConstants.padding20,
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 20,
            children: [
              MainTextField2(
                initialText: meal?.name,
                onChanged: mealsCubit.setName,
                label: 'name'.tr(),
                icon: Icons.edit_outlined,
                validator: (val) =>
                    Utils.validateInput(val, InputTextType.none),
              ),
              MainTextField2(
                initialText: meal?.description,
                onChanged: mealsCubit.setDescription,
                label: 'description'.tr(),
                icon: Icons.description,
                maxLines: null,
                validator: (val) =>
                    Utils.validateInput(val, InputTextType.none),
              ),
              MainDropDownWidget(
                selectedValue: selectedType,
                items: MealTypeEnum.values,
                prefixIcon: Icons.food_bank,
                hintText: "type".tr(),
                labelText: "type".tr(),
                onChanged: mealsCubit.setType,
              ),
              Row(
                children: [
                  CheckBoxSelectorWidget(
                    title: "video".tr(),
                    selected: VideoTypeEnum.link,
                    items: VideoTypeEnum.values,
                    onSelected: onVideoTypeChnaged,
                  ),
                  SizedBox(width: 20),
                  if (isLink)
                    Expanded(
                      child: MainTextField2(
                        initialText: meal?.link,
                        onChanged: mealsCubit.setLink,
                        hint: 'link'.tr(),
                        icon: Icons.link,
                        validator: (val) =>
                            Utils.validateInput(val, InputTextType.none),
                      ),
                    ),
                  if (!isLink)
                    Expanded(
                        child: ChooseFileWidget(
                      initialFile: meal?.link,
                      onSetFile: mealsCubit.setFile,
                      validator: (_) => mealsCubit.filePath == null
                          ? 'file_required'.tr()
                          : null,
                    ))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: _buildIngredientsMultiSelector(meal)),
                  _buildAddIngredientButton(),
                ],
              ),
              BlocBuilder<MealsCubit, GeneralMealsState>(
                buildWhen: (previous, current) =>
                    current is SelectedIngredientsState,
                builder: (context, state) {
                  if (state is SelectedIngredientsState) {
                    return Column(
                      spacing: 10,
                      children: [
                        ...List.generate(
                          state.ingredients.length,
                          (index) {
                            final ingredient = state.ingredients[index];
                            return MainCounterWidget(
                              onChanged: (value) => mealsCubit
                                  .updateQuantityForIngredient(value, index),
                              initialCount:
                                  mealsCubit.ingredients[index].quantity,
                              label: "quantity_for_ingredient".tr(args: [
                                ingredient.ingredient.name,
                                ingredient.ingredient.unit.displayName
                              ]),
                              icon: Icons.format_list_numbered_outlined,
                              isRequired:true ,
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              BlocConsumer<MealsCubit, GeneralMealsState>(
                listener: (context, state) {
                  if (state is AddMealSuccess) {
                    Navigator.pop(context);
                    mealsCubit.getMeals();
                    MainSnackBar.showSuccessMessage(context, state.message);
                  } else if (state is AddMealFail) {
                    MainSnackBar.showErrorMessage(context, state.error);
                  }
                },
                builder: (context, state) {
                  return MainActionButton(
                    onTap: onSave,
                    text: "save".tr(),
                    isLoading: state is AddMealLoading,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddIngredientButton() {
    return TextButton.icon(
      onPressed: onAddIngredient,
      icon: const Icon(Icons.add, color: Colors.teal),
      label: Text(
        "add_ingredient".tr(),
        style: const TextStyle(color: Colors.teal),
      ),
    );
  }

  Widget _buildIngredientsMultiSelector(MealModel? meal) {
    return BlocBuilder<IngredientsCubit, GeneralIngredientsState>(
      buildWhen: (previous, current) => current is IngredientsState,
      builder: (context, state) {
        if (state is IngredientsLoading) {
          return LoadingIndicator();
        } else if (state is IngredientsSuccess) {
          if (state.selected != null) {
            mealsCubit.setIngredientsInitial(state.selected!);
          }
          return MutliSelectorDropDown(
            selectedValues: state.selected?.map((e) => e.ingredient).toList(),
            items: state.ingredients.data,
            prefixIcon: Icons.subscriptions,
            hintText: "ingredients".tr(),
            labelText: "ingredients".tr(),
            onLongPress: onLongPress,
            onChanged: (value) => mealsCubit.setIngredients(value),
            validator: (value) =>
                mealsCubit.ingredients.isEmpty ? "required".tr() : null,
          );
        } else if (state is IngredientsEmpty) {
          return MainErrorWidget(
            error: state.message,
            onTryAgainTap: onTryAgainTap,
            isRefresh: true,
          );
        } else if (state is IngredientsFail) {
          return MainErrorWidget(
            error: state.error,
            onTryAgainTap: onTryAgainTap,
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
