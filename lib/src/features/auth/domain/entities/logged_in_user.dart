import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../shared/domain/entities/user.dart';

class LoggedInUser extends User with EquatableMixin {
  final Email? email;
  const LoggedInUser({
    required super.id,
    required super.username,
    super.imagePath,
    super.followers,
    super.followings,
    this.email,
  });

  static const empty = LoggedInUser(
    id: '-',
    username: Username.pure(),
    email: Email.pure(),
  );

  @override
  List<Object?> get props => super.props..addAll([email]);

  @override
  bool? get stringify => true;

  LoggedInUser copyWith({
    String? id,
    Email? email,
    Username? username, //sono value objects
    String? imagePath,
    int? followers,
    int? followings,
  }) {
    return LoggedInUser(
      email: email ?? this.email,
      id: id ?? '',
      username: username ?? this.username,
    );
  }
}

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.pure(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    return EmailValidator.validate(value) ? null : EmailValidationError.invalid;
    // return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

//* riguarda la validazione delle password in fase di registrazione
enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.pure(value);
  //solo lettere e numeri ma entrambe e di almeno 8 caratteri
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}
