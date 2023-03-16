import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class form extends StatefulWidget {
  const form({super.key});

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  String imagePath = "";
  String error = "";
  late Position cl;
  var lat;
  var long;
  late File file;
  ImagePicker picker = ImagePicker();
  String url = "";
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  TextEditingController _productController = new TextEditingController();
  TextEditingController _quantityController = new TextEditingController();

  uploadImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      imagePath = pickedImage.path;
      var imageName = basename(imagePath);
      file = File(imagePath);

      var refStorage = FirebaseStorage.instance.ref('posts');
      UploadTask uploadTask = refStorage.child("$imageName").putFile(file);
      String link = await (await uploadTask).ref.getDownloadURL();
      setState(() {
        url = link;
        error = "";
      });
    }
  }

  getLastAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl.latitude;
    long = cl.longitude;
    setState(() {});
  }

  addProduct() {
    var formData = formState.currentState;
    if (formData!.validate()) {
      if (url == "") {
        error = "Wait until the image uploaded";
        setState(() {});
      } else {
        CollectionReference postsRef =
            FirebaseFirestore.instance.collection("posts");
        String product = _productController.text;
        String quantity = _quantityController.text;
        Map<String, dynamic> document = {
          'product': product,
          'quantity': quantity,
          'latitude': lat,
          'longitude': long,
          'image': url,
          'phone': FirebaseAuth.instance.currentUser!.email
        };
        postsRef.add(document);
      }
    } else {
      print("not valid");
    }
  }

  @override
  void initState() {
    getLastAndLong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: SingleChildScrollView(
        child: lat == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                    child: Form(
                  key: formState,
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
                        validator: (val) {
                          if (val == "") {
                            return "Fill this field";
                          }
                        },
                        controller: _productController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.production_quantity_limits_sharp),
                            labelText: "How mush do you have in kg ?",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == "") {
                            return "Fill this field";
                          }
                        },
                        controller: _quantityController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton.icon(
                          // <-- ElevatedButton

                          onPressed: () {
                            uploadImage();
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
                      error != ""
                          ? SizedBox(
                              width: 280,
                              height: 280,
                              child: Text(
                                error,
                                textAlign: TextAlign.center,
                              ))
                          : SizedBox(
                              width: 1,
                              height: 1,
                              child: Text(
                                "",
                                textAlign: TextAlign.center,
                              )),
                    ],
                  ),
                )),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("Adding post");
          addProduct();
        },
        label: const Text('Confirm'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
