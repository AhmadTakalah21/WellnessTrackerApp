import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
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
  void onCancelTap();
}

@RoutePage()
class AddAdvView extends StatelessWidget {
  const AddAdvView({
    super.key,
    required this.advCubit,
    this.adv,
    this.onSuccess,
  });

  final AddsAndOffersCubit advCubit;
  final AdvModel? adv;
  final VoidCallback? onSuccess;
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: advCubit,
      child: AddAdvPage(
        advCubit: advCubit,
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
    this.adv,
    this.onSuccess,
  });

  final AddsAndOffersCubit advCubit;
  final AdvModel? adv;
  final VoidCallback? onSuccess;

  @override
  State<AddAdvPage> createState() => _AddAdvPageState();
}

class _AddAdvPageState extends State<AddAdvPage>
    implements AddAdvViewCallBacks {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final adv = widget.adv;
    widget.advCubit.setTitleEn(adv?.title.en);
    widget.advCubit.setTitleAr(adv?.title.ar);
    widget.advCubit.setDescriptionEn(adv?.description.en);
    widget.advCubit.setDescriptionAr(adv?.description.ar);
    widget.advCubit.setType(adv?.type);
    widget.advCubit.setEndDate(adv?.endDate);

    // widget.advCubit.setImage(adv?.image);
  }

  @override
  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.advCubit.addAdv(id: widget.adv?.id);
    }
  }

  @override
  void onCancelTap() => Navigator.pop(context);

  @override
  void dispose() {
    widget.advCubit.resetModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adv = widget.adv;
    final selectedType = AdvTypeEnum.values.firstWhereOrNull(
      (type) => type.id == adv?.type.id,
    );
    final title = widget.adv != null ? "edit" : "add";
    return Scaffold(
      appBar: AppBar(title: Text("${title}_adv".tr())),
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
                  MainTextField2(
                    initialText: adv?.title.en,
                    onChanged: widget.advCubit.setTitleEn,
                    label: 'title_en'.tr(),
                    icon: Icons.title,
                    validator: (val) =>
                        Utils.validateInput(val, InputTextType.none),
                  ),
                  MainTextField2(
                    initialText: adv?.title.ar,
                    onChanged: widget.advCubit.setTitleAr,
                    label: 'title_ar'.tr(),
                    icon: Icons.title,
                    validator: (val) =>
                        Utils.validateInput(val, InputTextType.none),
                  ),
                  MainTextField2(
                    initialText: adv?.description.en,
                    onChanged: widget.advCubit.setDescriptionEn,
                    label: 'description_en'.tr(),
                    icon: Icons.description,
                  ),
                  MainTextField2(
                    initialText: adv?.description.ar,
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
                    initialDate: adv?.endDate,
                    firstDate: DateTime.now(),
                    onDateSelected: (date) =>
                        widget.advCubit.setEndDate(date?.formatYYYYMMDD),
                    validator: (date) =>
                        date == null ? 'end_date_required'.tr() : null,
                  ),
                  ChooseImageWidget(
                    initialImage: adv?.image,
                    onSetImage: widget.advCubit.setImage,
                    validator: (_) => widget.advCubit.image == null
                        ? 'image_required'.tr()
                        : null,
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
                      child = LoadingIndicator(
                        size: 30,
                        color: context.cs.surface,
                      );
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
