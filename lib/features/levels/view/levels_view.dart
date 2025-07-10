import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/keep_alive_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_tab_bar.dart';

abstract class LevelsViewCallBacks {
  void onAddTap();
  void onTabSelected(int index);
}

@RoutePage()
class LevelsView extends StatelessWidget {
  const LevelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LevelsPage();
  }
}

class LevelsPage extends StatefulWidget {
  const LevelsPage({super.key});

  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage>
    with SingleTickerProviderStateMixin
    implements LevelsViewCallBacks {
  PageController pageController = PageController();
  late TabController tabController;
  int selectedTab = 0;

  final List<String> tabBarTitles =
      DepartmentEnum.values.map((e) => e.displayEntityName).toList();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabBarTitles.length, vsync: this);
  }

  @override
  void onTabSelected(int index) {
    setState(() => selectedTab = index);
    tabController.animateTo(index);
    pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  void onAddTap() {
    // TODO: implement onAddTap
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = DepartmentEnum.values.map((department) {
      final levels = List.generate(
          5,
          (index) => {
                'title': 'المستوى ${index + 1}',
                'description':
                    'هذا المستوى يكون متاح عند المشترك عندما يصبح مجموع نقاطه اكبر من ${1000 * (index + 1)}',
                'image': "assets/images/app_logo.png",
              });

      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          spacing: 20,
          children: [
            ...levels.map(
              (level) => _LevelCard(
                title: level['title']!,
                description: level['description']!,
                image: level['image']!,
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('levels'.tr(), style: context.tt.titleLarge),
      ),
      body: Column(
        children: [
          MainTabBar(
            titles: tabBarTitles,
            tabController: tabController,
            onTapSelected: onTabSelected,
            selectedTab: selectedTab,
            isScrollable: false,
          ),
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              onPageChanged: onTabSelected,
              itemCount: pages.length,
              itemBuilder: (context, index) => Padding(
                padding: AppConstants.padding16,
                child: KeepAliveWidget(child: pages[index]),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: MainFloatingButton(
        onTap: onAddTap,
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const _LevelCard({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 5 / 2,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: context.tt.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(description,
                    style: context.tt.bodyMedium
                        ?.copyWith(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
