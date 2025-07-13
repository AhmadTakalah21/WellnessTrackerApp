import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart';
import 'package:wellnesstrackerapp/global/blocs/upload_image_cubit/cubit/upload_image_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/choose_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class AddItemViewCallbacks {
  void onSubmit();
  void onImageTap();
  void onCancelTap();
}

@RoutePage()
class AddItemView extends StatelessWidget {
  const AddItemView({
    super.key,
    required this.itemCubit,
    required this.isEdit,
    this.item,
    this.onSuccess,
  });

  final ItemsCubit itemCubit;
  final bool isEdit;
  final ItemModel? item;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: itemCubit),
        BlocProvider(create: (context) => get<UploadImageCubit>()),
        BlocProvider(create: (context) => get<LevelsCubit>()),
      ],
      child: AddItemPage(
        itemCubit: itemCubit,
        isEdit: isEdit,
        item: item,
        onSuccess: onSuccess,
      ),
    );
  }
}

class AddItemPage extends StatefulWidget {
  const AddItemPage({
    super.key,
    required this.itemCubit,
    required this.isEdit,
    this.item,
    this.onSuccess,
  });

  final ItemsCubit itemCubit;
  final bool isEdit;
  final ItemModel? item;
  final VoidCallback? onSuccess;

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage>
    implements AddItemViewCallbacks {
  late final UploadImageCubit uploadImageCubit = context.read();
  late final LevelsCubit levelsCubit = context.read();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    levelsCubit.getLevels();
    final item = widget.item;
    widget.itemCubit.setNameEn(item?.name);
    widget.itemCubit.setNameAr(item?.name);
    widget.itemCubit.setDescriptionEn(item?.description);
    widget.itemCubit.setDescriptionAr(item?.description);
    widget.itemCubit.setLink(item?.link);
    widget.itemCubit.setPrice(item?.price.toString());
    widget.itemCubit.setLevelId(item?.level);
  }

  @override
  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.itemCubit.addItem(isAdd: !widget.isEdit, id: widget.item?.id);
    }
  }

  @override
  void onImageTap() => uploadImageCubit.uploadImage();

  @override
  void onCancelTap() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'edit_item'.tr() : 'add_item'.tr(),
          style: context.tt.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MainTextField2(
                    //initialText: item?.name,
                    onChanged: widget.itemCubit.setNameEn,
                    label: 'name_en'.tr(),
                    icon: Icons.title,
                    validator: (val) => val == null || val.isEmpty
                        ? 'name_en_required'.tr()
                        : null,
                  ),
                  MainTextField2(
                    //initialText: item?.name,
                    onChanged: widget.itemCubit.setNameAr,
                    label: 'name_ar'.tr(),
                    icon: Icons.title,
                    validator: (val) => val == null || val.isEmpty
                        ? 'name_ar_required'.tr()
                        : null,
                  ),
                  MainTextField2(
                    //initialText: item?.description,
                    onChanged: widget.itemCubit.setDescriptionEn,
                    label: 'description_en'.tr(),
                    icon: Icons.description,
                  ),
                  MainTextField2(
                    //initialText: item?.description,
                    onChanged: widget.itemCubit.setDescriptionAr,
                    label: 'description_ar'.tr(),
                    icon: Icons.description,
                  ),
                  MainTextField2(
                    initialText: item?.link,
                    onChanged: widget.itemCubit.setLink,
                    label: 'link'.tr(),
                    icon: Icons.link,
                    validator: (val) => val == null || val.isEmpty
                        ? 'link_required'.tr()
                        : null,
                  ),
                  MainTextField2(
                    initialText: item?.price.toStringAsFixed(2),
                    onChanged: widget.itemCubit.setPrice,
                    label: 'price'.tr(),
                    icon: Icons.price_change,
                    validator: (val) => val == null || val.isEmpty
                        ? 'price_required'.tr()
                        : null,
                  ),
                  MainDropDownWidget<DepartmentEnum>(
                    items: DepartmentEnum.values,
                    prefixIcon: Icons.account_tree_outlined,
                    labelText: 'type'.tr(),
                    hintText: 'select_type'.tr(),
                    errorMessage: 'type_required'.tr(),
                    onChanged: levelsCubit.setRoleFilter,
                    isEntityName: true,
                  ),
                  BlocBuilder<LevelsCubit, GeneralLevelsState>(
                    builder: (context, state) {
                      if (state is LevelsLoading) {
                        return LoadingIndicator();
                      } else if (state is LevelsSuccess) {
                        final selectedLevel =
                            state.levels.data.firstWhereOrNull(
                          (level) => level.id == item?.level.id,
                        );
                        return MainDropDownWidget(
                          items: state.levels.data,
                          selectedValue: selectedLevel,
                          prefixIcon: Icons.bar_chart,
                          hintText: 'level'.tr(),
                          labelText: 'level'.tr(),
                          errorMessage: 'required_field'.tr(),
                          onChanged: widget.itemCubit.setLevelId,
                        );
                      } else if (state is LevelsFail) {
                        return MainErrorWidget(
                          error: state.error,
                          onTryAgainTap: () => levelsCubit.getLevels(),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  BlocConsumer<UploadImageCubit, UploadImageState>(
                    listener: (context, state) {
                      if (state is UploadImageSuccess) {
                        widget.itemCubit.setImage(state.image);
                      } else if (state is UploadImageFail) {
                        MainSnackBar.showErrorMessage(context, state.message);
                        widget.itemCubit.setImage(null);
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
                        initialImage: item?.image,
                        onTap: onImageTap,
                        filePath: imagePath,
                      );
                    },
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocConsumer<ItemsCubit, GeneralItemsState>(
                  listener: (context, state) {
                    if (state is AddItemSuccess) {
                      widget.onSuccess?.call();
                      onCancelTap();
                      MainSnackBar.showSuccessMessage(context, state.message);
                    } else if (state is AddItemFail) {
                      MainSnackBar.showErrorMessage(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    var onTap = onSubmit;
                    Widget? child;
                    if (state is AddItemLoading) {
                      onTap = () {};
                      child = const LoadingIndicator(size: 30);
                    }
                    return MainActionButton(
                      text: 'save'.tr(),
                      onTap: onTap,
                      child: child,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
