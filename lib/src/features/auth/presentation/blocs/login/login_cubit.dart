import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:flutter_social_clean/src/logs/bloc_logger.dart';
import '../../../domain/entities/logged_in_user.dart';
import '../../../domain/usecases/login_user.dart';
import 'package:formz/formz.dart';

import '../../../../../shared/domain/entities/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with BlocLoggy {
  //private! uso lista iniziale nel costruttore
  final LoginUser _loginUserUsecase;
  LoginCubit({required LoginUser loginUser})
      : _loginUserUsecase = loginUser,
        super(LoginState.initial());

  //METODI
  //il value arriva dal form
  void usernameChanged(String value) {
    loggy.debug("password from UI is: $value");
    final username = Username.dirty(value); //creo il value object
    final formStatus = Formz.validate([
      username,
      state.password,
    ]);

    emit(state.copyWith(
        username: username,
        status: formStatus
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus
                .failure)); //ho emesso lo stato con nuovo username e lo status pari a se il nuovo
    // username e la password rimnasta come prima sono validi
    loggy.debug("username is valid? : ${state.status}");
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final formStatus = Formz.validate([
      state.username,
      password,
    ]);
    emit(state.copyWith(
        password: password,
        status: formStatus
            ? FormzSubmissionStatus.success
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
    } on LoginWithUsernameAndPasswordFailure catch (error) {
      emit(state.copyWith(
        errorText: error.message,
        status: FormzSubmissionStatus.failure,
      ));
    } catch (err) {
      emit(state.copyWith(
          status:
              FormzSubmissionStatus.failure)); //emesso stato per dire ERROR!
    }
  }
}
