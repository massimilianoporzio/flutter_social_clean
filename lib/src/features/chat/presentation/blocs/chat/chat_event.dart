// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatGetChat extends ChatEvent {
  final String chatId;
  final String userId;
  const ChatGetChat({
    required this.chatId,
    required this.userId,
  });

  @override
  List<Object> get props => [chatId, userId];
}

class ChatUpdateChat extends ChatEvent {
  final String text;
  const ChatUpdateChat({
    required this.text,
  });
  @override
  List<Object> get props => [text];
}
