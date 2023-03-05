import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secondlife/authentification/login.dart';
import 'package:secondlife/authentification/singUp.dart';
import 'package:secondlife/home/Chat.dart';
import 'package:secondlife/home/Feed.dart';
import 'package:secondlife/home/Settings.dart';
import 'package:secondlife/home/position.dart';
import 'package:secondlife/home/search.dart';

import 'package:secondlife/welcome_pages/onbording.dart';
import 'package:secondlife/welcome_pages/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/splashScreen',
    routes: {
      '/login': (context) => login(),
      '/singUp': (context) => singup(),
      '/splashScreen': (context) => SplashScreem(),
      '/search': (context) => search(),
      '/chat': (context) => chat(),
      '/feed': (context) => feed(),
      '/position': (context) => position(),
      '/settings': (context) => settings(),
    },
    home: Onbording(),
  ));
}
