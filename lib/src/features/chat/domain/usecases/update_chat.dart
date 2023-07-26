// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

import '../entities/chat.dart';

class UpdateChat implements UseCase<void, UpdateChatParams> {
  final ChatRepository chatRepository;
  UpdateChat({
    required this.chatRepository,
  });
  @override
  call(UpdateChatParams params) {
    return chatRepository.updateChat(params.chat);
  }
}

class UpdateChatParams extends Params {
  final Chat chat;
  UpdateChatParams({
    required this.chat,
  });

  @override
  List<Object?> get props => [chat];
}
