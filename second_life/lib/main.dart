import 'package:flutter/material.dart';
import 'package:secondlife/authentification/login.dart';
import 'package:secondlife/authentification/singUp.dart';
import 'package:secondlife/welcome_pages/guide.dart';
import 'package:secondlife/welcome_pages/onbording.dart';
import 'package:secondlife/welcome_pages/splashScreen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashScreen',
      routes: {
        '/guide': (context) => guide(),
        '/login': (context) => login(),
        '/singUp': (context) => singup(),
        '/splashScreen': (context) => SplashScreem(),
      },
      home: Onbording(),
    ));
