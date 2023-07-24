import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_web_admin/features/chat/models/chat_model.dart';
import 'package:pay_mobile_web_admin/features/chat/models/message_model.dart';
import 'package:pay_mobile_web_admin/features/chat/services/chat_services.dart';
import 'package:pay_mobile_web_admin/features/chat/widgets/receivers_message_card.dart.dart';
import 'package:pay_mobile_web_admin/features/chat/widgets/senders_message_card.dart';
import 'package:pay_mobile_web_admin/widgets/custom_textfield.dart';

class ChatScreen extends StatefulWidget {
  static const String route = "/chat-screen";
  final ChatModel chatModel;
  const ChatScreen({
    Key? key,
    required this.chatModel,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _textController;
  late final ScrollController _scrollController;
  late final IO.Socket socket;
  late final StreamController<List<MessageModel>> _streamController;
  final ChatServices chatServices = ChatServices();

  @override
  void initState() {
    super.initState();
    //final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    //print(chatProvider.chat.id);
    _textController = TextEditingController();
    _scrollController = ScrollController();
    socket = IO.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'pingTimeout': 120000,
      'cors': {'origin': uri},
    });
    _streamController = StreamController<List<MessageModel>>();

    socket.emit('join', {'chatId': widget.chatModel.id});
    socket.on('message', (data) {
      _streamController.add([MessageModel.fromJson(data)]);
      print(_streamController);
    });
    loadMessages();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    socket.dispose();
    _streamController.close();
    super.dispose();
  }

  Future<void> loadMessages() async {
    final messages = await chatServices.getAllMessages(
        context: context, chatId: widget.chatModel.id);
    _streamController.add(messages);
  }

  void _sendMessage() async {
    if (_textController.text.isNotEmpty) {
      //final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      socket.emit('sendMessage', {
        'chatId': widget.chatModel.id,
        'sender': widget.chatModel.receiver,
        'receiver': widget.chatModel.receiver,
        'content': _textController.text,
      });

      _textController.clear();
      FocusScope.of(context).unfocus();
      Timer(
        const Duration(milliseconds: 300),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data!;
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        if (message.sender == widget.chatModel.receiver) {
                          return SendersMessageCard(
                              message: message.content,
                              dateTime:
                                  '${message.createdAt.day}/${message.createdAt.month}/${message.createdAt.year} ${message.createdAt.hour}:${message.createdAt.minute}',
                              user: "You");
                        } else {
                          return ReceiversMessageCard(
                            message: message.content,
                            dateTime:
                                '${message.createdAt.day}/${message.createdAt.month}/${message.createdAt.year} ${message.createdAt.hour}:${message.createdAt.minute}',
                            user: 'Pay Mobile User',
                          );
                        }
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _textController,
                      hintText: 'Enter your message',
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
