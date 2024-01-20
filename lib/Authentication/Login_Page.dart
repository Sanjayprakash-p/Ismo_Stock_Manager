import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Constants/Decorations.dart';
import '../Constants/Images.dart';
import '../Constants/colors.dart';
import '../Home/Employee_Home.dart';
import '../Home/bottomnavigation.dart';
import '../main.dart';
import 'Admin_Login.dart';
import 'Forgot_Password.dart';
import 'Sign_Up_Page.dart';
import 'package:google_sign_in/google_sign_in.dart';

String? selectedStock;
List checking = [];
bool flag = false;
bool loading = false;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // @override
  // void initState() {
  //   check();
  //   super.initState();
  // }
  Future<User?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in process
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      // User signed in
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => exitApp(context),
      child: Scaffold(
        // backgroundColor: authbackcolor,
        body:
            /* loading
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            :*/
            GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(FadeRoute(page: adlog()));
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return adlog();
                                    },
                                  ),
                                );*/
                              },
                              child: Image.asset(
                                admin,
                                height: height * 0.1,
                                width: width * 0.1,
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Login",
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
                              border: authdecorationpass(),
                              focusedErrorBorder: authdecorationpass(),
                              enabledBorder: authdecorationpass(),
                              hintText: 'Password',
                              focusedBorder: authdecorationpass(),
                              errorBorder: authdecorationpass(),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                            ),
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("please enter valid password min 6 character");
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
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          FadeRoute(page: const Forgotpw()));
                                    },
                                    child: Text(
                                      "Forgot Password ?",
                                      style:
                                          TextStyle(color: authstabletextcolor),
                                    ))
                              ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('permissions')
                              .doc('waiting')
                              .collection('permission')
                              .snapshots(),
                          builder: (context, sna) {
                            // print('fodsoisdfis${sna.data!.docs}');
                            if (!sna.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              var ss = sna.data!.docs.toList();
                              checking.clear();
                              for (var data in ss) {
                                checking.add(
                                  data.data(),
                                );
                              }

                              // print('fodsoisdfis${checking}');
                              return MaterialButton(
                                shape: authbuttonshape(),
                                elevation: 5.0,
                                height: 40,
                                onPressed: () {
                                  setState(() {
                                    flag = false;
                                  });
                                  if (_formkey.currentState!.validate()) {
                                    for (int i = 0; i < checking.length; i++) {
                                      if (checking[i]['email'] ==
                                          emailController.text) {
                                        setState(() {
                                          flag = true;
                                        });
                                        if (checking[i]['login'] == true) {
                                          //if (!mounted) return;

                                          signIn(emailController.text,
                                              passwordController.text);

                                          // print('fmkdmfslk${checking[i]}');
                                          break;
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const AlertDialog(
                                                  content: Text(
                                                      'Admin Has Not Accepted Your Request'),
                                                );
                                              });
                                        }
                                      }
                                    }
                                    if (flag == false) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              content: Text(
                                                  "User Mail Id Does Not Exist"),
                                            );
                                          });
                                    }
                                  }
                                },
                                color: authbuttoncolor,
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 20, color: authbuttontextcolor),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () async {
                            User? user = await _handleSignIn();
                            if (user != null) {
                              // User signed in successfully, you can navigate to the next screen or perform further actions.
                              print('User signed in: ${user.displayName}');
                            } else {
                              // Handle sign-in error or cancellation
                              print('Sign-in failed or canceled');
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/google.png',
                              height: height * 0.1,
                              width: width * 0.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.2,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        shape: authbuttonshape(),
                        elevation: 5.0,
                        height: 40,
                        onPressed: () {
                          Navigator.of(context)
                              .push(FadeRoute(page: Register()));
                        },
                        color: authbuttoncolor,
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                            color: authbuttontextcolor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    String? token;
    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        loading = true;
      });
      if (mounted) {
        await FirebaseFirestore.instance
            .collection('permissions')
            .doc('waiting')
            .collection('permission')
            .doc(user!.uid)
            .update({'uid': token});

        Navigator.of(context).push(FadeRoute(page: navigation()));
        ScaffoldMessenger.of(context)
            .showSnackBar(snacks("You've Successfully Logged In"));
      }
    } on FirebaseAuthException catch (e) {
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
