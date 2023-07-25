import 'package:flutter_social_clean/src/features/chat/data/models/chat_model.dart';
import 'package:flutter_social_clean/src/shared/data/datasources/chat_data.dart';

import '../../../../shared/data/datasources/user_data.dart';
import '../../domain/entities/chat.dart';

abstract interface class MockChatDatasource {
  Future<List<Chat>> getChatsByUser(String userid);
  Future<Chat> getChatById(String userId, String chatId);
  Future<void> updateChat(
      Chat chat); //per aggiornare i messaggi di una chat specifica
}

class MockChatDatasourceImpl implements MockChatDatasource {
  @override
  Future<Chat> getChatById(String userId, String chatId) async {
    await Future.delayed(const Duration(milliseconds: 300)); //simulo delay
    //prendo solo il primo poi costruisco le mappe 'json' per costruire il modello Chat e convertirlo in entity
    Map<String, dynamic> jsonChat =
        chats.firstWhere((chat) => chat['id'] == chatId);
    String currentUserId = userId;
    String otherUserId = (jsonChat['userIds'] as List)
        .firstWhere((element) => element['id'] != currentUserId);
    Map<String, dynamic> currentUser =
        users.firstWhere((element) => element['id'] == currentUserId);
    Map<String, dynamic> otherUser =
        users.firstWhere((element) => element['id'] == otherUserId);
    return ChatModel.fromJson(jsonChat, currentUser, otherUser).toEntity();
  }

  @override
  Future<List<Chat>> getChatsByUser(String userid) async {
    await Future.delayed(const Duration(milliseconds: 300)); //simulo delay
    //prendo LA LISTA DI TUTTE le chat che hanno dento 'userIds' lo userId
    //LE MAPPO e per ciascuna:
    //creo le mappe 'json' del currentUser e dell'otherUser (trovo l'id dell'other user)
    // prendendo dalla lista degli userId di quella chat il primo id diveso da userId
    //e con la mappe json creo un ChatModel che converto in entity
    return chats
        .where((chat) => (chat['userIds'] as List).contains(userid))
        .map((chat) {
      String currentUserId = userid;
      String otherUserId =
          (chat['userIds'] as List).firstWhere((id) => id != userid);
      Map<String, dynamic> currentUser =
          users.firstWhere((element) => element['id'] == currentUserId);
      Map<String, dynamic> otherUser =
          users.firstWhere((element) => element['id'] == otherUserId);

      return ChatModel.fromJson(chat, currentUser, otherUser).toEntity();
    }).toList();
  }

  @override
  Future<void> updateChat(Chat chat) async {
    await Future.delayed(const Duration(milliseconds: 300)); //simulo delay

    // TODO: implement updateChat USING HIVE
    throw UnimplementedError();
  }
}
