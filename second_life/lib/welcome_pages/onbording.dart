import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:secondlife/authentification/login.dart';
import 'package:secondlife/home/buttomNavigation.dart';

import 'content_model.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        contents[i].image,
                        height: 350,
                      ),
                      Text(
                        contents[i].title,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 70,
                margin: EdgeInsets.only(left: 300),
                child: FloatingActionButton(
                  child: Text(
                    currentIndex == contents.length - 1 ? "Terminer" : "Skip",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => buttomNavigation(),
                      ),
                    );

                    _controller.nextPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  },
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
