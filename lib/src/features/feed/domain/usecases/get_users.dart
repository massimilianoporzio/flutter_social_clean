// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/feed/domain/repositories/user_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

import '../../../../shared/domain/entities/user.dart';

class GetUsers implements UseCase<List<User>, NoParams> {
  final UserRepository userRepository;
  GetUsers({
    required this.userRepository,
  });
  @override
  Future<List<User>> call(NoParams params) {
    return userRepository.getUsers();
  }
}
