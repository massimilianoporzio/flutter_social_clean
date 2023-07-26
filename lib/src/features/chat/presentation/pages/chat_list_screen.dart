import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';

class ChatListScreen extends StatelessWidget with UiLoggy {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Chats'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state is ChatListLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is ChatListLoaded) {
            loggy.debug("CHATS: ${state.chats}");
            return ListView.builder(
              itemBuilder: (context, index) {
                return _Chat(
                  chat: state.chats[index],
                );
              },
              itemCount: state.chats.length,
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

class _Chat extends StatelessWidget {
  final Chat chat;
  const _Chat({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    Message? lastMessage =
        chat.messages == null ? null : chat.messages!.reversed.first;
    return ListTile(
      onTap: () {
        //passo la route con una mappa chiave valore
        context.go(context.namedLocation('chat',
            pathParameters: <String, String>{'chatId': chat.id}));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(chat.otherUser.imagePath!),
        radius: 30,
      ),
      title: Text(
        chat.otherUser.username.value,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        lastMessage == null ? "" : lastMessage.text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Text(
        lastMessage == null
            ? ""
            : "${lastMessage.createdAt.hour}:${lastMessage.createdAt.minute}",
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
