import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:secondlife/chat/Chat.dart';
import 'package:secondlife/chat/chat_screen/chat_screen.dart';
import 'package:secondlife/chat/content/chat_card.dart';

class chatsBody extends StatefulWidget {
  const chatsBody({super.key});

  @override
  State<chatsBody> createState() => _chatsBodyState();
}

class _chatsBodyState extends State<chatsBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCard(
                    chat: chatsData[index],
                    press: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => chatScreen())),
                  )),
        ),
      ],
    );
  }
}
