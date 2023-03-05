import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chat"),
      ),
    );
  }
}
