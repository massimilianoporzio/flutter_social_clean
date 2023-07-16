import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/signup_user.dart';
import 'package:flutter_social_clean/src/logs/bloc_logger.dart';
import 'package:formz/formz.dart';

import '../../../../../shared/domain/entities/user.dart';
import '../../../domain/entities/logged_in_user.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> with BlocLoggy {
  final SignupUser _signupUserUseCase;
  SignupCubit({required SignupUser signupUser})
      : _signupUserUseCase = signupUser,
        super(SignupState.initial());

  //METODI
  //il value arriva dal form
  void usernameChanged(String value) {
    loggy.debug("username from UI is: $value");
    final username = Username.dirty(value); //creo il value object
    //forza la validazione
    Formz.validate([
      username,
      state.email,
      state.password,
    ]);
    final formValid =
        username.isValid && state.password.isValid && state.email.isValid;
    emit(state.copyWith(
        username: username,
        status: FormzSubmissionStatus
            .initial, //è ancora initial non ho cliccato su Signup
        isPure: false, //form Modificata,
        isValid: formValid //se valida o meno

        ));
  }

  //il value arriva dal form
  void emailChanged(String value) {
    loggy.debug("email from UI is: $value");
    final email = Email.dirty(value); //creo il value object
    //valido
    Formz.validate([
      state.username,
      email,
      state.password,
    ]);

    final formValid =
        state.username.isValid && email.isValid && state.password.isValid;
    emit(state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        isPure: false,
        isValid: formValid));
  }

  void passwordChanged(String value) {
    loggy.debug("password from UI is: $value");

    final Password password = Password.dirty(value);
    //valido tranne la password2 che viene resettata (pura)
    Formz.validate([
      state.username,
      state.email,
      state.password,
    ]);

    final formValid =
        state.username.isValid && state.email.isValid && password.isValid;
    emit(state.copyWith(
        password: password,
        password2: const Password.pure(), //RESET
        status: FormzSubmissionStatus.initial,
        isPure: false,
        isValid: formValid));
  }

  void password2Changed(String value) {
    loggy.debug("password2 is: $value");
    final Password password2 = Password.dirty(value);
    Formz.validate([
      state.username,
      state.email,
      state.password,
      password2,
    ]);
    //ORA aggiungo check che sia = a quella sopra
    final formValid = password2.value == state.password.value;

    emit(state.copyWith(
        password2: password2,
        status: FormzSubmissionStatus.initial,
        isPure: false,
        isValid: formValid));
  }

  Future<void> signupWithCredentials() async {
    if (!state.isValid) {
      return;
    } //se form non è valido
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress //si inizia!
        ));
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      //chiamo il caso d'uso
      await _signupUserUseCase(SignupUserParams(
          user: LoggedInUser(
              id: 'user_000', //per ora è sempre fisso qui da codice
              username: state.username,
              email: state.email,
              imagePath: 'assets/images/image_1.jpg' //TODO renderlo uploadable
              )));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (err) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
