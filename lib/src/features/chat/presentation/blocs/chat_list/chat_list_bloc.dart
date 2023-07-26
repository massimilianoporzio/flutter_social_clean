// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_social_clean/src/features/chat/domain/usecases/get_chats_by_user.dart';
import 'package:flutter_social_clean/src/logs/bloc_logger.dart';

import '../../../domain/entities/chat.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> with BlocLoggy {
  final GetChatsByUser _getChatsByUser;
  ChatListBloc({
    required GetChatsByUser getChatsByUser,
  })  : _getChatsByUser = getChatsByUser,
        super(ChatListLoading()) {
    on<ChatGetChats>(_onChatGetChats);
  }

  FutureOr<void> _onChatGetChats(
    ChatGetChats event,
    Emitter<ChatListState> emit,
  ) async {
    loggy.debug("Start getting chats by _onChatGetChats");
    List<Chat> chats =
        await _getChatsByUser(GetChatsByUserParams(userId: event.userId));
    //NON resituisco subito la chat ma riordino i messaggi in ordine cronologico
    chats.map((chat) {
      if (chat.messages != null) {
        chat.messages!.sort(
          (a, b) => a.createdAt.compareTo(b.createdAt),
        );
      }
    });
    //ORA EMETTO NUOVO STATO
    emit(ChatListLoaded(chats: chats));
  }
}
