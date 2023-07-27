// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bubble/bubble.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';

import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../blocs/chat/chat_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //per gestire la grandezza delle bubbles di messaggi
    return Scaffold(
      appBar: _CustomAppBar(),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is ChatLoaded) {
            ScrollController scrollController = new ScrollController();
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: const AssetImage('assets/images/wallpaper.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              )),
              child: SafeArea(
                minimum: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(8),
                        shrinkWrap:
                            true, //NON si espande ma tiene solo il suo spazio
                        itemCount: state.chat.messages!.length,
                        itemBuilder: (context, index) {
                          Message message = state.chat.messages![index];
                          return _MessageCard(
                            width: size.width,
                            message: message,
                          );
                        },
                      ),
                    ),
                    _CustomTextFormField(),
                  ],
                ),
              ),
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}

class _CustomTextFormField extends StatelessWidget with UiLoggy {
  const _CustomTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            if (controller.text.isNotEmpty) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              context
                  .read<ChatBloc>()
                  .add(ChatUpdateChat(text: controller.text));
              controller.clear();
              SchedulerBinding.instance.addPostFrameCallback((_) {
                //
              });
            }
          },
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: "Type your text here...",
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade900),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  final double width;
  final Message message;
  const _MessageCard({
    Key? key,
    required this.width,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //leggo usando il context perché sono DENTRO un widget privato
    Chat currentChat = (context.read<ChatBloc>().state as ChatLoaded).chat;
    String userId = currentChat.currentUser.id;
    bool isSender = message.senderId == userId;
    bool isLastMessage = currentChat.messages!.last == message;
    int messageIndex = currentChat.messages!.indexOf(message);
    Message? nextMessage = isLastMessage
        ? null
        : currentChat.messages!.elementAt(messageIndex + 1);
    bool isFirstMessage = currentChat.messages!.indexOf(message) == 0;
    bool isLastMessageFromSender =
        isLastMessage ? true : nextMessage!.senderId != message.senderId;
    Alignment alignment =
        isSender ? Alignment.centerLeft : Alignment.centerRight;
    Color color = isSender
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
    return Bubble(
      stick: false,
      alignment: alignment,
      margin: BubbleEdges.only(top: isFirstMessage ? 0 : 10),
      color: color,
      nip: isLastMessageFromSender
          ? isSender
              ? BubbleNip.leftTop
              : BubbleNip.rightTop
          : BubbleNip.no,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.5 * width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                Text(
                  '${message.createdAt.hour}:${message.createdAt.minute}',
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            'Username',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Online',
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: CircleAvatar(backgroundColor: Colors.white),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
