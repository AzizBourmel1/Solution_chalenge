import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:secondlife/chat/chat_screen/modele/chat_message.dart';
import 'package:secondlife/chat/chat_screen/ui/components/chat_input_field.dart';
import 'package:secondlife/chat/chat_screen/ui/components/messages.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({super.key});

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView.builder(
                itemCount: dummyCHatMessages.length,
                itemBuilder: (context, index) =>
                    Message(message: dummyCHatMessages[index], index: index)),
          ),
        ),
        ChatInputField()
      ],
    );
  }
}
