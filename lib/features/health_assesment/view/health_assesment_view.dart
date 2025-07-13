import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wellnesstrackerapp/features/auth_manager/bloc/auth_manager_bloc.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';

abstract class HealthAssesmentViewCallBacks {
  void onNextTap();
}

@RoutePage()
class HealthAssesmentView extends StatelessWidget {
  const HealthAssesmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HealthAssesmentPage();
  }
}

class HealthAssesmentPage extends StatefulWidget {
  const HealthAssesmentPage({super.key});

  @override
  State<HealthAssesmentPage> createState() => _HealthAssesmentPageState();
}

class _HealthAssesmentPageState extends State<HealthAssesmentPage>
    implements HealthAssesmentViewCallBacks {
  late final AuthManagerBloc authManagerBloc = context.read();
  int selectedPage = 0;

  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void onNextTap() {
    if (selectedPage == 1) {
      authManagerBloc.add(IsAuthenticatedOrFirstTime());
      return;
    }
    pageController.nextPage(
      duration: AppConstants.duration1s,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // ActivityLevelScreen(),
      // SleepHoursScreen(),
      // WaterIntakeScreen(),
      // DietaryPreferencesScreen(),
      // HealthGoalsScreen(),
      // StressFrequencyScreen(),
      // AlcoholSmokingScreen(),
      // PreExistingConditionsScreen(),
      // WorkoutPreferenceScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: pages,
              ),
            ),
            const SizedBox(height: 20),
            SmoothPageIndicator(
              effect: const WormEffect(
                activeDotColor: Color.fromRGBO(115, 103, 240, 1),
                dotHeight: 12,
                dotWidth: 12,
                type: WormType.thinUnderground,
              ),
              controller: pageController,
              count: pages.length,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: AppConstants.paddingH16,
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: MainActionButton(
                      onTap: onNextTap,
                      text: 'Next'.tr(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
