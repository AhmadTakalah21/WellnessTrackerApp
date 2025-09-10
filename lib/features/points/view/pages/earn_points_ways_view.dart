import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellnesstrackerapp/features/points/cubit/points_cubit.dart';
import 'package:wellnesstrackerapp/features/points/model/points_guideline_model/points_guideline_model.dart';
import 'package:wellnesstrackerapp/features/points/view/widgets/add_points_guideline_widget.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/localization/supported_locales.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/animations/tile_slide_animation.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class EarnPointsWaysViewCallBacks {
  void onAddTap();
  void onTap(PointsGuidelineModel guideline);
  void onEditTap(PointsGuidelineModel guideline);
  void onDeleteTap(PointsGuidelineModel guideline);
  Future<void> launchLink(String url);
  Future<void> onRefresh();
  void onTryAgainTap();
}

@RoutePage()
class EarnPointsWaysView extends StatelessWidget {
  const EarnPointsWaysView({super.key, required this.role});
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<PointsCubit>(),
      child: EarnPointsWaysPage(role: role),
    );
  }
}

class EarnPointsWaysPage extends StatefulWidget {
  const EarnPointsWaysPage({super.key, required this.role});
  final UserRoleEnum role;

  @override
  State<EarnPointsWaysPage> createState() => _EarnPointsWaysPageState();
}

class _EarnPointsWaysPageState extends State<EarnPointsWaysPage>
    implements EarnPointsWaysViewCallBacks {
  late final PointsCubit pointsCubit = context.read();
  late final locale = context.locale;
  late final isArabic = locale == SupportedLocales.arabic;

  @override
  void initState() {
    super.initState();
    pointsCubit.getPointsGuideLines(widget.role, page: 1, perPage: 10000);
  }

  @override
  Future<void> launchLink(String url) async {
    final ok =
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('cannot_open_link'.tr())),
      );
    }
  }

  @override
  void onTap(PointsGuidelineModel guideline) {
    if (widget.role.isAdmin) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
        builder: (context) => AdditionalOptionsBottomSheet(
          item: guideline,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
        ),
      );
    } else {
      if (guideline.link != null) {
        launchLink(guideline.link!);
      }
    }
  }

  @override
  void onAddTap() {
    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (bottomSheetContext) => AddPointsGuidelineView(
        pointsCubit: pointsCubit,
        onSuccess: onTryAgainTap,
      ),
    );
  }

  @override
  void onDeleteTap(PointsGuidelineModel guideline) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) =>
          InsureDeleteWidget(item: guideline, onSuccess: onTryAgainTap),
    );
  }

  @override
  void onEditTap(PointsGuidelineModel guideline) {
    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (bottomSheetContext) => AddPointsGuidelineView(
        pointsCubit: pointsCubit,
        guideline: guideline,
        onSuccess: onTryAgainTap,
      ),
    );
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() =>
      pointsCubit.getPointsGuideLines(widget.role, page: 1, perPage: 10000);

  @override
  Widget build(BuildContext context) {
    final role = widget.role;
    return Scaffold(
      appBar:
          role.isAdmin ? AppBar(title: Text("get_points_methods".tr())) : null,
      body: Padding(
        padding: role.isAdmin ? AppConstants.padding16 : AppConstants.padding0,
        child: BlocBuilder<PointsCubit, GeneralPointsState>(
          buildWhen: (previous, current) => current is PointsGuidelinesState,
          builder: (context, state) {
            if (state is PointsGuidelinesLoading) {
              return LoadingIndicator();
            } else if (state is PointsGuidelinesSuccess) {
              final data = state.pointsGuidelines.data;
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...data.asMap().entries.map((entry) {
                        final index = entry.key;
                        final guideline = entry.value;
                        return TileSlideAnimation(
                          index: index,
                          child: _buildTile(guideline),
                        );
                      }),
                      if (data.length < 10)
                        SizedBox(height: (10 - data.length) * 80.0),
                      if (widget.role.isUser) SizedBox(height: 120),
                    ],
                  ),
                ),
              );
            } else if (state is PointsGuidelinesEmpty) {
              return MainErrorWidget(
                error: state.message,
                isRefresh: true,
                onTryAgainTap: onTryAgainTap,
              );
            } else if (state is PointsGuidelinesFail) {
              return MainErrorWidget(
                error: state.error,
                onTryAgainTap: onTryAgainTap,
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
      floatingActionButton:
          role.isAdmin ? MainFloatingButton(onTap: onAddTap) : null,
    );
  }

  Widget _buildTile(PointsGuidelineModel guideline) {
    final title = isArabic ? guideline.title.ar : guideline.title.en;
    final description =
        isArabic ? guideline.description.ar : guideline.description.en;
    return InkWell(
      onTap: () => onTap(guideline),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: context.cs.primary.withOpacity(0.1),
            child: Icon(Icons.trending_up, color: context.cs.primary),
          ),
          title: Text(title ?? "title", style: context.tt.bodyLarge),
          subtitle: Text(
            description ?? "description",
            style: context.tt.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
