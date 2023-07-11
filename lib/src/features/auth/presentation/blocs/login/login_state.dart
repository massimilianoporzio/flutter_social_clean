// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

class LoginState extends Equatable {
  //input da passare al cubit:
  final Username username;
  final Password password;
  //lo stato del form
  final FormzSubmissionStatus status;
  //se c'è un errore
  final String? errorText;

  const LoginState({
    this.username = const Username.pure(),
    this.password = const Password.pure(), //sono empty di default
    this.status = FormzSubmissionStatus.initial, //non ancora validato
    this.errorText,
  });

  factory LoginState.initial() => const LoginState();

  @override
  List<Object?> get props => [
        username,
        password,
        status,
        errorText,
      ];

  @override
  bool? get stringify => true;

  LoginState copyWith({
    Username? username,
    Password? password,
    FormzSubmissionStatus? status,
    String? errorText,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }
}
