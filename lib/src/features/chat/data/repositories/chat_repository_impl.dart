// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/chat/data/datasources/local_chat_datasource.dart';
import 'package:flutter_social_clean/src/features/chat/data/datasources/mock_chat_datasource.dart';
import 'package:flutter_social_clean/src/features/chat/domain/entities/chat.dart';
import 'package:flutter_social_clean/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_social_clean/src/logs/repository_logger.dart';

class ChatRepositoryImpl with RepositoryLoggy implements ChatRepository {
  final LocalChatDatasource localChatDatasource;
  final MockChatDatasource remoteChatDatasource;
  ChatRepositoryImpl({
    required this.localChatDatasource,
    required this.remoteChatDatasource,
  });
  @override
  Future<Chat?> getChatById(String userId, String chatId) async {
    //TODO: check for updates from remote source;
    //cerco in locale
    Chat? chat = await localChatDatasource.getChatById(chatId);
    if (chat == null) {
      return remoteChatDatasource.getChatById(userId, chatId);
    } else {
      loggy.debug("Using local cached chat data");
      return chat; //essendo async ritorna una Future di chat
    }
  }

  @override
  Future<List<Chat>> getChatsByUser(String userId) async {
    //TODO: Check se in remoto ho updates per quelle chat
    //check se in local cache ho la lista di chat vuote
    if ((await localChatDatasource.getChats()).isEmpty) {
      List<Chat> chats = await remoteChatDatasource.getChatsByUser(userId);
      //GIRO LE CHAT TROVATE e le agg una a una alla cache locale
      for (final chat in chats) {
        localChatDatasource.addChat(chat); //serve await o no???
      }
      return chats;
    } else {
      return localChatDatasource.getChats();
    }
  }

  @override
  Future<void> updateChat(Chat chat) {
    //TODO: update in the remote datasource (real)
    return localChatDatasource.updateChat(chat);
  }
}
