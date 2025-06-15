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
import 'package:wellnesstrackerapp/features/app_manager/cubit/app_manager_cubit.dart'
    as _i533;
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart'
    as _i883;
import 'package:wellnesstrackerapp/features/auth/service/auth_service.dart'
    as _i386;
import 'package:wellnesstrackerapp/features/auth_manager/bloc/auth_manager_bloc.dart'
    as _i435;
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart'
    as _i803;
import 'package:wellnesstrackerapp/features/items/service/items_service.dart'
    as _i1044;
import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart'
    as _i253;
import 'package:wellnesstrackerapp/features/users/service/users_service.dart'
    as _i936;
import 'package:wellnesstrackerapp/global/blocs/delete_cubit/cubit/delete_cubit.dart'
    as _i396;
import 'package:wellnesstrackerapp/global/blocs/upload_image_cubit/cubit/upload_image_cubit.dart'
    as _i540;
import 'package:wellnesstrackerapp/global/blocs/user_roles_cubit/cubit/user_roles_cubit.dart'
    as _i633;
import 'package:wellnesstrackerapp/global/di/app_module.dart' as _i326;
import 'package:wellnesstrackerapp/global/dio/dio_client.dart' as _i384;
import 'package:wellnesstrackerapp/global/services/delete_service/delete_service.dart'
    as _i963;
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
    gh.factory<_i533.AppManagerCubit>(() => _i533.AppManagerCubit());
    gh.factory<_i540.UploadImageCubit>(() => _i540.UploadImageCubit());
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i384.DioClient>(() => _i384.DioClient());
    await gh.singletonAsync<_i128.UserRepo>(
      () {
        final i = _i128.UserRepo();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i386.AuthService>(() => _i386.AuthServiceImp());
    gh.factory<_i936.UserService>(() => _i936.UserServiceImp());
    gh.singleton<_i435.AuthManagerBloc>(
        () => _i435.AuthManagerBloc(gh<_i128.UserRepo>()));
    gh.factory<_i963.DeleteService>(() => _i963.DeleteServiceImp());
    gh.factory<_i474.UserRoleService>(() => _i474.UserRoleServiceImp());
    gh.factory<_i1044.ItemService>(() => _i1044.ItemServiceImp());
    gh.factory<_i396.DeleteCubit>(
        () => _i396.DeleteCubit(gh<_i963.DeleteService>()));
    gh.factory<_i883.AuthCubit>(() => _i883.AuthCubit(
          gh<_i386.AuthService>(),
          gh<_i435.AuthManagerBloc>(),
        ));
    gh.factory<_i253.UsersCubit>(
        () => _i253.UsersCubit(gh<_i936.UserService>()));
    gh.factory<_i803.ItemsCubit>(
        () => _i803.ItemsCubit(gh<_i1044.ItemService>()));
    gh.factory<_i633.UserRolesCubit>(
        () => _i633.UserRolesCubit(gh<_i474.UserRoleService>()));
    return this;
  }
}

class _$AppModule extends _i326.AppModule {}
