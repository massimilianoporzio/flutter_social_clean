// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/feed/domain/repositories/user_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

import '../../../../shared/domain/entities/user.dart';

class GetUser implements UseCase<User, GetUserParams> {
  final UserRepository userRepository;
  GetUser({
    required this.userRepository,
  });
  @override
  Future<User> call(GetUserParams params) {
    return userRepository.getUser(params.userId);
  }
}

class GetUserParams extends Params {
  final String userId;
  GetUserParams({
    required this.userId,
  });
  @override
  List<Object?> get props => [userId];
}
