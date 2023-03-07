import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:secondlife/chat/chat_screen/ui/components/message_body.dart';

class chatScreen extends StatefulWidget {
  const chatScreen({super.key});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(context), body: MessageBody());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Aziz Bourmel",
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
