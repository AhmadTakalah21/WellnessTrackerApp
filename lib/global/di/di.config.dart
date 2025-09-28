// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart'
    as _i972;
import 'package:wellnesstrackerapp/features/adds_and_offers/service/adds_and_offers_service.dart'
    as _i602;
import 'package:wellnesstrackerapp/features/app_manager/cubit/app_manager_cubit.dart'
    as _i533;
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart'
    as _i883;
import 'package:wellnesstrackerapp/features/auth/service/auth_service.dart'
    as _i386;
import 'package:wellnesstrackerapp/features/auth_manager/bloc/auth_manager_bloc.dart'
    as _i435;
import 'package:wellnesstrackerapp/features/codes/cubit/codes_cubit.dart'
    as _i457;
import 'package:wellnesstrackerapp/features/codes/service/codes_service.dart'
    as _i249;
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart'
    as _i935;
import 'package:wellnesstrackerapp/features/customers/service/customers_service.dart'
    as _i299;
import 'package:wellnesstrackerapp/features/exercise_plans/cubit/exercise_plans_cubit.dart'
    as _i371;
import 'package:wellnesstrackerapp/features/exercise_plans/service/exercise_plans_service.dart'
    as _i738;
import 'package:wellnesstrackerapp/features/exercises/cubit/exercises_cubit.dart'
    as _i279;
import 'package:wellnesstrackerapp/features/exercises/service/exercises_service.dart'
    as _i750;
import 'package:wellnesstrackerapp/features/ingredients/cubit/ingredients_cubit.dart'
    as _i535;
import 'package:wellnesstrackerapp/features/ingredients/service/ingredients_service.dart'
    as _i85;
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart'
    as _i803;
import 'package:wellnesstrackerapp/features/items/service/items_service.dart'
    as _i1044;
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart'
    as _i726;
import 'package:wellnesstrackerapp/features/levels/service/level_service.dart'
    as _i715;
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart'
    as _i744;
import 'package:wellnesstrackerapp/features/meal_plans/service/meal_plans_service.dart'
    as _i852;
import 'package:wellnesstrackerapp/features/meals/cubit/meals_cubit.dart'
    as _i826;
import 'package:wellnesstrackerapp/features/meals/service/meals_service.dart'
    as _i287;
import 'package:wellnesstrackerapp/features/notifications/cubit/notifications_cubit.dart'
    as _i1053;
import 'package:wellnesstrackerapp/features/notifications/service/notifications_service.dart'
    as _i959;
import 'package:wellnesstrackerapp/features/points/cubit/points_cubit.dart'
    as _i32;
import 'package:wellnesstrackerapp/features/points/service/points_service.dart'
    as _i985;
import 'package:wellnesstrackerapp/features/profile/cubit/profile_cubit.dart'
    as _i680;
import 'package:wellnesstrackerapp/features/profile/service/profile_service.dart'
    as _i593;
import 'package:wellnesstrackerapp/features/ratings/cubit/ratings_cubit.dart'
    as _i167;
import 'package:wellnesstrackerapp/features/ratings/service/ratings_service.dart'
    as _i307;
import 'package:wellnesstrackerapp/features/select_plan/cubit/user_plans_cubit.dart'
    as _i798;
import 'package:wellnesstrackerapp/features/select_plan/service/user_plans_service.dart'
    as _i816;
import 'package:wellnesstrackerapp/features/settings/cubit/settings_cubit.dart'
    as _i264;
import 'package:wellnesstrackerapp/features/settings/service/settings_service.dart'
    as _i1054;
import 'package:wellnesstrackerapp/features/splash/cubit/splash_cubit.dart'
    as _i776;
import 'package:wellnesstrackerapp/features/splash/service/splash_service.dart'
    as _i217;
import 'package:wellnesstrackerapp/features/statistics/cubit/statistics_cubit.dart'
    as _i718;
import 'package:wellnesstrackerapp/features/statistics/service/statistics_service.dart'
    as _i911;
import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart'
    as _i253;
import 'package:wellnesstrackerapp/features/users/service/users_service.dart'
    as _i936;
import 'package:wellnesstrackerapp/global/blocs/delete_cubit/cubit/delete_cubit.dart'
    as _i396;
import 'package:wellnesstrackerapp/global/blocs/internet_connection/cubit/internet_connection_cubit.dart'
    as _i447;
import 'package:wellnesstrackerapp/global/blocs/share_cubit/cubit/share_cubit.dart'
    as _i476;
import 'package:wellnesstrackerapp/global/blocs/upload_file_cubit/cubit/upload_file_cubit.dart'
    as _i188;
import 'package:wellnesstrackerapp/global/blocs/upload_image_cubit/cubit/upload_image_cubit.dart'
    as _i540;
import 'package:wellnesstrackerapp/global/blocs/user_roles_cubit/cubit/user_roles_cubit.dart'
    as _i633;
import 'package:wellnesstrackerapp/global/blocs/video_player_cubit/cubit/video_player_cubit.dart'
    as _i977;
import 'package:wellnesstrackerapp/global/di/app_module.dart' as _i326;
import 'package:wellnesstrackerapp/global/dio/dio_client.dart' as _i384;
import 'package:wellnesstrackerapp/global/services/delete_service/delete_service.dart'
    as _i963;
import 'package:wellnesstrackerapp/global/services/notification_service/notification_config.dart'
    as _i1023;
import 'package:wellnesstrackerapp/global/services/user_repo.dart' as _i128;
import 'package:wellnesstrackerapp/global/services/user_role_service/user_role_service.dart'
    as _i474;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i476.ShareCubit>(() => _i476.ShareCubit());
    gh.factory<_i188.UploadFileCubit>(() => _i188.UploadFileCubit());
    gh.factory<_i540.UploadImageCubit>(() => _i540.UploadImageCubit());
    gh.factory<_i977.VideoPlayerCubit>(() => _i977.VideoPlayerCubit());
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i533.AppManagerCubit>(() => _i533.AppManagerCubit());
    gh.singleton<_i447.InternetConnectionCubit>(
        () => _i447.InternetConnectionCubit());
    gh.singleton<_i384.DioClient>(() => _i384.DioClient());
    gh.singleton<_i1023.NotaficationsService>(
        () => _i1023.NotaficationsService());
    await gh.singletonAsync<_i128.UserRepo>(
      () {
        final i = _i128.UserRepo();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i386.AuthService>(() => _i386.AuthServiceImp());
    gh.factory<_i249.CodesService>(() => _i249.CodesServiceImp());
    gh.factory<_i985.PointsService>(() => _i985.PointsServiceImp());
    gh.factory<_i1054.SettingsService>(() => _i1054.SettingsServiceImp());
    gh.factory<_i287.MealsService>(() => _i287.MealsServiceImp());
    gh.factory<_i936.UserService>(() => _i936.UserServiceImp());
    gh.factory<_i852.MealPlansService>(() => _i852.MealPlanServiceImp());
    gh.factory<_i959.NotificationsService>(
        () => _i959.NotificationsServiceImp());
    gh.factory<_i911.StatisticsService>(() => _i911.StatisticsServiceImp());
    gh.singleton<_i435.AuthManagerBloc>(
        () => _i435.AuthManagerBloc(gh<_i128.UserRepo>()));
    gh.factory<_i85.IngredientsService>(() => _i85.IngredientsServiceImp());
    gh.factory<_i963.DeleteService>(() => _i963.DeleteServiceImp());
    gh.factory<_i217.SplashSerivce>(() => _i217.SplashSerivceImp());
    gh.factory<_i826.MealsCubit>(
        () => _i826.MealsCubit(gh<_i287.MealsService>()));
    gh.factory<_i1053.NotificationsCubit>(
        () => _i1053.NotificationsCubit(gh<_i959.NotificationsService>()));
    gh.factory<_i750.ExercisesService>(() => _i750.ExercisesServiceImp());
    gh.factory<_i32.PointsCubit>(
        () => _i32.PointsCubit(gh<_i985.PointsService>()));
    gh.factory<_i593.ProfileService>(() => _i593.ProfileServiceImp());
    gh.factory<_i744.MealPlansCubit>(
        () => _i744.MealPlansCubit(gh<_i852.MealPlansService>()));
    gh.factory<_i457.CodesCubit>(
        () => _i457.CodesCubit(gh<_i249.CodesService>()));
    gh.factory<_i680.ProfileCubit>(
        () => _i680.ProfileCubit(gh<_i593.ProfileService>()));
    gh.factory<_i474.UserRoleService>(() => _i474.UserRoleServiceImp());
    gh.factory<_i738.ExercisePlansService>(
        () => _i738.ExercisePlansServiceImp());
    gh.factory<_i535.IngredientsCubit>(
        () => _i535.IngredientsCubit(gh<_i85.IngredientsService>()));
    gh.factory<_i715.LevelsService>(() => _i715.LevelsServiceImp());
    gh.factory<_i816.UserPlansService>(() => _i816.UserPlansServiceImp());
    gh.factory<_i1044.ItemService>(() => _i1044.ItemServiceImp());
    gh.factory<_i307.RatingsService>(() => _i307.RatingsServiceImp());
    gh.factory<_i279.ExercisesCubit>(
        () => _i279.ExercisesCubit(gh<_i750.ExercisesService>()));
    gh.factory<_i299.CustomersService>(() => _i299.CustomersServiceImp());
    gh.factory<_i602.AddsAndOffersService>(
        () => _i602.AddsAndOffersServiceImp());
    gh.factory<_i935.CustomersCubit>(
        () => _i935.CustomersCubit(gh<_i299.CustomersService>()));
    gh.factory<_i718.StatisticsCubit>(
        () => _i718.StatisticsCubit(gh<_i911.StatisticsService>()));
    gh.factory<_i776.SplashCubit>(() => _i776.SplashCubit(
          gh<_i217.SplashSerivce>(),
          gh<_i128.UserRepo>(),
        ));
    gh.factory<_i396.DeleteCubit>(
        () => _i396.DeleteCubit(gh<_i963.DeleteService>()));
    gh.factory<_i883.AuthCubit>(() => _i883.AuthCubit(
          gh<_i386.AuthService>(),
          gh<_i435.AuthManagerBloc>(),
        ));
    gh.factory<_i264.SettingsCubit>(
        () => _i264.SettingsCubit(gh<_i1054.SettingsService>()));
    gh.factory<_i253.UsersCubit>(
        () => _i253.UsersCubit(gh<_i936.UserService>()));
    gh.factory<_i798.UserPlansCubit>(
        () => _i798.UserPlansCubit(gh<_i816.UserPlansService>()));
    gh.factory<_i972.AddsAndOffersCubit>(
        () => _i972.AddsAndOffersCubit(gh<_i602.AddsAndOffersService>()));
    gh.factory<_i371.ExercisePlansCubit>(
        () => _i371.ExercisePlansCubit(gh<_i738.ExercisePlansService>()));
    gh.factory<_i803.ItemsCubit>(
        () => _i803.ItemsCubit(gh<_i1044.ItemService>()));
    gh.factory<_i167.RatingsCubit>(
        () => _i167.RatingsCubit(gh<_i307.RatingsService>()));
    gh.factory<_i726.LevelsCubit>(
        () => _i726.LevelsCubit(gh<_i715.LevelsService>()));
    gh.factory<_i633.UserRolesCubit>(
        () => _i633.UserRolesCubit(gh<_i474.UserRoleService>()));
    return this;
  }
}

class _$AppModule extends _i326.AppModule {}
