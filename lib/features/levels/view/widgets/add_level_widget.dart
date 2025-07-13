import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/blocs/upload_image_cubit/cubit/upload_image_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
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
    required this.isEdit,
    this.onSuccess,
    this.level,
  });

  final LevelsCubit levelsCubit;
  final LevelModel? level;
  final bool isEdit;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: levelsCubit,
        ),
        BlocProvider(
          create: (context) => get<UploadImageCubit>(),
        ),
      ],
      child: _AddLevelPage(
        isEdit: isEdit,
        levelsCubit: levelsCubit,
        onSuccess: onSuccess,
        level: level,
      ),
    );
  }
}

class _AddLevelPage extends StatefulWidget {
  const _AddLevelPage({
    required this.isEdit,
    this.onSuccess,
    this.level,
    required this.levelsCubit,
  });

  final LevelsCubit levelsCubit;
  final bool isEdit;
  final LevelModel? level;
  final VoidCallback? onSuccess;

  @override
  State<_AddLevelPage> createState() => _AddLevelPageState();
}

class _AddLevelPageState extends State<_AddLevelPage>
    implements AddLevelViewCallBacks {
  final _formKey = GlobalKey<FormState>();

  @override
  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.levelsCubit.addLevel(isAdd: !widget.isEdit, id: widget.level?.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final level = widget.level;
    final initialDepartment = DepartmentEnum.values.firstWhereOrNull(
      (department) => department.id == level?.type.id,
    );
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
              Center(
                child: Text(
                  widget.isEdit ? 'edit_level'.tr() : 'add_level'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              MainTextField2(
                initialText: level?.name,
                onChanged: widget.levelsCubit.setName,
                label: 'name'.tr(),
                icon: Icons.title,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'name_required'.tr()
                    : null,
              ),
              MainDropDownWidget<DepartmentEnum>(
                selectedValue: initialDepartment,
                items: DepartmentEnum.values,
                prefixIcon: Icons.account_tree_outlined,
                labelText: 'type'.tr(),
                hintText: 'select_type'.tr(),
                errorMessage: 'type_required'.tr(),
                onChanged: widget.levelsCubit.setType,
                isEntityName: true,
              ),
              MainTextField2(
                initialText: level?.description,
                onChanged: widget.levelsCubit.setDescription,
                label: 'description'.tr(),
                icon: Icons.description,
                validator: (_) => null,
              ),
              BlocConsumer<UploadImageCubit, UploadImageState>(
                listener: (context, state) {
                  if (state is UploadImageSuccess) {
                    widget.levelsCubit.setImage(state.image);
                  } else if (state is UploadImageFail) {
                    MainSnackBar.showErrorMessage(
                      context,
                      state.message,
                    );
                    widget.levelsCubit.setImage(null);
                  }
                },
                builder: (context, state) {
                  String? imagePath;
                  if (state is UploadImageSuccess) {
                    imagePath = state.image.path;
                  } else if (state is UploadImageFail) {
                    imagePath = state.message;
                  }
                  return ChooseImageWidget(
                    initialImage: level?.image,
                    onTap: context.read<UploadImageCubit>().uploadImage,
                    filePath: imagePath,
                  );
                },
              ),
              const SizedBox(height: 12),
              BlocConsumer<LevelsCubit, GeneralLevelsState>(
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
                    child = const LoadingIndicator(size: 30);
                  }
                  return MainActionButton(
                    text: widget.isEdit ? 'update'.tr() : 'save'.tr(),
                    onTap: onTap,
                    child: child,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
