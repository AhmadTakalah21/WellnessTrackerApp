import 'package:auto_route/auto_route.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Tab|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: true,
          transitionsBuilder: TransitionsBuilders.noTransition,
          page: SplashRoute.page,
        ),
        AdaptiveRoute(
          page: AuthManagerRoute.page,
          children: [
            AdaptiveRoute(page: IntroRoute.page),
            AdaptiveRoute(
              page: AuthRouter.page,
              children: [
                AutoRoute(initial: true, page: SignInRoute.page),
                AutoRoute(page: TermsAndConditionsRoute.page),
                AutoRoute(page: ForgotPasswordRoute.page),
                AutoRoute(page: VerifyResetCodeRoute.page),
                AutoRoute(page: ResetPasswordRoute.page),
                AutoRoute(page: CompleteProfileFormRoute.page),
              ],
            ),
            AutoRoute(page: CompleteProfileFormRoute.page),
            AdaptiveRoute(
              page: AppManagerRoute.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: UserNavigationRoute.page,
                  children: [
                    AutoRoute(
                      initial: true,
                      page: DashboardRouter.page,
                      children: dashboardAutoRoutes,
                    ),
                    //AutoRoute(page: AddsAndOffersRoute.page),
                    AutoRoute(
                      page: AddsAndOffersRouter.page,
                      children: [
                        AutoRoute(initial: true, page: AddsAndOffersRoute.page),
                        AutoRoute(page: NotificationsRoute.page),
                      ],
                    ),
                    AutoRoute(
                      page: ProfileRouter.page,
                      children: [
                        AutoRoute(initial: true, page: ProfileRoute.page),
                        AutoRoute(page: SettingsRoute.page),
                        AutoRoute(page: CompanyInfoRoute.page),
                        AutoRoute(page: AddRateRoute.page),
                        AutoRoute(page: AboutUsRoute.page),
                        AutoRoute(page: PrivacyPolicyRoute.page),
                        AutoRoute(page: TermsAndConditionsRoute.page),
                        AutoRoute(page: NotificationsRoute.page),
                      ],
                    ),
                  ],
                ),
                AutoRoute(
                  page: DashboardRouter.page,
                  children: dashboardAutoRoutes,
                ),
              ],
            ),
          ],
        ),
      ];
}

final dashboardAutoRoutes = [
  AutoRoute(page: DashboardRoute.page, initial: true),
  AutoRoute(page: CompanyInfoRoute.page),
  AutoRoute(page: AddsAndOffersRoute.page),
  AutoRoute(page: SettingsRoute.page),
  AutoRoute(page: SelectPlanRoute.page),
  AutoRoute(page: UsersRoute.page),
  AutoRoute(page: CustomersRoute.page),
  AutoRoute(page: SubscriberEvaluationRoute.page),
  AutoRoute(page: CodesRoute.page),
  AutoRoute(page: PointsRoute.page),
  AutoRoute(page: MealsRoute.page),
  AutoRoute(page: MealsDietitianRoute.page),
  AutoRoute(page: IngredientsRoute.page),
  AutoRoute(page: LevelsRoute.page),
  AutoRoute(page: EarnPointsWaysRoute.page),
  AutoRoute(page: StatisticsRoute.page),
  AutoRoute(page: RatingsRoute.page),
  AutoRoute(page: ItemsRoute.page),
  AutoRoute(page: ExercisesRoute.page),
  AutoRoute(page: ExercisesCoachRoute.page),
  AutoRoute(page: NotificationsRoute.page),
  AutoRoute(page: UpdateCustomerInfoRoute.page),
  AutoRoute(page: ApproveCustomerRoute.page),
];
