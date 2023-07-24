import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/core/error/error_handler.dart';
import 'package:pay_mobile_web_admin/core/utils/custom_dialogs.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/features/auth/providers/user_provider.dart';
import 'package:pay_mobile_web_admin/features/chat/models/chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:pay_mobile_web_admin/features/chat/models/message_model.dart';
import 'package:provider/provider.dart';

class ChatServices {
  Future<List<ChatModel>> getAllChats({
    required BuildContext context,
  }) async {
    List<ChatModel> chatModel = [];
    // final userToken =
    //     Provider.of<UserProvider>(context, listen: false).user.token;
    //final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getAllChats"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      statusCodeHandler(
        context: context,
        response: res,
        onSuccess: () {
          chatModel = (jsonDecode(res.body) as List)
              .map((data) => ChatModel.fromJson(data))
              .toList();
          print("Chat Model $chatModel");
        },
      );
    } on Error catch (e) {
      print('Get All Chats Error $e');
    }
    return chatModel;
  }

  Future<List<ChatModel>> getAgentChat({
    required BuildContext context,
    required String username,
  }) async {
    List<ChatModel> chatModel = [];
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    //final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getAgentChat/$username"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userToken,
        },
      );

      statusCodeHandler(
        context: context,
        response: res,
        onSuccess: () {
          chatModel = (jsonDecode(res.body) as List)
              .map((data) => ChatModel.fromJson(data))
              .toList();
          print("Chat Model $chatModel");
        },
      );
    } on Error catch (e) {
      print('Get All Agent Chats Error $e');
    }
    return chatModel;
  }

  void createChat({
    required BuildContext context,
    required String sender,
    required String receiver,
    required String chatName,
  }) async {
    // final userToken =
    //     Provider.of<UserProvider>(context, listen: false).user.token;
    //final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    try {
      ChatModel chatModel = ChatModel(
        id: "",
        chatName: chatName,
        sender: sender,
        receiver: receiver,
        latestMessage: '',
      );
      //showDialogLoader(context);
      http.Response res = await http
          .post(
            Uri.parse("$uri/api/chat"),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: chatModel.toJson(),
          )
          .timeout(const Duration(seconds: 25));

      //Navigator.of(context, rootNavigator: true).pop('dialog');
      statusCodeHandler(
        context: context,
        response: res,
        onSuccess: () {},
      );
    } on Error catch (e) {
      print('Create Chat Error $e');
    }
  }

  Future<List<MessageModel>> getAllMessages({
    required BuildContext context,
    required String chatId,
  }) async {
    List<MessageModel> messageModel = [];
    // final userToken =
    //     Provider.of<UserProvider>(context, listen: false).user.token;
    //final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse("$uri/chat/$chatId/messages"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      statusCodeHandler(
        context: context,
        response: res,
        onSuccess: () {
          messageModel = (jsonDecode(res.body) as List)
              .map((data) => MessageModel.fromJson(data))
              .toList();
        },
      );
    } on Error catch (e) {
      print('Get Message Error $e');
    }
    return messageModel;
  }
}
