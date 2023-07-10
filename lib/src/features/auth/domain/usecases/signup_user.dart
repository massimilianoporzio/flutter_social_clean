// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_social_clean/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

import '../repositories/auth_repository.dart';

class SignupUser implements UseCase<void, SignupUserParams> {
  final AuthRepository authRepository;
  SignupUser({
    required this.authRepository,
  });

  @override
  call(SignupUserParams params) {
    //TODO : Agg altro repo per salvare su db ogni volta che prova a fare signup

    return authRepository.signup(
      loggedInUser: params.user,
    );
  }
}

class SignupUserParams extends Params with EquatableMixin {
  final LoggedInUser user;
  SignupUserParams({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
