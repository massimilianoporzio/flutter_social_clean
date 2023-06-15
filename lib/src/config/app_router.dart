import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/pages/signup_screen.dart';
import 'package:flutter_social_clean/src/features/feed/presentation/pages/discover_screen.dart';
import 'package:go_router/go_router.dart';

import '../features/feed/presentation/pages/feed_screen.dart';

class AppRouter {
  AppRouter();
  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      //TOP LEVEL: EVERY route HAS ITS OWN NAVIGATON STACK
      GoRoute(
        path: "/feed",
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
        path: "/",
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