import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:secondlife/chat/content/chats_body.dart';

class chatListScreen extends StatefulWidget {
  const chatListScreen({super.key});

  @override
  State<chatListScreen> createState() => _chatListScreenState();
}

class _chatListScreenState extends State<chatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: chatsBody(),
    );
  }
}
