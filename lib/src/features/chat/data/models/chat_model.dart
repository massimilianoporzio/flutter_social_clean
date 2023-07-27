// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_social_clean/src/features/chat/data/models/message_model.dart';
import 'package:flutter_social_clean/src/shared/data/models/user_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../../domain/entities/chat.dart';
part 'chat_model.g.dart';

//GLI INPUT non essendo primitivi sono dei MODELs NON delle entities.
@HiveType(typeId: 3) //quarto model
class ChatModel {
  @HiveField(0)
  final String id; //uuid della chat
  @HiveField(1)
  final UserModel
      currentUser; //utente corrente //hanno già il loro type adapter
  @HiveField(2)
  final UserModel otherUser; //altro utente a cui scrivo
  @HiveField(3)
  final List<MessageModel>? messages; //eventuali messaggi
  ChatModel({
    required this.id,
    required this.currentUser,
    required this.otherUser,
    this.messages,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'currentUser': currentUser.toMap(),
  //     'otherUser': otherUser.toMap(),
  //     'messages': messages.map((x) => x?.toMap()).toList(),
  //   };
  // }

  factory ChatModel.fromJson(
    Map<String, dynamic> json,
    Map<String, dynamic> jsonCurrentUser,
    Map<String, dynamic> jsonOtherUser,
  ) {
    return ChatModel(
      id: json['id'] as String,
      currentUser: UserModel.fromJson(jsonCurrentUser),
      otherUser: UserModel.fromJson(jsonOtherUser),
      messages: (json['messages'] as List).map((message) {
        return MessageModel.fromJson(message, json['id']);
      }).toList(),
    );
  }

  factory ChatModel.fromEntity(Chat chat) {
    return ChatModel(
        id: chat.id,
        currentUser: UserModel.fromEntity(chat.currentUser),
        otherUser: UserModel.fromEntity(chat.otherUser),
        messages:
            chat.messages!.map((e) => MessageModel.fromEntity(e)).toList());
  }
  //LA UI usa SEMPRE le entities MAI i model
  Chat toEntity() {
    return Chat(
      id: id,
      currentUser: currentUser.toEntity(),
      otherUser: otherUser.toEntity(),
      messages: messages!.map((e) => e.toEntity()).toList(),
    );
  }

  // String toJson() => json.encode(toMap());
}
