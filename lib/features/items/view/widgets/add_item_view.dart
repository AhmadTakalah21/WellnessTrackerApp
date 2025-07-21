import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/choose_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class AddItemViewCallbacks {
  void onSubmit();
  void onCancelTap();
}

@RoutePage()
class AddItemView extends StatelessWidget {
  const AddItemView({
    super.key,
    required this.itemCubit,
    this.item,
    this.onSuccess,
    this.level,
  });

  final ItemsCubit itemCubit;
  final LevelModel? level;
  final ItemModel? item;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: itemCubit),
        BlocProvider(create: (context) => get<LevelsCubit>()),
      ],
      child: AddItemPage(
        itemCubit: itemCubit,
        level: level,
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
    this.item,
    this.onSuccess,
    this.level,
  });

  final ItemsCubit itemCubit;
  final LevelModel? level;
  final ItemModel? item;
  final VoidCallback? onSuccess;

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage>
    implements AddItemViewCallbacks {
  late final LevelsCubit levelsCubit = context.read();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    levelsCubit.getLevels(UserRoleEnum.admin);
    widget.itemCubit.setModel(widget.item, widget.level);
  }

  @override
  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.itemCubit.addItem(id: widget.item?.id);
    }
  }

  @override
  void onCancelTap() => Navigator.pop(context);

  @override
  void dispose() {
    widget.itemCubit.resetModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: AppConstants.padding20,
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildNameEnTextField(item),
                  _buildNameArTextField(item),
                  _buildDescriptionEnTextField(item),
                  _buildDescriptionArTextField(item),
                  _buildLinkTextField(item),
                  _buildPriceTextField(item),
                  _buildImagePicker(item),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: Text(
          widget.item != null ? 'edit_item'.tr() : 'add_item'.tr(),
          style: context.tt.titleLarge,
        ),
        centerTitle: true,
      );

  Widget _buildNameEnTextField(ItemModel? item) => MainTextField2(
        initialText: item?.name.en,
        onChanged: widget.itemCubit.setNameEn,
        label: 'name_en'.tr(),
        icon: Icons.title,
        validator: (val) =>
            val == null || val.isEmpty ? 'name_en_required'.tr() : null,
      );

  Widget _buildNameArTextField(ItemModel? item) => MainTextField2(
        initialText: item?.name.ar,
        onChanged: widget.itemCubit.setNameAr,
        label: 'name_ar'.tr(),
        icon: Icons.title,
        validator: (val) =>
            val == null || val.isEmpty ? 'name_ar_required'.tr() : null,
      );

  Widget _buildDescriptionEnTextField(ItemModel? item) => MainTextField2(
        initialText: item?.description?.en,
        onChanged: widget.itemCubit.setDescriptionEn,
        label: 'description_en'.tr(),
        icon: Icons.description,
        validator: (val) =>
            val == null || val.isEmpty ? 'description_en_required'.tr() : null,
      );

  Widget _buildDescriptionArTextField(ItemModel? item) => MainTextField2(
        initialText: item?.description?.ar,
        onChanged: widget.itemCubit.setDescriptionAr,
        label: 'description_ar'.tr(),
        icon: Icons.description,
        validator: (val) =>
            val == null || val.isEmpty ? 'description_ar_required'.tr() : null,
      );

  Widget _buildLinkTextField(ItemModel? item) => MainTextField2(
        initialText: item?.link,
        onChanged: widget.itemCubit.setLink,
        label: 'link'.tr(),
        icon: Icons.link,
        validator: (val) =>
            val == null || val.isEmpty ? 'link_required'.tr() : null,
      );

  Widget _buildPriceTextField(ItemModel? item) => MainTextField2(
        initialText: item?.price.toStringAsFixed(2),
        onChanged: widget.itemCubit.setPrice,
        label: 'price'.tr(),
        icon: Icons.price_change,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (val) =>
            val == null || val.isEmpty ? 'price_required'.tr() : null,
      );

  Widget _buildImagePicker(ItemModel? item) => ChooseImageWidget(
        initialImage: item?.image,
        onSetImage: widget.itemCubit.setImage,
      );

  Widget _buildSubmitButton() => Padding(
        padding: AppConstants.padding20,
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
                  child = LoadingIndicator(size: 30, color: context.cs.surface);
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
      );
}
