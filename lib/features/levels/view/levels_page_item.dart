import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/features/levels/view/widgets/level_item_widget.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/animations/tile_slide_animation.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

class LevelsPageItem extends StatelessWidget {
  const LevelsPageItem({
    super.key,
    required this.onTryAgainTap,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.role,
  });
  final UserRoleEnum role;
  final void Function() onTryAgainTap;
  final void Function(LevelModel) onEditTap;
  final void Function(LevelModel) onDeleteTap;

  Future<void> onRefresh() async => onTryAgainTap();
  void onTap(BuildContext context, LevelModel level) {
    context.router.push(ItemsRoute(role: role, level: level));
  }

  void onLongPress(BuildContext context, LevelModel level) {
    if (role.isAdmin) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
        builder: (context) => AdditionalOptionsBottomSheet(
          item: level,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelsCubit, GeneralLevelsState>(
      buildWhen: (previous, current) => current is LevelsState,
      builder: (context, state) {
        if (state is LevelsLoading) {
          return LoadingIndicator();
        } else if (state is LevelsSuccess) {
          final levels = state.levels.data;
          return RefreshIndicator(
            onRefresh: onRefresh,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                spacing: 20,
                children: [
                  ...levels.asMap().entries.map((entry) {
                    final index = entry.key;
                    final level = entry.value;
                    return TileSlideAnimation(
                      index: index,
                      child: LevelItemWidget(
                        level: level,
                        onTap: (level) => onTap(context, level),
                        onLongPress: (level) => onLongPress(context, level),
                      ),
                    );
                  }),
                  if (levels.length < 3)
                    SizedBox(height: (3 - levels.length) * 200.0),
                  SizedBox(height: role.isUser ? 100 : 40),
                ],
              ),
            ),
          );
        } else if (state is LevelsEmpty) {
          return MainErrorWidget(
            isRefresh: true,
            error: state.message,
            onTryAgainTap: onTryAgainTap,
          );
        } else if (state is LevelsFail) {
          return MainErrorWidget(
            error: state.error,
            onTryAgainTap: onTryAgainTap,
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
