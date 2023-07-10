import 'package:flutter_social_clean/src/features/auth/domain/entities/auth_status.dart';
import 'package:flutter_social_clean/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

class GetAuthStatus implements UseCase<AuthStatus, NoParams> {
  final AuthRepository authRepository;
  GetAuthStatus({
    required this.authRepository,
  });

  @override
  Stream<AuthStatus> call(NoParams params) {
    return authRepository.status;
  }
}
