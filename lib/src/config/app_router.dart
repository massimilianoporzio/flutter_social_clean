// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_social_clean/src/features/auth/domain/entities/auth_status.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_social_clean/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/pages/signup_screen.dart';
import 'package:flutter_social_clean/src/features/feed/presentation/pages/discover_screen.dart';

import '../features/feed/presentation/pages/feed_screen.dart';

class AppRouter {
  final AuthBloc authBloc;
  AppRouter(
    this.authBloc,
  );
  late final GoRouter router = GoRouter(
      routes: <GoRoute>[
        //TOP LEVEL: EVERY route HAS ITS OWN NAVIGATON STACK
        GoRoute(
          path: "/", //pagina principale
          name: "feed",
          builder: (context, state) => const FeedScreen(),
        ),
        GoRoute(
          path: "/discover",
          name: "discover",
          builder: (context, state) => const DiscoverScreen(),
          routes: [
            //SUB LEVEL ROUTES: /discover/:userId
            GoRoute(
              name: "user",
              path: ':userId',
              //TODO: change to user screen
              builder: (context, state) => Container(),
            ),
          ],
        ),
        GoRoute(
          path: "/login",
          name: "login",
          builder: (context, state) => const LoginScreen(),
          routes: [
            //SUB LEVEL ROUTES: /login/signup
            GoRoute(
              name: "signup",
              path: 'signup',
              builder: (context, state) => const SignupScreen(),
            ),
          ],
        ),
      ], //TOP LEVEL
      redirect: (context, state) {
        final loginLocation = state.namedLocation('login');
        final signupLocation = state.namedLocation('signup');

        //è loggato?
        final bool isLoggedIn =
            authBloc.state.status == AuthStatus.authenticated;
        //è nella pagina di login?
        final isLogginIn = state.matchedLocation == loginLocation;
        final isSigninUp = state.matchedLocation == signupLocation;
        //se non è loggato e non sta faecndo né login né signup lo mando a login
        if (!isLoggedIn && !isLogginIn && !isSigninUp) {
          return '/login';
        }
        //se stava facendo login ed è autenticato mando a feed
        if (isLoggedIn && isLogginIn) {
          return '/';
        }
        //se stava facendo signup e mi loggo direttamente mando a feed
        if (isLoggedIn && isSigninUp) {
          return '/';
        }
        return null; //caso di default non fa redirection
      },
      refreshListenable:
          GoRouterRefreshStream(authBloc.stream) //ASCOLTA lo stream di authBloc
      );
}

/// Converts a [Stream] into a [Listenable]
///
/// {@tool snippet}
/// Typical usage is as follows:
///
/// ```dart
/// GoRouter(
///  refreshListenable: GoRouterRefreshStream(stream),
/// );
/// ```
/// {@end-tool}
class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
