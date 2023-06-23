import 'dart:async';

import 'package:flutter_social_clean/src/features/auth/domain/entities/auth_status.dart';

import '../../../../shared/domain/entities/user.dart';
import '../../domain/entities/logged_in_user.dart';

abstract class MockAuthDatasource {
  Stream<AuthStatus> get status;
  Future<LoggedInUser> get loggedInUser;
  Future<void> signup({required LoggedInUser loggedInUser});
  Future<void> login({
    required Username username,
    required Password password,
  });
  Future<void> logout();
}

class MockAuthDatasourceImpl implements MockAuthDatasource {
  final _controller = StreamController<AuthStatus>();
  @override
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1)); //simulates delay
    //initial status:
    yield AuthStatus.authenticated;
    //poi faccio uscire l'intero stream
    yield* _controller.stream;
  }

  @override
  Future<LoggedInUser> get loggedInUser {
    //TODO: get actually loggedInUser
    return Future.delayed(
      const Duration(milliseconds: 300),
      () {
        return LoggedInUser.empty; //PER ORA RESTITUISCO SEMPRE EMPTY
      },
    );
  }

  @override
  Future<void> login({required Username username, required Password password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> signup({required LoggedInUser loggedInUser}) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
