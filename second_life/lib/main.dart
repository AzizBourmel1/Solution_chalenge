import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secondlife/authentification/login.dart';
import 'package:secondlife/authentification/singUp.dart';
import 'package:secondlife/chat/Ui/chat_liste_screen.dart';
import 'package:secondlife/home/feed.dart';
import 'package:secondlife/home/settings.dart';
import 'package:secondlife/position/form.dart';
import 'package:secondlife/position/position.dart';
import 'package:secondlife/search/search.dart';
import 'package:secondlife/home/buttomNavigation.dart';
import 'package:secondlife/welcome_pages/onbording.dart';
import 'package:secondlife/welcome_pages/splashScreen.dart';

bool isLogged = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogged = false;
  } else {
    isLogged = true;
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isLogged == false ? login() : buttomNavigation(),
    routes: {
      '/login': (context) => login(),
      '/singUp': (context) => singup(),
      '/splashScreen': (context) => SplashScreem(),
      '/search': (context) => search(),
      '/chat': (context) => chatListScreen(),
      '/feed': (context) => feed(),
      '/position': (context) => position(),
      '/settings': (context) => settings(),
      '/form': (context) => form(),
      '/home': (context) => Onbording(),
    },
  ));
}
