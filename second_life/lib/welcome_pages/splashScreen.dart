import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:secondlife/authentification/login.dart';
import 'package:secondlife/welcome_pages/guide.dart';
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
      backgroundColor: Color.fromARGB(255, 33, 243, 40),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("SecondLife",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40)),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: SizedBox(
              height: 100,
              child: Image.asset("assets/logo.png"),
            ),
          )
        ],
      ),
    );
  }
}
