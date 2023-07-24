import 'package:flutter/material.dart';

import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/widgets/width_space.dart';

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
          color: greyScale850, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              child: Center(
                child: Text(username[0].toUpperCase()),
              ),
            ),
            WidthSpace(20),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "User's Username: $username",
                    style: const TextStyle(fontSize: 23),
                  ),
                  Text(
                    "Latest Message: $latestMessage",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
