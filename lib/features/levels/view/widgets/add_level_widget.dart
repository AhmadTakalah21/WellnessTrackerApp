import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/choose_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class AddLevelViewCallBacks {
  void onSubmit();
}

@RoutePage()
class AddLevelView extends StatelessWidget {
  const AddLevelView({
    super.key,
    required this.levelsCubit,
    this.onSuccess,
    this.level,
  });

  final LevelsCubit levelsCubit;
  final LevelModel? level;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: levelsCubit,
      child: _AddLevelPage(
        levelsCubit: levelsCubit,
        onSuccess: onSuccess,
        level: level,
      ),
    );
  }
}

class _AddLevelPage extends StatefulWidget {
  const _AddLevelPage({
    this.onSuccess,
    this.level,
    required this.levelsCubit,
  });

  final LevelsCubit levelsCubit;
  final LevelModel? level;
  final VoidCallback? onSuccess;

  @override
  State<_AddLevelPage> createState() => _AddLevelPageState();
}

class _AddLevelPageState extends State<_AddLevelPage>
    implements AddLevelViewCallBacks {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.levelsCubit.setModel(widget.level);
  }

  @override
  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.levelsCubit.addLevel(id: widget.level?.id);
    }
  }

  @override
  void dispose() {
    widget.levelsCubit.resetModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final level = widget.level;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: AppConstants.padding20,
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitle(),
              const SizedBox(height: 8),
              _buildNameTextField(level),
              _buildDepartmentsDropDown(level),
              _buildDescriptionTextField(level),
              _buildImagePicker(level),
              const SizedBox(height: 12),
              _buildSubmitButton(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() => Center(
        child: Text(
          widget.level != null ? 'edit_level'.tr() : 'add_level'.tr(),
          style: context.tt.titleLarge,
        ),
      );

  Widget _buildNameTextField(LevelModel? level) => MainTextField2(
        initialText: level?.name,
        onChanged: widget.levelsCubit.setName,
        label: 'name'.tr(),
        icon: Icons.title,
        validator: (val) =>
            val == null || val.trim().isEmpty ? 'name_required'.tr() : null,
      );

  Widget _buildDepartmentsDropDown(LevelModel? level) {
    final initialDepartment = DepartmentEnum.values.firstWhereOrNull(
      (department) => department.id == level?.type.id,
    );
    return MainDropDownWidget<DepartmentEnum>(
      selectedValue: initialDepartment,
      items: DepartmentEnum.values,
      prefixIcon: Icons.account_tree_outlined,
      labelText: 'type'.tr(),
      hintText: 'select_type'.tr(),
      errorMessage: 'type_required'.tr(),
      onChanged: widget.levelsCubit.setType,
      isEntityName: true,
    );
  }

  Widget _buildDescriptionTextField(LevelModel? level) => MainTextField2(
        initialText: level?.description,
        onChanged: widget.levelsCubit.setDescription,
        label: 'description'.tr(),
        icon: Icons.description,
      );

  Widget _buildImagePicker(LevelModel? level) => ChooseImageWidget(
        initialImage: level?.image,
        onSetImage: widget.levelsCubit.setImage,
      );

  Widget _buildSubmitButton() => BlocConsumer<LevelsCubit, GeneralLevelsState>(
        bloc: widget.levelsCubit,
        listener: (context, state) {
          if (state is AddLevelSuccess) {
            widget.onSuccess?.call();
            Navigator.pop(context);
            MainSnackBar.showSuccessMessage(context, state.message);
          } else if (state is AddLevelFail) {
            MainSnackBar.showErrorMessage(context, state.error);
          }
        },
        builder: (context, state) {
          var onTap = onSubmit;
          Widget? child;
          if (state is AddLevelLoading) {
            onTap = () {};
            child = LoadingIndicator(size: 30, color: context.cs.surface);
          }
          return MainActionButton(
            text: 'save'.tr(),
            onTap: onTap,
            child: child,
          );
        },
      );
}
