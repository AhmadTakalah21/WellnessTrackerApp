import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/global/blocs/upload_image_cubit/cubit/upload_image_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/choose_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_date_picker.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';
import 'package:wellnesstrackerapp/global/models/adv_type_enum.dart';

abstract class AddAdvViewCallBacks {
  void onSubmit();
  void onImageTap();
  void onCancelTap();
}

@RoutePage()
class AddAdvView extends StatelessWidget {
  const AddAdvView({
    super.key,
    required this.advCubit,
    required this.isEdit,
    this.adv,
    this.onSuccess,
  });

  final AddsAndOffersCubit advCubit;
  final bool isEdit;
  final AdvModel? adv;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: advCubit),
        BlocProvider(create: (context) => get<UploadImageCubit>()),
      ],
      child: AddAdvPage(
        advCubit: advCubit,
        isEdit: isEdit,
        adv: adv,
        onSuccess: onSuccess,
      ),
    );
  }
}

class AddAdvPage extends StatefulWidget {
  const AddAdvPage({
    super.key,
    required this.advCubit,
    required this.isEdit,
    this.adv,
    this.onSuccess,
  });

  final AddsAndOffersCubit advCubit;
  final bool isEdit;
  final AdvModel? adv;
  final VoidCallback? onSuccess;

  @override
  State<AddAdvPage> createState() => _AddAdvPageState();
}

class _AddAdvPageState extends State<AddAdvPage>
    implements AddAdvViewCallBacks {
  late final UploadImageCubit uploadImageCubit = context.read();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // TODO check this after updating AdvModel from backend
    final adv = widget.adv;
    // widget.advCubit.setTitleEn(adv?.titleEn);
    // widget.advCubit.setTitleAr(adv?.titleAr);
    // widget.advCubit.setDescriptionEn(adv?.descriptionEn);
    // widget.advCubit.setDescriptionAr(adv?.descriptionAr);
    widget.advCubit.setType(adv?.type);
    widget.advCubit.setEndDate(adv?.expDate);
    // widget.advCubit.setImage(adv?.image);
  }

  @override
  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.advCubit.addAdv(isAdd: !widget.isEdit, id: widget.adv?.id);
    }
  }

  @override
  void onImageTap() => uploadImageCubit.uploadImage();

  @override
  void onCancelTap() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final adv = widget.adv;
    final selectedType = AdvTypeEnum.values.firstWhereOrNull(
      (type) => type.id == adv?.type.id,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isEdit
                ? 'edit_advertisement'.tr()
                : 'add_advertisement'.tr(),
            style: context.tt.titleLarge),
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
                    //initialText: adv?.titleEn,
                    onChanged: widget.advCubit.setTitleEn,
                    label: 'title_en'.tr(),
                    icon: Icons.title,
                    validator: (val) => val == null || val.isEmpty
                        ? 'title_en_required'.tr()
                        : null,
                  ),
                  MainTextField2(
                    //initialText: adv?.titleAr,
                    onChanged: widget.advCubit.setTitleAr,
                    label: 'title_ar'.tr(),
                    icon: Icons.title,
                    validator: (val) => val == null || val.isEmpty
                        ? 'title_ar_required'.tr()
                        : null,
                  ),
                  MainTextField2(
                    // initialText: adv?.descriptionEn,
                    onChanged: widget.advCubit.setDescriptionEn,
                    label: 'description_en'.tr(),
                    icon: Icons.description,
                  ),
                  MainTextField2(
                    //initialText: adv?.descriptionAr,
                    onChanged: widget.advCubit.setDescriptionAr,
                    label: 'description_ar'.tr(),
                    icon: Icons.description,
                  ),
                  MainDropDownWidget<AdvTypeEnum>(
                    selectedValue: selectedType,
                    items: AdvTypeEnum.values,
                    prefixIcon: Icons.category,
                    labelText: 'type'.tr(),
                    hintText: 'type'.tr(),
                    errorMessage: 'type_required'.tr(),
                    onChanged: widget.advCubit.setType,
                  ),
                  MainDatePicker(
                    initialDate: adv?.expDate,
                    onDateSelected: (date) =>
                        widget.advCubit.setEndDate(date?.formatYYYYMMDD),
                    validator: (date) =>
                        date == null ? 'end_date_required'.tr() : null,
                  ),
                  BlocConsumer<UploadImageCubit, UploadImageState>(
                    listener: (context, state) {
                      if (state is UploadImageSuccess) {
                        widget.advCubit.setImage(state.image);
                      } else if (state is UploadImageFail) {
                        MainSnackBar.showErrorMessage(
                          context,
                          state.message,
                        );
                        widget.advCubit.setImage(null);
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
                        initialImage: adv?.image,
                        onTap: onImageTap,
                        filePath: imagePath,
                        validator: (image) =>
                            image == null ? 'image_required'.tr() : null,
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
                BlocConsumer<AddsAndOffersCubit, GeneralAddsAndOffersState>(
                  listener: (context, state) {
                    if (state is AddAdvSuccess) {
                      widget.onSuccess?.call();
                      onCancelTap();
                      MainSnackBar.showSuccessMessage(context, state.message);
                    } else if (state is AddAdvFail) {
                      MainSnackBar.showErrorMessage(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    var onTap = onSubmit;
                    Widget? child;
                    if (state is AddAdvLoading) {
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
