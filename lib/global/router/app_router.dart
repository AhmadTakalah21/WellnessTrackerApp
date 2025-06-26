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
                AutoRoute(page: ForgotPasswordRoute.page),
                AutoRoute(page: ResetPasswordRoute.page),
                AutoRoute(page: CompleteProfileFormRoute.page),
              ],
            ),
            AutoRoute(page: CompleteProfileFormRoute.page),
            AdaptiveRoute(
              page: AppManagerRoute.page,
              children: [
                AutoRoute(initial: true, page: DashboardRoute.page),
                AutoRoute(page: UsersRoute.page),
                AutoRoute(page: PointsRoute.page),
                AutoRoute(page: MealsRoute.page),
                AutoRoute(page: ExercisesRoute.page),
              ],
            ),
          ],
        ),
      ];
}
