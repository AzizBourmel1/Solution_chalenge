import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:secondlife/chat/chat_screen/modele/chat_message.dart';

class MessageText extends StatelessWidget {
  const MessageText({super.key, required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          !(message.isSender)
              ? Text(
                  "Karim",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                )
              : SizedBox(
                  height: 3,
                ),
          Text(
            message.text,
            style: TextStyle(
                color: message.isSender ? Colors.white : Colors.black),
          )
        ],
      ),
    );
  }
}
