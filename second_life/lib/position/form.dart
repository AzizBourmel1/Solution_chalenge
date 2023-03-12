import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class form extends StatefulWidget {
  const form({super.key});

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
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
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  child: Title(
                      color: Colors.black,
                      child: Text(
                        "What do you have for us!!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.shopping_cart),
                      label: Text("What do you have?"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.production_quantity_limits_sharp),
                      labelText: "How mush do you have in kg ?",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: "Your locatoin ?",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton.icon(
                    // <-- ElevatedButton

                    onPressed: () {
                      getImage();
                    },

                    icon: Icon(
                      Icons.add_a_photo,
                      size: 28.0,
                    ),

                    label: Text('Choose a picture'),
                  ),
                ),
                SizedBox(
                  width: 280,
                  height: 280,
                  child: (imagePath == "")
                      ? Text(
                          "add a picture",
                          textAlign: TextAlign.center,
                        )
                      : Image.file(File(imagePath)),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => form(),
              ));
        },
        label: const Text('Confirm'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
