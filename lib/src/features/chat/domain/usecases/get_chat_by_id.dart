import 'package:flutter_social_clean/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

import '../entities/chat.dart';

class GetChatById implements UseCase<Chat, GetChatByIdParams> {
  final ChatRepository chatRepository;
  GetChatById({
    required this.chatRepository,
  });
  @override
  Future<Chat?> call(GetChatByIdParams params) {
    return chatRepository.getChatById(params.userId, params.chatId);
  }
}

class GetChatByIdParams extends Params {
  final String chatId;
  final String userId;
  GetChatByIdParams({
    required this.chatId,
    required this.userId,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [chatId, userId];
}
