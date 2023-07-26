// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_list_bloc.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object> get props => [];
}

class ChatGetChats extends ChatListEvent {
  final String userId;
  const ChatGetChats({
    required this.userId,
  });
  @override
  List<Object> get props => [userId];
}
