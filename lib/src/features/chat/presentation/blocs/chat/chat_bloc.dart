import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/chat/domain/entities/message.dart';
import 'package:flutter_social_clean/src/features/chat/domain/usecases/get_chat_by_id.dart';
import 'package:flutter_social_clean/src/features/chat/domain/usecases/update_chat.dart';
import 'package:flutter_social_clean/src/logs/bloc_logger.dart';

import '../../../domain/entities/chat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> with BlocLoggy {
  final GetChatById _getChatById;
  final UpdateChat _updateChat;
  ChatBloc({
    required GetChatById getChatById,
    required UpdateChat updateChat,
  })  : _getChatById = getChatById,
        _updateChat = updateChat,
        super(ChatLoading()) {
    on<ChatGetChat>(_onChatGetChat);
    on<ChatUpdateChat>(_onChatUpdateChat);
  }

  FutureOr<void> _onChatGetChat(
    ChatGetChat event,
    Emitter<ChatState> emit,
  ) async {
    loggy.debug("Start getting chat with: _onChatGetChat");
    Chat chat = await _getChatById(
        GetChatByIdParams(chatId: event.chatId, userId: event.userId));
    emit(ChatLoaded(chat: chat));
  }

  FutureOr<void> _onChatUpdateChat(
    ChatUpdateChat event,
    Emitter<ChatState> emit,
  ) async {
    loggy.debug("Start updating chat with: _onChatUpdateChat");
    if (state is ChatLoaded) {
      final state = this.state as ChatLoaded;

//state BEFORE updating
      Message message = Message(
          chatId: state.chat.id,
          senderId: state.chat.currentUser.id,
          recipientId: state.chat.otherUser.id,
          text: event.text,
          createdAt: DateTime.now());
      //creo chat NUOVA che ha i vecchi messaggi E il nuovo
      Chat chat = state.chat
          .copyWith(messages: List.from(state.chat.messages!)..add(message));
      //AGGIORNO LA CHAT (creo nuova chat con IL NUOVO MESSAGGIO
      _updateChat(UpdateChatParams(chat: chat)); //NELLA LOCAL DATASOURCE

      emit(ChatLoaded(chat: chat));
    }
  }
}
