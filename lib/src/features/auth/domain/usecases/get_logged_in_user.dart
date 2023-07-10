import 'package:flutter_social_clean/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:flutter_social_clean/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

class GetLoggedInUser implements UseCase<LoggedInUser, NoParams> {
  final AuthRepository authRepository;

  GetLoggedInUser({
    required this.authRepository,
  });

  @override
  Future<LoggedInUser> call(NoParams params) {
    return authRepository.loggedInUser;
  }
}
