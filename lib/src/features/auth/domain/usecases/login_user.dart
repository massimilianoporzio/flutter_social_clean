import 'package:flutter_social_clean/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:flutter_social_clean/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/entities/user.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

class LoginUser implements UseCase<void, LoginUserParams> {
  final AuthRepository
      authRepository; //solo l'interfaccia! non dipende da datsa layer(dependency inversion)
  LoginUser({
    required this.authRepository,
  });

  @override
  call(params) {
    return authRepository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginUserParams extends Params {
  final Username username;
  final Password password;
  LoginUserParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
