import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class User extends Equatable {
  final String id;
  final Username username;
  final int followers;
  final int followings;
  final String? imagePath;

  const User({
    required this.id,
    required this.username,
    this.followers = 0,
    this.followings = 0,
    this.imagePath,
  });

  @override
  bool? get stringify => true; //mi stampa tutte le props

  static const empty = User(id: 'user_0', username: Username.pure());

  @override
  List<Object?> get props {
    return [
      id,
      username,
      followers,
      followings,
      imagePath,
    ];
  }
}

enum UsernameValidationError {
  invalid,
}

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure(''); //init with empty string
  const Username.dirty([String value = ''])
      : super.pure(value); //passo la stringa al costruttore FormzInput

  //regex per i caratteri usati
  static final RegExp _usernameRegExp = RegExp(
    r'^[a-zA-Z0-9#$%&’*+/=?^_`{|}~-]+$', //TOLTO ! dai caratteri da usare
  );
  @override
  UsernameValidationError? validator(value) {
    UsernameValidationError? error = _usernameRegExp.hasMatch(value)
        ? null
        : UsernameValidationError.invalid;
    return error;
  }
}
