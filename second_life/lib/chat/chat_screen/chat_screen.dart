import 'package:flutter/material.dart';
import 'package:secondlife/chat/chat.dart';
import 'package:secondlife/chat/chat_screen/ui/components/message_body.dart';

class chatScreen extends StatelessWidget {
  const chatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(context), body: MessageBody());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Aziz b",
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.local_phone),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.videocam),
        ),
        SizedBox(
          width: 20.0,
        ),
      ],
    );
  }
}
