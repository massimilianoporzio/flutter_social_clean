import 'package:flutter_social_clean/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:flutter_social_clean/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_social_clean/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/get_auth_status.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/get_logged_in_user.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/login_user.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/logout_user.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/signup_user.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/blocs/signup/signup_cubit.dart';
import 'package:flutter_social_clean/src/shared/data/mappers/user_mapper.dart';
import 'package:get_it/get_it.dart';

import '../features/auth/presentation/blocs/login/login_cubit.dart';
import '../shared/data/mappers/post_mapper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //*DATASOURCES:
  //AUTH
  sl.registerLazySingleton<MockAuthDatasource>(() => MockAuthDatasourceImpl());
  //*REPOSITORIES:
  //AUTH:
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: sl<MockAuthDatasource>()));
  //*USECASES
  //AUTH:
  sl.registerLazySingleton<GetAuthStatus>(
      () => GetAuthStatus(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<GetLoggedInUser>(
      () => GetLoggedInUser(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<LoginUser>(
      () => LoginUser(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<LogoutUser>(
      () => LogoutUser(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<SignupUser>(
      () => SignupUser(authRepository: sl<AuthRepository>()));

  //*BLOCS / CUBITS

  //Auth SINGLETON PARLA A TUTTI GLI ALTRI BLOC E RICEVE EVENTI DA LORO
  //POSSO USARLO NEL ROUTER CON DEPENDENCY INJECTION
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(
        logoutUser: sl<LogoutUser>(),
        getAuthStatus: sl<GetAuthStatus>(),
        getLoggedInUser: sl<GetLoggedInUser>(),
      ));

  sl.registerFactory<LoginCubit>(() => LoginCubit(loginUser: sl<LoginUser>()));
  sl.registerFactory<SignupCubit>(
      () => SignupCubit(signupUser: sl<SignupUser>()));

  //*MAPPERS
  sl.registerLazySingleton<UserMapper>(() => UserMapper());
  sl.registerLazySingleton<PostMapper>(() => PostMapper());
}
