// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthGetStatus extends AuthEvent {
  final AuthStatus status;
  const AuthGetStatus({
    required this.status,
  });

  @override
  List<Object> get props => [status];
} //evento da scatenare ad ogni cambio di stato

class AuthLogoutUser extends AuthEvent {} //evento quando lo user fa logout