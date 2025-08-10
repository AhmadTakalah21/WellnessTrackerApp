import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_model/plan_day_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/keep_alive_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_tab_bar.dart';

abstract class MealsViewCallbacks {
  void onTabSelected(int index);
  void onTryAgainTap();
  Future<void> onRefresh();
}

@RoutePage()
class MealsView extends StatelessWidget {
  const MealsView({super.key, required this.role});

  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<MealPlansCubit>(),
      child: MealsPage(role: role),
    );
  }
}

class MealsPage extends StatefulWidget {
  const MealsPage({super.key, required this.role});
  final UserRoleEnum role;

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage>
    with TickerProviderStateMixin
    implements MealsViewCallbacks {
  late final MealPlansCubit mealPlansCubit = context.read();

  PageController pageController = PageController();
  late TabController tabController;
  int selectedTab = 0;

  String get _baseUrl => 'https://dev-mi.serv00.net';

  bool _isWebUrl(String s) => s.startsWith('http://') || s.startsWith('https://');

  bool _isVideo(String s) {
    final l = s.toLowerCase();
    return l.endsWith('.mp4') || l.endsWith('.mov') || l.endsWith('.mkv') || l.endsWith('.webm');
  }

  bool _isImage(String s) {
    final l = s.toLowerCase();
    return l.endsWith('.png') || l.endsWith('.jpg') || l.endsWith('.jpeg') || l.endsWith('.gif') || l.endsWith('.webp');
  }

  String _absoluteLink(String link) {
    if (link.isEmpty) return '';
    return _isWebUrl(link) ? link : '$_baseUrl/$link';
  }

  IconData _iconForLink(String raw) {
    final url = _absoluteLink(raw);
    if (url.isEmpty) return Icons.link_off;
    if (_isVideo(url)) return Icons.play_circle_fill;
    if (_isImage(url)) return Icons.image;
    return Icons.link;
  }

  Future<void> _openExternal(String url) async {
    final ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('cannot_open_link'.tr())),
      );
    }
  }

  void _onOpenMedia(String raw) {
    final url = _absoluteLink(raw);
    if (url.isEmpty) return;

    if (_isVideo(url)) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => VideoPlayerPage(url: url)),
      );
    } else if (_isImage(url)) {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InteractiveViewer(
            minScale: 0.7,
            maxScale: 4,
            child: Image.network(url, fit: BoxFit.contain),
          ),
        ),
      );
    } else {
      _openExternal(url);
    }
  }


  @override
  void initState() {
    super.initState();
    mealPlansCubit.getMealPlans(widget.role);
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => mealPlansCubit.getMealPlans(widget.role);

  @override
  void onTabSelected(int index) {
    setState(() => selectedTab = index);
    tabController.animateTo(index);
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('meals'.tr())),
      body: BlocBuilder<MealPlansCubit, GeneralMealPlansState>(
        buildWhen: (previous, current) => current is MealPlansState,
        builder: (context, state) {
          if (state is MealPlansLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is MealPlansSuccess) {
            final meals = state.mealPlans.data;
            final tabBarTitles =
            meals.last.planDays.map((e) => e.day.displayName).toList();
            tabController =
                TabController(length: tabBarTitles.length, vsync: this);
            return Column(
              children: [
                MainTabBar(
                  titles: meals.last.planDays
                      .map((e) => e.day.displayName)
                      .toList(),
                  tabController: tabController,
                  onTapSelected: onTabSelected,
                  selectedTab: selectedTab,
                ),
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    onPageChanged: onTabSelected,
                    itemCount: meals.last.planDays.length,
                    itemBuilder: (context, index) {
                      final planDay = meals.last.planDays[index];
                      return Padding(
                        padding: AppConstants.padding16,
                        child: KeepAliveWidget(child: _buildPage(planDay)),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is MealPlansEmpty) {
            return MainErrorWidget(
              error: state.message,
              isRefresh: true,
              onTryAgainTap: onTryAgainTap,
            );
          } else if (state is MealPlansFail) {
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

  Widget _buildPage(PlanDayModel planDay) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        padding: AppConstants.paddingH10,
        physics: const BouncingScrollPhysics(),
        child: Column(
          spacing: 20,
          children: [
            ...List.generate(planDay.meals.length, (index) {
              final meal = planDay.meals[index];
              return _buildMealItem(meal);
            }),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildMealItem(MealModel meal) {
    final link = _absoluteLink(meal.link);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  meal.name,
                  style: context.tt.titleLarge?.copyWith(
                    color: context.cs.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...meal.ingredients.map((ingredientWithQnt) {
              final ingredient = ingredientWithQnt.ingredient;
              return Container(
                margin: AppConstants.paddingV10,
                padding: AppConstants.padding12,
                decoration: BoxDecoration(
                  color: context.cs.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ingredient.name,
                      style: context.tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutrient(
                          icon: Icons.local_drink,
                          label: "الكمية",
                          value: ingredientWithQnt.quantity.toString(),
                        ),
                        _buildNutrient(
                          icon: Icons.local_fire_department,
                          label: "السعرات",
                          value: ingredient.calories,
                        ),
                        _buildNutrient(
                          icon: Icons.fitness_center,
                          label: "البروتين",
                          value: ingredient.proteins,
                        ),
                        _buildNutrient(
                          icon: Icons.bubble_chart,
                          label: "الكربوهيدرات",
                          value: ingredient.carbs,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: AppConstants.paddingH20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (link.isNotEmpty && (_isVideo(link) || _isImage(link))) ...[
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => _onOpenMedia(meal.link),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (_isImage(link))
                                Image.network(link, fit: BoxFit.cover)
                              else
                                Container(color: Colors.black.withOpacity(0.08)),
                              const Center(
                                child: Icon(Icons.play_circle_fill, size: 56, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("طريقة التحضير :", style: context.tt.titleLarge),
                      if (meal.link.isNotEmpty)
                        IconButton(
                          tooltip: 'open_instruction'.tr(),
                          icon: Icon(
                            _iconForLink(meal.link),
                            color: context.cs.primary,
                            size: 30,
                          ),
                          onPressed: () => _onOpenMedia(meal.link),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(meal.description, style: context.tt.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrient({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blueAccent),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key, required this.url});
  final String url;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoCtrl;
  ChewieController? _chewieCtrl;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _videoCtrl = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await _videoCtrl.initialize();
    _chewieCtrl = ChewieController(
      videoPlayerController: _videoCtrl,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
      materialProgressColors: ChewieProgressColors(),
    );
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _chewieCtrl?.dispose();
    _videoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('video'.tr())),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
        child: AspectRatio(
          aspectRatio: _videoCtrl.value.aspectRatio == 0
              ? 16 / 9
              : _videoCtrl.value.aspectRatio,
          child: Chewie(controller: _chewieCtrl!),
        ),
      ),
    );
  }
}
