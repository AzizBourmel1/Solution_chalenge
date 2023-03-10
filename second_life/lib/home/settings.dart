import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  String imagePath = "";
  void getImage() async {
    ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    imagePath = pickedImage!.path;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.green[300],
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            child: Column(children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: (imagePath == "")
                        ? Image.asset(
                            "assets/user.png",
                            height: 100,
                            width: 100,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.file(
                              File(imagePath),
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.fill,
                            )),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 2,
                    child: InkWell(
                      onTap: getImage,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Aziz Bourmel",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ]),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              child: Column(
            children: [
              Text(
                "User information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 1,
                width: 350,
                child: Material(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      label: Text("User Name "),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: "your mail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: "Number Phone",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      labelText: "New Passeword",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton.icon(
                  // <-- ElevatedButton

                  onPressed: () {},

                  icon: Icon(
                    Icons.upgrade,
                    size: 28.0,
                  ),

                  label: Text('Upgrade'),
                ),
              ),
            ],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Logout'),
        icon: const Icon(Icons.logout),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
