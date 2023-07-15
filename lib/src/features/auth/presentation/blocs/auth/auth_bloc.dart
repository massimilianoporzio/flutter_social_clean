import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_auth_status.dart';
import '../../../domain/usecases/get_logged_in_user.dart';
import '../../../domain/usecases/logout_user.dart';
import '../../../../../shared/domain/usecases/usecases.dart';

import '../../../domain/entities/auth_status.dart';
import '../../../domain/entities/logged_in_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUser _logoutUserUseCase;
  final GetAuthStatus _getAuthStatusUseCase;
  final GetLoggedInUser _getLoggedInUserUseCase;

  late StreamSubscription<AuthStatus> _authStatusSubscription;

  AuthBloc({
    required LogoutUser logoutUser,
    required GetAuthStatus getAuthStatus,
    required GetLoggedInUser getLoggedInUser,
  })  : _logoutUserUseCase = logoutUser,
        _getAuthStatusUseCase = getAuthStatus,
        _getLoggedInUserUseCase = getLoggedInUser,
        super(const AuthState.unknown()) {
    on<AuthGetStatus>(_onAuthGetStatus);
    on<AuthLogoutUser>(_onAuthLogoutUser);
    _authStatusSubscription =
        _getAuthStatusUseCase(NoParams()).listen((status) {
      //ogni volta che cambia lo stato io sto in ascolto e emetto
      add(AuthGetStatus(status: status));
    });
  }

  FutureOr<void> _onAuthGetStatus(
    AuthGetStatus event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('Get AuthGetStatus: ${event.status}');
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
      case AuthStatus.authenticated:
        //mi prendo l'utente loggato
        final user = await _getLoggedInUserUseCase(NoParams());
        debugPrint(user.toString());
        if (user != LoggedInUser.empty) {
          return emit(AuthState.authenticated(user: user));
        }

      default:
    }
  }

  FutureOr<void> _onAuthLogoutUser(
    AuthLogoutUser event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('Start user logout with _onAuthLogoutUser}');
    await _logoutUserUseCase(NoParams()); //LA LOGICA
    emit(const AuthState.unauthenticated()); //LA APP
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}
