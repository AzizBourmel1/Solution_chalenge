import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secondlife/authentification/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io';

class singup extends StatefulWidget {
  const singup({super.key});

  @override
  State<singup> createState() => _singupState();
}

class _singupState extends State<singup> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  signUp() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                title: "Error",
                desc: "Password and Confirm Password are different")
            .show();
      } else {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim());
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: "Congratulation",
                  desc:
                      "Account created successfully check your email for validation")
              .show();
          User? user = FirebaseAuth.instance.currentUser!;
          await user.sendEmailVerification();
          sleep(const Duration(seconds: 2));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => login()));
          return userCredential;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    title: "Error",
                    desc: "The password provided is too weak")
                .show();
          } else if (e.code == 'email-already-in-use') {
            AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    title: "Error",
                    desc: "The account already exists for that email")
                .show();
          }
        } catch (e) {
          print(e);
        }
      }
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: formState,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "SecondLife",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Text(
                    "create account",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == "") {
                          return "Fill username field";
                        }
                        if (val!.length <= 2) {
                          return "Username must be at least 3 characters";
                        }
                      },
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        label: Text("Username"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == "") {
                          return "Fill email field";
                        }
                        if (!EmailValidator.validate(val!)) {
                          return "Please enter a valid email";
                        }
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        label: Text("Email"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (val) {
                        if (val == "") {
                          return "Fill password field";
                        }
                        if (val!.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                      },
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        label: Text("Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (val) {
                        if (val == "") {
                          return "Fill confirm password field";
                        }
                        if (val!.length < 8) {
                          return "Confirm password must be at least 8 characters";
                        }
                      },
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        label: Text("Confirm Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    width: 200,
                    child: Material(
                      elevation: 5,
                      color: Color.fromARGB(255, 11, 224, 21),
                      borderRadius: BorderRadius.circular(10),
                      child: MaterialButton(
                        onPressed: () async {
                          await signUp();
                        },
                        child: Text(
                          "Sing up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Al ready have an account?",
                        style: TextStyle(color: Color.fromARGB(151, 0, 0, 0)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => login()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 1,
                        width: 100,
                        child: Material(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Or",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 1,
                        width: 100,
                        child: Material(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            FontAwesomeIcons.twitter,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
