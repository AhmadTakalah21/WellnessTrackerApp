import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/blocs/upload_image_cubit/cubit/upload_image_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/choose_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
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
    this.level,
  });

  final ItemsCubit itemCubit;
  final LevelModel? level;
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
        level: level,
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
    this.level,
  });

  final ItemsCubit itemCubit;
  final LevelModel? level;
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
    levelsCubit.getLevels(UserRoleEnum.admin);
    widget.itemCubit.setLevelId(widget.level);
    final item = widget.item;
    widget.itemCubit.setNameEn(item?.name.en);
    widget.itemCubit.setNameAr(item?.name.ar);
    widget.itemCubit.setDescriptionEn(item?.description?.en);
    widget.itemCubit.setDescriptionAr(item?.description?.ar);
    widget.itemCubit.setLink(item?.link);
    widget.itemCubit.setPrice(item?.price.toString());
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
                    initialText: item?.name.en,
                    onChanged: widget.itemCubit.setNameEn,
                    label: 'name_en'.tr(),
                    icon: Icons.title,
                    validator: (val) => val == null || val.isEmpty
                        ? 'name_en_required'.tr()
                        : null,
                  ),
                  MainTextField2(
                    initialText: item?.name.ar,
                    onChanged: widget.itemCubit.setNameAr,
                    label: 'name_ar'.tr(),
                    icon: Icons.title,
                    validator: (val) => val == null || val.isEmpty
                        ? 'name_ar_required'.tr()
                        : null,
                  ),
                  MainTextField2(
                    initialText: item?.description?.en,
                    onChanged: widget.itemCubit.setDescriptionEn,
                    label: 'description_en'.tr(),
                    icon: Icons.description,
                  ),
                  MainTextField2(
                    initialText: item?.description?.ar,
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val == null || val.isEmpty
                        ? 'price_required'.tr()
                        : null,
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
