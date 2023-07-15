// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'signup_cubit.dart';

class SignupState extends Equatable {
  //input da passare al cubit:
  final Username username;
  final Email email;
  final Password password;
  final Password password2;
  //lo stato del form
  final FormzSubmissionStatus status;
  //se gli input sono validi
  final bool isValid;
  //se il form non è mai stato toccato
  final bool isPure;
  //se c'è un errore
  final String? errorText;
  const SignupState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.password2 = const Password.pure(),
    this.status = FormzSubmissionStatus.initial, //non ancora validato,
    this.isValid = false,
    this.isPure = true,
    this.errorText,
  });

  factory SignupState.initial() => const SignupState();

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props {
    return [
      username,
      email,
      password,
      password2,
      status,
      isValid,
      isPure,
      errorText,
    ];
  }

  SignupState copyWith({
    Username? username,
    Email? email,
    Password? password,
    Password? password2,
    FormzSubmissionStatus? status,
    bool? isValid,
    bool? isPure,
    String? errorText,
  }) {
    return SignupState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      password2: password2 ?? this.password2,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      isPure: isPure ?? this.isPure,
      errorText: errorText ?? this.errorText,
    );
  }
}
