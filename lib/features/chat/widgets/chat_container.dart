import 'package:flutter/material.dart';

import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';

class ChatContainer extends StatelessWidget {
  final String username;
  final String latestMessage;
  const ChatContainer({
    Key? key,
    required this.username,
    required this.latestMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: screenWidth,
      decoration: BoxDecoration(
        color: greyScale850,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            child: Center(
              child: Text(username[0].toUpperCase()),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "User's Username:$username",
                style: TextStyle(fontSize: 23),
              ),
              Text(latestMessage)
              // Text(
              //   userChatName,
              //   style: TextStyle(fontSize: 23),
              // ), //
            ],
          ),
        ],
      ),
    );
  }
}
