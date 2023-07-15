import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/config/app_router.dart';
import 'package:flutter_social_clean/src/config/app_theme.dart';
import 'package:flutter_social_clean/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:flutter_social_clean/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/blocs/login/login_cubit.dart';

import 'features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'services/service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //DO' accesso A TUTTA LA APP AL MIO REPOSITORY (TODO: meglio con injection)
    return MultiRepositoryProvider(
      //TODO decidere se tenere o no
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(
            authDatasource: MockAuthDatasourceImpl(),
          ),
        ),
      ],
      //poi do' accesso a TUTTA la APP ai miei bloc
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<AuthBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<LoginCubit>(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: CustomTheme.theme(),
            routerConfig: AppRouter(context.read<AuthBloc>()).router,
          );
        }),
      ),
    );
  }
}
