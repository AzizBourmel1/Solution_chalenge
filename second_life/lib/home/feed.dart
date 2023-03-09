import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:secondlife/home/buttomNavigation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class feed extends StatefulWidget {
  const feed({super.key});

  @override
  State<feed> createState() => _feedState();
}

List results = [];

class _feedState extends State<feed> {
  getFeed() async {
    results = [];
    var url = Uri.parse("https://feed-v1-3th2l3odha-ew.a.run.app/");
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    for (int i = 0; i < 5; i++) {
      results.add(responseBody[i]);
    }
    setState(() {
      results;
    });
  }

  @override
  void initState() {
    getFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dialog'),
        ),
        body: results == null || results.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, i) {
                  return Container(
                      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Column(children: [
                        Container(
                          height: 300,
                          width: 250,
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
                              Image.network("${results[i]['image']}"),
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
                                "${results[i]['text']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  await launchUrl(
                                    Uri.parse(results[i]['link']),
                                  );
                                  // Uri url = Uri.parse(results[i]['link']
                                  //     .replaceAll("https://", ""));
                                  // final visit = await launchUrl(
                                  //   url,
                                  //   mode: LaunchMode.externalApplication,
                                  // );
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
                        )
                      ]));
                }));
  }
}
