import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  String imagePath = "";
  late File file;
  ImagePicker picker = ImagePicker();
  List dataUser = [];
  late String docID;
  String url = "";
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _familyNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  // TextEditingController _oldPassword = new TextEditingController();
  // TextEditingController _newPasswordController = new TextEditingController();
  // TextEditingController _confirmPasswordController =
  //     new TextEditingController();

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

  getDocument() async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("users");
    QuerySnapshot snapshot = await userRef
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    List<QueryDocumentSnapshot> data = snapshot.docs;
    setState(() {
      docID = data[0].id;
      dataUser.add(data[0].data());
    });
  }

  uploadImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imagePath = pickedImage.path;
      var imageName = basename(imagePath);
      file = File(imagePath);

      var refStorage = FirebaseStorage.instance.ref('avatars');
      UploadTask uploadTask = refStorage.child("$imageName").putFile(file);
      String link = await (await uploadTask).ref.getDownloadURL();
      setState(() {
        url = link;
      });
      Map<String, dynamic> document = {'image': url};
      userRef.doc(docID).update(document);
    }
  }

  updateData() async {
    String name, familyName, email, phoneNumber;
    _nameController.text == ""
        ? name = dataUser[0]['name']
        : name = _nameController.text;
    _familyNameController.text == ""
        ? familyName = dataUser[0]['family_name']
        : familyName = _familyNameController.text;
    _emailController.text == ""
        ? email = dataUser[0]['email']
        : email = _emailController.text;
    _phoneNumberController.text == ""
        ? phoneNumber = dataUser[0]['phone_number']
        : phoneNumber = _phoneNumberController.text;

    print("email ${email}");

    Map<String, dynamic> document = {
      'email': email,
      'family_name': familyName,
      'name': name,
      'phone_number': phoneNumber,
      'image': ""
    };
    userRef.doc(docID).update(document);
  }

  @override
  void initState() {
    getDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataUser == null || dataUser.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
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
                            child: (dataUser[0]['image'] == "")
                                ? Image.asset(
                                    "assets/user.png",
                                    height: 100,
                                    width: 100,
                                  )
                                : Image.network(
                                    "${dataUser[0]['image']}",
                                    height: 100.0,
                                    width: 100.0,
                                  )),
                        Positioned(
                          bottom: 3,
                          right: 2,
                          child: InkWell(
                            onTap: uploadImage,
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
                      dataUser[0]['name'] != ""
                          ? dataUser[0]['name'] +
                              " " +
                              dataUser[0]["family_name"]
                          : "",
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                        controller: _nameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            label: dataUser[0]["name"] != ""
                                ? Text(dataUser[0]["name"])
                                : Text("name"),
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
                        controller: _familyNameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            label: dataUser[0]["family_name"] != ""
                                ? Text(dataUser[0]["family_name"])
                                : Text("family_name"),
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
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            label: dataUser[0]["email"] != ""
                                ? Text(dataUser[0]["email"])
                                : Text("email"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            label: dataUser[0]["phone_number"] != ""
                                ? Text(dataUser[0]["phone_number"])
                                : Text("phone_number"),
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
                            labelText: "old Passeword",
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
                      width: 350,
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            labelText: "Confirm Passeword",
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

                        onPressed: () async {
                          await updateData();
                        },

                        icon: Icon(
                          Icons.update,
                          size: 28.0,
                        ),

                        label: Text('update'),
                      ),
                    ),
                  ],
                ))
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed("/login");
        },
        label: const Text('Logout'),
        icon: const Icon(Icons.logout),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
