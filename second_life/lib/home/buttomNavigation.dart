import 'package:flutter/material.dart';
import 'package:secondlife/home/Chat.dart';
import 'package:secondlife/home/Feed.dart';
import 'package:secondlife/home/Settings.dart';
import 'package:secondlife/home/position.dart';
import 'package:secondlife/home/search.dart';

class buttomNavigation extends StatefulWidget {
  const buttomNavigation({super.key});

  @override
  State<buttomNavigation> createState() => _buttomNavigationState();
}

class _buttomNavigationState extends State<buttomNavigation> {
  int selectetedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectetedIndex = index;
    });
  }

  final _widgetsExamples = [
    search(),
    chat(),
    feed(),
    position(),
    settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(
          child: _widgetsExamples[selectetedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: 30,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectetedIndex,
        backgroundColor: Color.fromARGB(210, 255, 255, 255),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Position',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
