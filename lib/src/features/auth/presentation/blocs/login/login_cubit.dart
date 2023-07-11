import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/logged_in_user.dart';
import '../../../domain/usecases/login_user.dart';
import 'package:formz/formz.dart';

import '../../../../../shared/domain/entities/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  //private! uso lista iniziale nel costruttore
  final LoginUser _loginUserUsecase;
  LoginCubit({required LoginUser loginUser})
      : _loginUserUsecase = loginUser,
        super(LoginState.initial());

  //METODI
  //il value arriva dal form
  void usernameChanged(String value) {
    final username = Username.dirty(value); //creo il value object
    final status = Formz.validate([
      username,
      state.password,
    ]);

    emit(state.copyWith(
        username: username,
        status: status
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus
                .failure)); //ho emesso lo stato con nuovo username e lo status pari a se il nuovo
    // username e la password rimnasta come prima sono validi
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final status = Formz.validate([
      state.username,
      password,
    ]);
    emit(state.copyWith(
        password: password,
        status: status
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.failure));
  }

  FutureOr<void> loginWithCredentials() async {
    emit(state.copyWith(
        status: FormzSubmissionStatus
            .inProgress)); //valido con la logica di business
    if (!state.status.isSuccess) {
      return; //esco e non faccio nulla se non è success
    }

    emit(state.copyWith(
        status: FormzSubmissionStatus
            .inProgress)); //validato: inizio il login verso la mia API
    //DO NOT CLICK AGAIN THE BUTTON!
    try {
      await _loginUserUsecase(LoginUserParams(
        username: state.username,
        password: state.password,
      ));
      //ho risposta (non eccezione) da API (da backend)
      emit(state.copyWith(
          status: FormzSubmissionStatus.success)); //emetto stato per dire OK!
    } catch (err) {
      emit(state.copyWith(
          status:
              FormzSubmissionStatus.failure)); //emesso stato per dire ERROR!
    }
  }
}
