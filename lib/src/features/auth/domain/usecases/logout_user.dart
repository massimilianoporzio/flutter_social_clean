// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

class LogoutUser implements UseCase<void, NoParams> {
  final AuthRepository authRepository;
  LogoutUser({
    required this.authRepository,
  });
  @override
  call(NoParams params) {
    return authRepository.logout();
  }
}
