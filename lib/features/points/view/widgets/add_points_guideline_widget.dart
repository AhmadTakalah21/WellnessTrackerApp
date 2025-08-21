import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/points/cubit/points_cubit.dart';
import 'package:wellnesstrackerapp/features/points/model/points_guideline_model/points_guideline_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class AddPointsGuidelineViewCallbacks {
  void onSubmit();
  void onCancelTap();
}

@RoutePage()
class AddPointsGuidelineView extends StatelessWidget {
  const AddPointsGuidelineView({
    super.key,
    required this.pointsCubit,
    this.guideline,
    this.onSuccess,
  });

  final PointsCubit pointsCubit;
  final PointsGuidelineModel? guideline;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: pointsCubit,
      child: AddPointsGuidelinePage(
        pointsCubit: pointsCubit,
        guideline: guideline,
        onSuccess: onSuccess,
      ),
    );
  }
}

class AddPointsGuidelinePage extends StatefulWidget {
  const AddPointsGuidelinePage({
    super.key,
    required this.pointsCubit,
    this.guideline,
    this.onSuccess,
  });

  final PointsCubit pointsCubit;
  final PointsGuidelineModel? guideline;
  final VoidCallback? onSuccess;

  @override
  State<AddPointsGuidelinePage> createState() => _AddPointsGuidelinePageState();
}

class _AddPointsGuidelinePageState extends State<AddPointsGuidelinePage>
    implements AddPointsGuidelineViewCallbacks {
  late final PointsCubit pointsCubit = context.read();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.pointsCubit.setModel(widget.guideline);
  }

  @override
  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.pointsCubit.addPointsGuideLine(id: widget.guideline?.id);
    }
  }

  @override
  void onCancelTap() => Navigator.pop(context);

  @override
  void dispose() {
    widget.pointsCubit.resetModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final guideline = widget.guideline;
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
                  _buildNameEnTextField(guideline),
                  _buildNameArTextField(guideline),
                  _buildDescriptionEnTextField(guideline),
                  _buildDescriptionArTextField(guideline),
                  _buildLinkTextField(guideline),
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
      title: Text(widget.guideline != null
          ? 'edit_guideline'.tr()
          : 'add_guideline'.tr()));

  Widget _buildNameEnTextField(PointsGuidelineModel? guideline) =>
      MainTextField2(
        initialText: guideline?.title.en,
        onChanged: widget.pointsCubit.setTitleEn,
        label: 'title_en'.tr(),
        icon: Icons.title,
        validator: (val) =>
            val == null || val.isEmpty ? 'title_en_required'.tr() : null,
      );

  Widget _buildNameArTextField(PointsGuidelineModel? guideline) =>
      MainTextField2(
        initialText: guideline?.title.ar,
        onChanged: widget.pointsCubit.setTitleAr,
        label: 'title_ar'.tr(),
        icon: Icons.title,
        validator: (val) =>
            val == null || val.isEmpty ? 'title_ar_required'.tr() : null,
      );

  Widget _buildDescriptionEnTextField(PointsGuidelineModel? guideline) =>
      MainTextField2(
        initialText: guideline?.description.en,
        onChanged: widget.pointsCubit.setDescriptionEn,
        label: 'description_en'.tr(),
        icon: Icons.description,
        validator: (val) =>
            val == null || val.isEmpty ? 'description_en_required'.tr() : null,
      );

  Widget _buildDescriptionArTextField(PointsGuidelineModel? guideline) =>
      MainTextField2(
        initialText: guideline?.description.ar,
        onChanged: widget.pointsCubit.setDescriptionAr,
        label: 'description_ar'.tr(),
        icon: Icons.description,
        validator: (val) =>
            val == null || val.isEmpty ? 'description_ar_required'.tr() : null,
      );

  Widget _buildLinkTextField(PointsGuidelineModel? guideline) => MainTextField2(
        initialText: guideline?.link,
        onChanged: widget.pointsCubit.setLink,
        label: 'link'.tr(),
        icon: Icons.link,
        validator: (val) =>
            val == null || val.isEmpty ? 'link_required'.tr() : null,
      );

  Widget _buildSubmitButton() => Padding(
        padding: AppConstants.padding20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocConsumer<PointsCubit, GeneralPointsState>(
              listener: (context, state) {
                if (state is AddPointsGuidelineSuccess) {
                  widget.onSuccess?.call();
                  onCancelTap();
                  MainSnackBar.showSuccessMessage(context, state.message);
                } else if (state is AddPointsGuidelineFail) {
                  MainSnackBar.showErrorMessage(context, state.error);
                }
              },
              builder: (context, state) {
                var onTap = onSubmit;
                Widget? child;
                if (state is AddPointsGuidelineLoading) {
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
