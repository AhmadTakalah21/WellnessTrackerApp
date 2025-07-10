import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:wellnesstrackerapp/features/auth_manager/bloc/auth_manager_bloc.dart';
import 'package:wellnesstrackerapp/features/intro/view/intro_page_item.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';

class IntroPageModel {
  IntroPageModel({
    required this.images,
    required this.title,
    required this.subTitle,
  });
  final List<String> images;
  final String title;
  final String subTitle;
}

abstract class IntroViewCallBacks {
  void onNextTap();
  void onSkipTap();
}

@RoutePage()
class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return const IntroPage();
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> implements IntroViewCallBacks {
  late final AuthManagerBloc authManagerBloc = context.read();

  int selectedPage = 0;
  final pageController = PageController();

  final introPageModels = [
    IntroPageModel(
      images: ["assets/images/dashboard1.jpg", "assets/images/dashboard2.jpg"],
      title: "تتبع العادات لتحسين صحتك",
      subTitle:
          "ابدأ رحلتك الصحية عبر تتبع عاداتك اليومية مثل النشاط، الأكل الصحي، النوم والماء.",
    ),
    IntroPageModel(
      images: ["assets/images/dashboard3.jpg", "assets/images/dashboard4.jpg"],
      title: 'نظام فعال لتتبع تقدمك',
      subTitle:
          'اعتمد أسلوباً بسيطاً وفعالاً يساعدك على التغيير الإيجابي والبقاء ملتزماً بأهدافك.',
    ),
    IntroPageModel(
      images: ["assets/images/dashboard5.jpg", "assets/images/dashboard6.jpg"],
      title: 'خطوات صغيرة نحو تغيير كبير',
      subTitle:
          'تتبع العادات يسهّل عليك تبني روتين يومي صحي ومتوازن ويمنحك شعوراً بالإنجاز.',
    ),
  ];

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        final page = pageController.page;
        if (page != null) selectedPage = page.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void onNextTap() {
    if (selectedPage == introPageModels.length - 1) {
      onSkipTap();
      return;
    }
    pageController.nextPage(
      duration: AppConstants.duration1s,
      curve: Curves.easeInOut,
    );
  }

  @override
  void onSkipTap() {
    authManagerBloc.add(OnBoardingViewedRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.padding16,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: introPageModels
                      .map((item) => IntroPageItem(item: item))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              SmoothPageIndicator(
                effect: WormEffect(
                  activeDotColor: context.cs.primary,
                  dotHeight: 12,
                  dotWidth: 12,
                  type: WormType.thinUnderground,
                ),
                controller: pageController,
                count: introPageModels.length,
              ),
              const SizedBox(height: 20),
              MainActionButton(onTap: onNextTap, text: 'next'.tr()),
              const SizedBox(height: 20),
              DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      offset: Offset(0, 3),
                      color: context.cs.surface.withValues(alpha: 0.2),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: AnimatedSizeAndFade.showHide(
                  show: selectedPage != introPageModels.length - 1,
                  child: MainActionButton(
                    onTap: onNextTap,
                    text: 'skip'.tr(),
                    buttonColor: context.cs.onSurface,
                    textColor: context.cs.primary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
