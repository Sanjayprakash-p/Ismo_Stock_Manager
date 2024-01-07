import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Constants/colors.dart';

import '../Home/bottomnavigation.dart';
import '../constants/Decorations.dart';
import '../main.dart';
import 'Login_Page.dart';

final ref1 = FirebaseFirestore.instance
    .collection('permissions')
    .doc('waiting')
    .collection('permission');

class adlog extends StatefulWidget {
  @override
  _adlogState createState() => _adlogState();
}

class _adlogState extends State<adlog> {
  bool _isObscure3 = true;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: authbackcolor,
      body: visible
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black54,
            ))
          : SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 120,
                            ),
                            Text(
                              "Admin Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: authstabletextcolor,
                                fontSize: 40,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: authpadding(),
                              child: TextFormField(
                                controller: emailController,
                                decoration: authdecoration('Email'),
                                /* decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),*/
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email cannot be empty";
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Please enter a valid email");
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  emailController.text = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: authpadding(),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: _isObscure3,
                                //decoration: authdecoration('Password'),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(_isObscure3
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure3 = !_isObscure3;
                                        });
                                      }),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  hintText: 'Password',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: errortextcolor),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: errortextcolor),
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                ),
                                validator: (value) {
                                  RegExp regex = RegExp(r'^.{6,}$');
                                  if (value!.isEmpty) {
                                    return "Password cannot be empty";
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("please enter valid password min. 6 character");
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  passwordController.text = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              shape: authbuttonshape(),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                signIn(emailController.text,
                                    passwordController.text);
                              },
                              color: authbuttoncolor,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20, color: authbuttontextcolor),
                              ),
                            ),
                            SizedBox(
                              height: 200,
                            ),
                            MaterialButton(
                              shape: authbuttonshape(),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                Navigator.of(context)
                                    .push(FadeRoute(page: LoginPage()));
                              },
                              color: authbuttoncolor,
                              child: Text(
                                "Go To Login",
                                style: TextStyle(
                                  color: authbuttontextcolor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        setState(() {
          visible = true;
        });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = FirebaseAuth.instance.currentUser;
        ref1.doc(user!.uid).get().then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            if (documentSnapshot.get('role') == "Admin") {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).push(FadeRoute(page: navigation()));
                ScaffoldMessenger.of(context)
                    .showSnackBar(snacks("You've Successfully Logged In"));
                /*Navigator.push(context,
                    MaterialPageRoute(builder: (context) => navigation()));*/
              });
            }
          }
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          visible = false;
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
      }
    }
  }
}
