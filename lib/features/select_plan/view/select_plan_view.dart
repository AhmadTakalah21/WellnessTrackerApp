import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wellnesstrackerapp/features/select_plan/cubit/user_plans_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/animations/tile_slide_animation.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

abstract class SelectPlanViewCallBacks {
  void onTryAgainTap();
  Future<void> onRefresh();
  Future<void> onLaunchPhoneTap(String? whatsappPhone);
}

@RoutePage()
class SelectPlanView extends StatelessWidget {
  const SelectPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<UserPlansCubit>(),
      child: const SelectPlanPage(),
    );
  }
}

class SelectPlanPage extends StatefulWidget {
  const SelectPlanPage({super.key});

  @override
  State<SelectPlanPage> createState() => _SelectPlanPageState();
}

class _SelectPlanPageState extends State<SelectPlanPage>
    implements SelectPlanViewCallBacks {
  late final UserPlansCubit userPlansCubit = context.read();

  @override
  void initState() {
    super.initState();
    userPlansCubit.getPlans();
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => userPlansCubit.getPlans();

  @override
  Future<void> onLaunchPhoneTap(String? whatsappPhone) async {
    if (whatsappPhone == null || whatsappPhone.isEmpty) return;

    final cleaned = whatsappPhone.replaceAll(RegExp(r'[^\d]'), '');
    final message = Uri.encodeComponent("مرحباً");
    final url = "https://wa.me/$cleaned?text=$message";

    final success =
        await launchUrlString(url, mode: LaunchMode.externalApplication);
    if (!success && context.mounted) {
      if (mounted) {
        MainSnackBar.showErrorMessage(context, "cant_open_whatsapp".tr());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('follow_up'.tr())),
      body: BlocBuilder<UserPlansCubit, GeneralUserPlansState>(
        builder: (context, state) {
          if (state is UserPlansLoading) {
            return LoadingIndicator();
          } else if (state is UserPlansSuccess) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                padding: AppConstants.padding20,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ...state.plans.plans.asMap().entries.map(
                      (entry) {
                        final index = entry.key;
                        final plan = entry.value;
                        return TileSlideAnimation(
                          index: index,
                          child: _buildGridItem(
                            context,
                            plan.department.getTitle,
                            plan.phone,
                            plan.department.getIcon,
                            plan.department.getColor,
                          ),
                        );
                      },
                    ),
                    TileSlideAnimation(
                      index: state.plans.plans.length,
                      child: _buildGridItem(
                        context,
                        "emergencies_phone",
                        state.plans.emergenciesPhone ?? "not_available".tr(),
                        Icons.emergency_rounded,
                        Colors.blueGrey,
                      ),
                    ),
                    if (state.plans.plans.length < 2)
                      SizedBox(height: (2 - state.plans.plans.length) * 250.0),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            );
          } else if (state is UserPlansEmpty) {
            return MainErrorWidget(
              error: state.message,
              isRefresh: true,
              onTryAgainTap: onTryAgainTap,
            );
          } else if (state is UserPlansFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    String name,
    String phone,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => onLaunchPhoneTap(phone),
      child: Padding(
        padding: AppConstants.padding20,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
          color: Colors.white,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withAlpha((0.2 * 255).toInt()),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 37, color: color),
              ),
              SizedBox(height: 5),
              Text(
                name.tr(),
                textAlign: TextAlign.center,
                style: context.tt.titleLarge,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    phone,
                    textAlign: TextAlign.center,
                    style: context.tt.titleMedium,
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    "assets/images/whatsapp.svg",
                    colorFilter:
                        ColorFilter.mode(context.cs.primary, BlendMode.srcIn),
                  ),
                ],
              ),
              SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
