import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:secondlife/home/buttomNavigation.dart';

class feed extends StatefulWidget {
  const feed({super.key});

  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  label: Text("Search "),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 280,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 160, 232, 162)),
                            ],
                          ),
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage("assets/login.png"),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Title",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "discription dsqiybfd zyebf zieybf zfyvbrze azbdfe zyefvb'z ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => buttomNavigation(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Consulter",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15),
                                ),
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 280,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 160, 232, 162)),
                            ],
                          ),
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage("assets/login.png"),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Title",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "discription dsqiybfd zyebf zieybf zfyvbrze azbdfe zyefvb'z ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => buttomNavigation(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Consulter",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15),
                                ),
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
