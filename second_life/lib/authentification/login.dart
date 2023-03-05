import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secondlife/authentification/singUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:secondlife/home/buttomNavigation.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  signIn() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        User? user = FirebaseAuth.instance.currentUser;
        print(user!.emailVerified);
        // if (user!= null && !user.emailVerified) {
        //   await user.sendEmailVerification();
        // }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  title: "Error",
                  desc: "No user found for that email")
              .show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  title: "Error",
                  desc: "Wrong password provided for that user")
              .show();
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
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formState,
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: Image.asset("assets/login.png"),
                  ),
                  Text(
                    "SecondLife",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Text(
                    "Sing in to your account",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  SizedBox(height: 30),
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
                        prefixIcon: Icon(Icons.person),
                        label: Text("Email"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11.0,
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
                    height: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: Material(
                      elevation: 5,
                      color: Color.fromARGB(255, 11, 224, 21),
                      borderRadius: BorderRadius.circular(10),
                      child: MaterialButton(
                        onPressed: () async {
                          await signIn();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => buttomNavigation(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => singup()));
                      },
                      child: Text(
                        "Forget your password",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Color.fromARGB(151, 0, 0, 0)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => singup()));
                        },
                        child: Text(
                          "Sign up",
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
