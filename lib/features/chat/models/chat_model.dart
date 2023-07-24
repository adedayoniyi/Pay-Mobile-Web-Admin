import 'dart:convert';

class ChatModel {
  String id;
  String chatName;
  String sender;
  String receiver;
  String latestMessage;

  ChatModel({
    required this.id,
    required this.chatName,
    required this.sender,
    required this.receiver,
    required this.latestMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatName': chatName,
      'sender': sender,
      'receiver': receiver,
      'latestMessage': latestMessage,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['_id'] ?? '',
      chatName: map['chatName'] ?? '',
      sender: map['sender'] ?? '',
      receiver: map['receiver'] ?? '',
      latestMessage: map['latestMessage'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(Map<String, dynamic> source) =>
      ChatModel.fromMap(source);
}
