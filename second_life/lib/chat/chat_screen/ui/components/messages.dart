import 'package:flutter/material.dart';
import 'package:secondlife/chat/chat_screen/modele/chat_message.dart';
import 'package:secondlife/chat/chat_screen/ui/components/message_text.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.message, required this.index});
  final ChatMessage message;
  final int index;
  @override
  Widget build(BuildContext context) {
    Widget messsageContain(ChatMessage message, int index) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return MessageText(message: message);
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            CircleAvatar(
              child: Image.asset("assets/login.png"),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
          messsageContain(message, index)
        ],
      ),
    );
  }
}
