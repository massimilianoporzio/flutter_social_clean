import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/config/app_router.dart';
import 'package:flutter_social_clean/src/config/app_theme.dart';
import 'package:flutter_social_clean/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:flutter_social_clean/src/features/auth/data/repositories/auth_repository_impl.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //TODO: fare con GETIT

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //DO' accesso A TUTTA LA APP AL MIO REPOSITORY (TODO: meglio con injection)
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(
            authDatasource: MockAuthDatasourceImpl(),
          ),
        ),
      ],
      //poi do' accesso a TUTTA la APP ai miei bloc
      child: MultiBlocProvider(
        providers: const [
          // BlocProvider(
          //   create: (context) => AuthBloc(
          //       logoutUser: logoutUser,
          //       getAuthStatus: getAuthStatus,
          //       getLoggedInUser: getLoggedInUser),
          // ),
          // BlocProvider(
          //   create: (context) => LoginCubit(loginUser: loginUser),
          // ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: CustomTheme.theme(),
          routerConfig: AppRouter().router,
        ),
      ),
    );
  }
}
