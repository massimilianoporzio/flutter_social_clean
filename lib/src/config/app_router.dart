import 'dart:async';

import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();
  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      //TOP LEVEL: EVERY route HAS ITS OWN NAVIGATON STACK
      GoRoute(
        path: "/",
        name: "feed",
        //TODO: change to feed screen
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: "/discover",
        name: "discover",
        //TODO: change to discover screen
        builder: (context, state) => Container(
          child: Placeholder(),
        ),
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
        //TODO: change to login screen
        builder: (context, state) => Container(
          child: Placeholder(),
        ),
        routes: [
          //SUB LEVEL ROUTES: /login/signup
          GoRoute(
            name: "signup",
            path: 'signup',
            //TODO: change to user screen
            builder: (context, state) => Container(),
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
