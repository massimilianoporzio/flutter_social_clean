import 'package:flutter_social_clean/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

import '../entities/chat.dart';

class GetChatsByUser implements UseCase<List<Chat>, GetChatsByUserParams> {
  final ChatRepository chatRepository;
  GetChatsByUser({
    required this.chatRepository,
  });
  @override
  Future<List<Chat>> call(GetChatsByUserParams params) {
    return chatRepository.getChatsByUser(params.userId);
  }
}

class GetChatsByUserParams extends Params {
  final String userId;
  GetChatsByUserParams({
    required this.userId,
  });
  @override
  List<Object?> get props => [userId];
}
