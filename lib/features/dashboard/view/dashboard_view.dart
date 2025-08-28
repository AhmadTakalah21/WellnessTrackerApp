import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/features/dashboard/view/widgets/carousel_slider_widget.dart';
import 'package:wellnesstrackerapp/features/dashboard/view/widgets/dashboard_card_widget.dart';
import 'package:wellnesstrackerapp/features/dashboard/view/widgets/wave_painter.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_view_on_permission_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/animations/tile_slide_animation.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class DashboardViewCallBacks {
  void onGridItemTap(PageRouteInfo page);
  void onTryAgainTap();
  Future<void> onRefresh();
}

@RoutePage()
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<AddsAndOffersCubit>(),
      child: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with TickerProviderStateMixin
    implements DashboardViewCallBacks {
  late final SignInModel user = context.read<SignInModel>();
  late final AddsAndOffersCubit addsAndOffersCubit = context.read();

  late AnimationController _waveCtrl;
  late PageController _sliderController;
  Timer? _autoPlay;

  final ScrollController _scrollController = ScrollController();

  List<UserViewOnPermissionModel> modules = [];

  late final ValueNotifier<int> sliderIndex;

  static const List<Shadow> textShadows = [
    Shadow(color: Colors.black26, offset: Offset(1, 4), blurRadius: 4)
  ];

  @override
  void initState() {
    super.initState();
    modules = user.role.getPermissions;
    if (user.role.isUser) {
      addsAndOffersCubit.getAddsAndOffers(user.role);
      sliderIndex = ValueNotifier<int>(0);
      _waveCtrl = AnimationController(
        vsync: this,
        duration: AppConstants.duration4s,
      )..repeat();
      _sliderController = PageController(viewportFraction: .9);
    }
  }

  void _startAutoPlay(int count) async {
    if (count <= 1) {
      _autoPlay?.cancel();
      return;
    }
    _autoPlay?.cancel();
    _autoPlay = Timer(AppConstants.duration4s, () async {
      if (!mounted || !_sliderController.hasClients) return;
      final next = (sliderIndex.value + 1) % count;
      await _sliderController.animateToPage(
        next,
        duration: AppConstants.duration600ms,
        curve: Curves.easeOutCubic,
      );
      if (mounted) _startAutoPlay(count);
    });
  }

  @override
  void dispose() {
    _autoPlay?.cancel();
    if (user.role.isUser) {
      sliderIndex.dispose();
      _sliderController.dispose();
      _waveCtrl.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void onTryAgainTap() => addsAndOffersCubit.getAddsAndOffers(user.role);

  @override
  void onGridItemTap(PageRouteInfo page) => context.router.push(page);

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  Widget build(BuildContext context) {
    final isUser = user.role.isUser;

    return Scaffold(
      appBar: MainAppBar(title: 'home'.tr(), role: user.role),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            if (isUser) ...[
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: SizedBox(
                    height: 140,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _buildGradient(),
                        _buildAnimatedCircles(),
                        _buildWave(),
                        _buildAvatarWithWelcome(),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              _buildAds(),
              SliverToBoxAdapter(child: SizedBox(height: 10)),
            ],
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            _buildGridCards(),
            if (isUser) SliverToBoxAdapter(child: SizedBox(height: 120))
          ],
        ),
      ),
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.cs.primary,
              context.cs.primaryContainer.withOpacity(
                Theme.of(context).brightness == Brightness.dark ? .30 : .60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCircles() {
    return AnimatedBuilder(
      animation: Listenable.merge([_waveCtrl, _scrollController]),
      builder: (_, __) {
        final offset =
            _scrollController.hasClients ? _scrollController.offset : 0.0;
        final parallaxBase = offset * 0.08;

        return Stack(
          children: List.generate(5, (i) {
            final size = 12.0 + (i * 4);
            final waveOffset = math.sin(_waveCtrl.value * 2 * math.pi + i) * 10;
            final parallax = parallaxBase * (i + 1);

            return Positioned(
              left: 36.0 * (i + 1) + waveOffset,
              top: (i.isEven ? 36 : 78) + waveOffset - parallax,
              child: RepaintBoundary(
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.12),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildWave() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: -10,
      height: 60,
      child: AnimatedBuilder(
        animation: Listenable.merge([_waveCtrl, _scrollController]),
        builder: (_, __) {
          final offset =
              _scrollController.hasClients ? _scrollController.offset : 0.0;
          final stretch =
              offset < 0 ? (-offset * 0.4).clamp(0, 120).toDouble() : 0.0;
          return RepaintBoundary(
            child: CustomPaint(
              painter: WavePainter(
                progress: _waveCtrl.value,
                color: Colors.white,
              ),
              child: SizedBox(height: 60 + (stretch * 0.25)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatarWithWelcome() {
    final n = user.name.trim();
    final welcome = n.isEmpty ? tr('welcome') : '${tr('welcome')}, $n';
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (_, __) {
        final offset =
            _scrollController.hasClients ? _scrollController.offset : 0.0;
        final stretch =
            offset < 0 ? (-offset * 0.4).clamp(0, 120).toDouble() : 0.0;
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RepaintBoundary(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: 'profile-avatar',
                    child: GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 32 + (stretch * 0.04),
                        backgroundColor: AppColors.white.withOpacity(0.25),
                        child: const Icon(
                          Icons.person,
                          size: 32,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        welcome,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.tt.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: textShadows,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAds() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: BlocConsumer<AddsAndOffersCubit, GeneralAddsAndOffersState>(
          listener: (context, state) {
            if (state is AddsAndOffersSuccess) {
              final data = state.addsAndOffers.data;
              final ads = data.where((ad) => ad.type.isAdv).toList();
              _startAutoPlay(ads.length <= 3 ? ads.length : 3);
            }
          },
          buildWhen: (previous, current) => current is AddsAndOffersState,
          builder: (context, state) {
            if (state is AddsAndOffersLoading) {
              return LoadingIndicator();
            } else if (state is AddsAndOffersSuccess) {
              final data = state.addsAndOffers.data;
              final ads = data.where((ad) => ad.type.isAdv).toList();
              return SizedBox(
                height: 200,
                child: CarouselSliderWidget(
                  controller: _sliderController,
                  onPageChanged: (index) => sliderIndex.value = index,
                  items: ads.take(3).toList(),
                  indexListenable: sliderIndex,
                ),
              );
            } else if (state is AddsAndOffersFail) {
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
    );
  }

  Widget _buildGridCards() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final module = modules[index];
            final fromRight = index.isEven;
            return RepaintBoundary(
              child: TileSlideAnimation(
                index: index,
                beginOffset: Offset(fromRight ? 0.25 : -0.25, 0),
                animationDuration: const Duration(seconds: 2),
                deley: 70,
                child: DashboardCardWidget(
                  module: module,
                  onTap: () => onGridItemTap(module.screen),
                ),
              ),
            );
          },
          childCount: modules.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
