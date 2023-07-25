import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

import '../../domain/entities/message.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
part 'message_model.g.dart';

@HiveType(typeId: 2) //terzo modello
class MessageModel {
  @HiveField(0)
  final String chatId; //a quale chat appartiene il messaggio
  @HiveField(1)
  final String senderId; //id dell'utente che invia
  @HiveField(2)
  final String recipientId; //id di chi riceve
  @HiveField(3)
  final String text;
  @HiveField(4)
  final DateTime createdAt;
  MessageModel({
    required this.chatId,
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'senderId': senderId,
      'recipientId': recipientId,
      'text': text,
      // 'createdAt': createdAt.illisecondsSinceEpoch,
      'createdAt': createdAt,
    };
  }

  //*il chatId NON sta dentro il 'json' (la mappa dinamica)
  factory MessageModel.fromJson(Map<String, dynamic> json, String chatId) {
    return MessageModel(
      chatId: chatId,
      senderId: json['senderId'] as String,
      recipientId: json['recipientId'] as String,
      text: json['text'] as String,
      // createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      createdAt: json['createdAt'],
    );
  }
  //NON uso mapper faccio + semplice
  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
        chatId: message.chatId,
        senderId: message.senderId,
        recipientId: message.recipientId,
        text: message.text,
        createdAt: message.createdAt);
  }
  Message toEntity() {
    return Message(
        chatId: chatId,
        senderId: senderId,
        recipientId: recipientId,
        text: text,
        createdAt: createdAt);
  }

  String toJson() => json.encode(toMap());
}
