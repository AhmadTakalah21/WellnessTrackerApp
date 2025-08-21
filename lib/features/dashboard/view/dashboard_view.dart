// import 'package:auto_route/auto_route.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wellnesstrackerapp/features/app_manager/cubit/app_manager_cubit.dart';
// import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
// import 'package:wellnesstrackerapp/global/models/user_view_on_permission_model.dart';
// import 'package:wellnesstrackerapp/global/utils/constants.dart';
// import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';

// abstract class DashboardViewCallBacks {
//   void onGridItemTap(PageRouteInfo page);
// }

// @RoutePage()
// class DashboardView extends StatelessWidget {
//   const DashboardView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Dashboard();
//   }
// }

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard>
//     implements DashboardViewCallBacks {
//   late final AppManagerCubit appManagerCubit = context.read();
//   late final user = context.read<SignInModel>();

//   List<UserViewOnPermissionModel> modules = [];

//   @override
//   void initState() {
//     super.initState();
//     modules = user.role.getPermissions;
//   }

//   @override
//   void onGridItemTap(PageRouteInfo page) {
//     context.router.push(page);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MainAppBar(title: 'home'.tr(),),
//       body: Padding(
//         padding: AppConstants.padding10,
//         child: Column(
//           children: [
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 4,
//                   mainAxisSpacing: 3,
//                 ),
//                 itemCount: modules.length,
//                 itemBuilder: (context, index) {
//                   final module = modules[index];
//                   return _buildGridItem(context, module);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGridItem(
//     BuildContext context,
//     UserViewOnPermissionModel module,
//   ) {
//     return GestureDetector(
//       onTap: () => onGridItemTap(module.screen),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 3,
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: module.color.withAlpha((0.2 * 255).toInt()),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(module.icon, size: 37, color: module.color),
//             ),
//             const SizedBox(height: 6),
//             Padding(
//               padding: AppConstants.paddingH4,
//               child: Text(
//                 module.title.tr(),
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wellnesstrackerapp/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/global/models/user_view_on_permission_model.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';

import '../../../global/router/app_router.gr.dart';

abstract class DashboardViewCallBacks {
  void onGridItemTap(PageRouteInfo page);
}

@RoutePage()
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) => const Dashboard();
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with TickerProviderStateMixin
    implements DashboardViewCallBacks {
  late final AppManagerCubit appManagerCubit = context.read();
  late final SignInModel user = context.read<SignInModel>();

  // موجة البحر
  late final AnimationController _waveCtrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat();

  // سلايدر
  final _sliderController = PageController(viewportFraction: .9);
  Timer? _autoPlay;
  int _sliderIndex = 0;

  // Parallax Scroll
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  List<UserViewOnPermissionModel> modules = [];

  @override
  void initState() {
    super.initState();
    modules = user.role.getPermissions;
    _startAutoPlay();

    // استماع للتمرير عشان نحسب Parallax
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
  }

  void _startAutoPlay() {
    _autoPlay?.cancel();
    _autoPlay = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_sliderController.hasClients) return;
      final next = (_sliderIndex + 1) % 3;
      _sliderController.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoPlay?.cancel();
    _sliderController.dispose();
    _waveCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void onGridItemTap(PageRouteInfo page) => context.router.push(page);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = user.role.isUser;

    // شدّ الهيدر عند السحب للأسفل (stretch)
    final stretch =
        _scrollOffset < 0 ? (-_scrollOffset * 0.4).clamp(0, 120).toDouble() : 0;

    return Scaffold(
      appBar: MainAppBar(title: 'home'.tr()),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          if (isUser) ...[
            SliverToBoxAdapter(
              child: SizedBox(
                height: 140,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.primaryContainer.withOpacity(
                                theme.brightness == Brightness.dark ? .30 : .60,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ...List.generate(5, (i) {
                      final size = 12.0 + (i * 4);
                      return AnimatedBuilder(
                        animation: _waveCtrl,
                        builder: (_, __) {
                          final waveOffset =
                              math.sin(_waveCtrl.value * 2 * math.pi + i) * 10;
                          final parallax = _scrollOffset * 0.08 * (i + 1);
                          return Positioned(
                            left: 36.0 * (i + 1) + waveOffset,
                            top: (i.isEven ? 36 : 78) + waveOffset - parallax,
                            child: Container(
                              width: size,
                              height: size,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.12),
                              ),
                            ),
                          );
                        },
                      );
                    }),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -10 + _scrollOffset * 0.10, // Parallax للموجة
                      height: 60 + (stretch * 0.25), // تتمدد شوي عند السحب
                      child: AnimatedBuilder(
                        animation: _waveCtrl,
                        builder: (_, __) => CustomPaint(
                          painter: _WavePainter(
                            progress: _waveCtrl.value,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // المحتوى (الأفاتار + الترحيب) في المنتصف + Hero للأفاتار
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Hero(
                              tag: 'profile-avatar',
                              child: GestureDetector(
                                onTap: () {
                                  //TODO check out
                                  //appManagerCubit.emitBottomNavTabChanged(0);
                                  //context.tabsRouter.setActiveIndex(0);
                                  //context.router.push(ProfileRouter());
                                },
                                child: CircleAvatar(
                                  radius: 32 + (stretch * 0.04),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.25),
                                  child: const Icon(
                                    Icons.person,
                                    size: 32,
                                    color: Colors.white,
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
                                  _userTitle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      theme.textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black26,
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: SizedBox(
                  height: 200,
                  child: _HeroCarousel(
                    controller: _sliderController,
                    onPageChanged: (i) => setState(() => _sliderIndex = i),
                    items: const [
                      _CarouselItem(asset: 'assets/images/dashboard4.jpg'),
                      _CarouselItem(asset: 'assets/images/dashboard5.jpg'),
                      _CarouselItem(asset: 'assets/images/dashboard6.jpg'),
                    ],
                    index: _sliderIndex,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
          ],
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final module = modules[index];
                  final fromRight = index.isEven;
                  return _SeaTile(
                    index: index,
                    fromRight: fromRight,
                    child: _ModuleCard(
                      module: module,
                      onTap: () => onGridItemTap(module.screen),
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
          ),
          if (isUser) SliverToBoxAdapter(child: SizedBox(height: 120))
        ],
      ),
    );
  }

  String _userTitle() {
    final n = user.name.trim();
    return n.isEmpty ? tr('welcome') : '${tr('welcome')}, $n';
  }
}

/* ================================
   موجة متحركة
================================ */
class _WavePainter extends CustomPainter {
  _WavePainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final amp = size.height * .35;
    final yBase = size.height * .5;

    path.moveTo(0, yBase);
    for (double x = 0; x <= size.width; x++) {
      final t = (x / size.width * 2 * math.pi) + (progress * 2 * math.pi);
      final y = yBase + math.sin(t) * amp;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter old) =>
      old.progress != progress || old.color != color;
}

class _CarouselItem {
  const _CarouselItem({required this.asset});
  final String asset;
}

class _HeroCarousel extends StatelessWidget {
  const _HeroCarousel({
    required this.controller,
    required this.items,
    required this.index,
    required this.onPageChanged,
  });
  final PageController controller;
  final List<_CarouselItem> items;
  final int index;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            onPageChanged: onPageChanged,
            itemCount: items.length,
            itemBuilder: (_, i) {
              final it = items[i];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  //color: theme.cardColor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black12,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(it.asset, fit: BoxFit.cover),
                      //Container(color: Colors.black.withOpacity(.25)),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == index ? 20 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: i == index
                    ? theme.colorScheme.primary
                    : Colors.black.withOpacity(.15),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SeaTile extends StatefulWidget {
  const _SeaTile({
    required this.index,
    required this.fromRight,
    required this.child,
  });
  final int index;
  final bool fromRight;
  final Widget child;

  @override
  State<_SeaTile> createState() => _SeaTileState();
}

class _SeaTileState extends State<_SeaTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  late final Animation<double> _fade =
      CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: Offset(widget.fromRight ? 0.25 : -0.25, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 70 * widget.index), () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

/* ================================
   بطاقة الوحدة
================================ */
class _ModuleCard extends StatefulWidget {
  const _ModuleCard({required this.module, required this.onTap});
  final UserViewOnPermissionModel module;
  final VoidCallback onTap;

  @override
  State<_ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<_ModuleCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final m = widget.module;
    final cardColor = Theme.of(context).cardColor;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: widget.onTap,
      onHighlightChanged: (v) => setState(() => _pressed = v),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? .96 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              if (!_pressed)
                const BoxShadow(
                    blurRadius: 12,
                    color: Colors.black12,
                    offset: Offset(0, 6)),
            ],
            border: Border.all(color: m.color.withOpacity(.18), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      m.color.withOpacity(.16),
                      m.color.withOpacity(.04)
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(m.icon, size: 32, color: m.color),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: AppConstants.paddingH4,
                child: Text(
                  m.title.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12.5, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
