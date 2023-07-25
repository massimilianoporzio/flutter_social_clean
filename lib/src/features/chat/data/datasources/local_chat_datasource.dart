//CLASS LOCALE LE CHAT SONO SOLO DI UN UTENTE
//non passo userId perché è solo di un utente
import 'package:hive/hive.dart';

import '../../domain/entities/chat.dart';
import '../models/chat_model.dart';

abstract class LocalChatDatasource {
  //TUTTE LE CHAT LOCALI
  Future<List<Chat>> getChats();
  //SOLO UNA SPECIFICA CHAT LOCALE
  Future<Chat?> getChatById(String chatId);
  //AGGIUNGO CHAT ALLE CHAT LOCALI
  Future<void> addChat(Chat chat);
  //AGGIORNO CHAT IN LOCALE
  Future<void> updateChat(Chat chat);
}

class LocalChatDatasourceImpl implements LocalChatDatasource {
  String boxName = 'chats'; //salvo i post nella scatola chiamata 'chats'
  Type boxType = ChatModel; //tipo di dato che salvo

  Future<Box<ChatModel>> _openBox() async {
    return Hive.openBox(boxName);
  }

  @override
  Future<void> addChat(Chat chat) async {
    final Box<ChatModel> box = await _openBox();
    return await box.put(chat.id, ChatModel.fromEntity(chat));
  }

  @override
  Future<Chat?> getChatById(String chatId) async {
    final Box<ChatModel> box = await _openBox();
    ChatModel? chatModel = box.get(chatId);
    return chatModel == null
        ? null
        : box.values.firstWhere((element) => element.id == chatId).toEntity();
  }

  @override
  Future<List<Chat>> getChats() async {
    final Box<ChatModel> box = await _openBox();
    return box.values.map((chat) => chat.toEntity()).toList();
  }

  @override
  Future<void> updateChat(Chat chat) async {
    final Box<ChatModel> box = await _openBox();
    return await box.put(chat.id, ChatModel.fromEntity(chat));
  }
}
