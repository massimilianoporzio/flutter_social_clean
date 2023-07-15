// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final CacheClient _cache;
  MockAuthDatasourceImpl({
    CacheClient? cache,
  }) : _cache = cache ?? CacheClient();

  static const userCacheKey =
      '__user_cache_key'; //chiave sotto cui metto l'utente loggato
  @override
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1)); //simulates delay
    //initial status:
    yield AuthStatus.authenticated;
    //poi faccio uscire l'intero stream
    yield* _controller.stream;
  }

  void _updateLoggedInUser({
    String? id,
    Username? username,
    Email? email,
  }) {
    LoggedInUser loggedInUser =
        _cache.read(key: userCacheKey) ?? LoggedInUser.empty;

    _cache.write(
      key: userCacheKey,
      value: loggedInUser.copyWith(
        id: id,
        username: username,
        email: email,
      ),
    );
  }

  //test per git
  @override
  Future<LoggedInUser> get loggedInUser {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () {
        return _cache.read(key: userCacheKey) ?? LoggedInUser.empty;
        // return LoggedInUser.empty; //PER ORA RESTITUISCO SEMPRE EMPTY
      },
    );
  }

  @override
  Future<void> login({required Username username, required Password password}) {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () {
        //cerco se sto facendo login con user che esiste
        for (final user in _allUsers) {
          final utente = user as User;
          if (utente.username.value == username.value) {
            _updateLoggedInUser(id: user.id, username: user.username);
            _controller.add(AuthStatus
                .authenticated); //mando in stream che sono autenticato
            return; //esco dalla callback
          }
        }
        throw LoginWithUsernameAndPasswordFailure.fromCode(kUserNotFound);
      },
    );
  }

  @override
  Future<void> logout() {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () {
        //al posto id user nella cache metto empy
        _cache.write(
          key: userCacheKey,
          value: LoggedInUser.empty,
        );
        //mi rimetto in stato non autenticato
        _controller.add(AuthStatus.unauthenticated);
      },
    );
  }

  @override
  Future<void> signup({required LoggedInUser loggedInUser}) {
    return Future.delayed(const Duration(milliseconds: 300), () {
      _allUsers.add(loggedInUser);

      _updateLoggedInUser(
        id: loggedInUser.id,
        username: loggedInUser.username,
        email: loggedInUser.email,
      );

      _controller.add(AuthStatus.unauthenticated);
    });
  }

  //IL MIO DB
  final List<User> _allUsers = <User>[
    const User(
      id: 'user_1',
      username: Username.dirty('Massimo'),
      imagePath: 'assets/images/image_1.jpg',
    ),
    const User(
      id: 'user_2',
      username: Username.dirty('Sarah'),
      imagePath: 'assets/images/image_2.jpg',
    ),
    const User(
      id: 'user_3',
      username: Username.dirty('John'),
      imagePath: 'assets/images/image_3.jpg',
    ),
  ];
}

//*ORA FACCIO UNA CACHE LOCALE
class CacheClient {
  final Map<String, Object> _cache;
  CacheClient() : _cache = <String, Object>{};

  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}

class LoginWithUsernameAndPasswordFailure implements Exception {
  final String message;
  const LoginWithUsernameAndPasswordFailure({
    required this.message,
  });
  factory LoginWithUsernameAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case kInvalidUser:
        return const LoginWithUsernameAndPasswordFailure(
            message: 'Username is not valid');
      case kUserNotFound:
        return const LoginWithUsernameAndPasswordFailure(
            message:
                'No User found with the provided credentials. Please, create an account');

      default:
        return const LoginWithUsernameAndPasswordFailure(
            message: 'An unknown error occured.');
    }
  }
}

const String kUserNotFound = 'user-not-found';
const String kInvalidUser = 'invalid-username';
