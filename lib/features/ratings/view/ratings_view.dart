import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/ratings/cubit/ratings_cubit.dart';
import 'package:wellnesstrackerapp/features/ratings/model/rating_model/rating_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class RatingsViewCallBacks {
  void onTryAgainTap();
  Future<void> onRefresh();
}

@RoutePage()
class RatingsView extends StatelessWidget {
  const RatingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<RatingsCubit>(),
      child: const RatingsPage(),
    );
  }
}

class RatingsPage extends StatefulWidget {
  const RatingsPage({super.key});

  @override
  State<RatingsPage> createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage>
    implements RatingsViewCallBacks {
  late final RatingsCubit ratingsCubit = context.read();

  @override
  void initState() {
    super.initState();
    ratingsCubit.getRatings(page: 1, perPage: 100000);
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => ratingsCubit.getRatings(page: 1, perPage: 100000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ratings".tr())),
      body: BlocBuilder<RatingsCubit, GeneralRatingsState>(
        buildWhen: (previous, current) => current is RatingsState,
        builder: (context, state) {
          if (state is RatingsLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is RatingsSuccess) {
            final ratings = state.ratings.data;
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                padding: AppConstants.padding20,
                physics: BouncingScrollPhysics(),
                child: Column(
                  spacing: 20,
                  children: [
                    ...ratings.map((rate) => _buildRateTile(rate)),
                    SizedBox(height: 100)
                  ],
                ),
              ),
            );
          } else if (state is RatingsEmpty) {
            return MainErrorWidget(
              error: state.message,
              isRefresh: true,
              onTryAgainTap: onTryAgainTap,
            );
          } else if (state is RatingsFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildRateTile(RatingModel rate) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: AppConstants.padding20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(rate.user.name, style: context.tt.headlineSmall),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          rate.rating,
                          (index) {
                            return Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                              size: 30.0,
                            );
                          },
                        )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                        child:
                            Text(rate.comment, style: context.tt.titleMedium)),
                    Text(rate.createdAt.formatYYYYMMDD,
                        style: context.tt.bodySmall
                            ?.copyWith(color: context.cs.onSecondaryFixed)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
