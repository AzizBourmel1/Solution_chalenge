import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:secondlife/authentification/login.dart';
import 'package:secondlife/chat/content/chats_body.dart';
import 'package:secondlife/welcome_pages/onbording.dart';

class SplashScreem extends StatefulWidget {
  const SplashScreem({super.key});

  @override
  State<SplashScreem> createState() => _SplashScreemState();
}

class _SplashScreemState extends State<SplashScreem> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Onbording())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SpinKitFoldingCube(
        color: Colors.white,
      ),
    );
  }
}
