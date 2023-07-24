import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String chatId; //a quale chat appartiene il messaggio
  final String senderId; //id dell'utente che invia
  final String recipientId; //id di chi riceve
  final String text;
  final DateTime createdAt;
  const Message({
    required this.chatId,
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.createdAt,
  });

  @override
  List<Object> get props {
    return [
      chatId,
      senderId,
      recipientId,
      text,
      createdAt,
    ];
  }
}
