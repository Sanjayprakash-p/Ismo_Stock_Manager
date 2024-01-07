// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/Constants/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../Home/bottomnavigation.dart';
import '../Image/Image_Picker.dart';
import '../constants/Decorations.dart';
import '../main.dart';
import 'Login_Page.dart';

// import 'model.dart';
final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final ref1 = FirebaseFirestore.instance
    .collection('permissions')
    .doc('waiting')
    .collection('permission');
late List samm;
String error = '';
Future circle(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const AlertDialog(
            backgroundColor: Colors.transparent,
            title: Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            )),
          )));
}

class StoreData {
  Future<List> uploadImageToStorage(Uint8List file, String ku) async {
    Reference ref = _storage.ref().child(ku);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot2 = await uploadTask;
    String downloadUrl = await snapshot2.ref.getDownloadURL();
    return [downloadUrl];
  }

  Future<String> saveData({
    required Uint8List file,
    required String ku,
  }) async {
    String resp = " some error Occured";

    try {
      {
        List san = await uploadImageToStorage(file, ku);
        samm = san;
        resp = 'sucess';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _RegisterState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;

  Uint8List? _profile;
  Uint8List? file;
  Uint8List? _file;
  var datee = DateTime.now();

  Future selectImage() async {
    return showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            backgroundColor: dialogbackcolor,
            child: SizedBox(
              height: 80,
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Select Image', style: stabletextstyle()),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            style: buttonstyle(),
                            onPressed: () async {
                              Navigator.pop(context);
                              try {
                                Uint8List file =
                                    await pickimage(ImageSource.gallery);
                                setState(() {
                                  _file = file;
                                });
                              } catch (er) {
                                setState(() {
                                  error = "Please Select Image";
                                });
                              }
                            },
                            child: Text('Gallery', style: buttontextstyle())),
                        TextButton(
                            style: buttonstyle(),
                            onPressed: () async {
                              Navigator.pop(context);
                              try {
                                Uint8List file =
                                    await pickimage(ImageSource.camera);
                                setState(() {
                                  _file = file;
                                });
                              } catch (e) {
                                setState(() {
                                  error = "Please Select Image";
                                });
                              }
                            },
                            child: Text('Camera', style: buttontextstyle()))
                      ]),
                ],
              ),
            ),
          );
        }));
  }

  // selectImage() async {
  //   Uint8List img = await pickimage(ImageSource.camera);
  //   setState(() {
  //     _profile = img;
  //   });
  // }

  // File? file;
  var options = [
    'Manager',
    'Employee',
    'Intern',
  ];
  var _currentItemSelected = "Employee";
  var role = "Employee";
  @override
  void initState() {
    setState(() {
      error = '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: authbackcolor,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Register Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: authstabletextcolor,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(children: [
                      Center(
                          child: _file != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: MemoryImage(_file!),
                                )
                              : const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      'https://img.favpng.com/2/24/0/computer-icons-avatar-user-profile-png-favpng-HPjiNes3x112h0jw38sbfpDY9.jpg'),
                                )),
                      Positioned(
                          bottom: -10,
                          left: 200,
                          child: IconButton(
                              onPressed: selectImage,
                              icon: Icon(
                                Icons.add_a_photo,
                                color: authstabletextcolor,
                              ))),
                    ]),
                    Text(
                      error,
                      style: TextStyle(color: errortextcolor),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: authpadding(),
                      child: TextFormField(
                        controller: username,
                        decoration: authdecoration('Username'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name cannot be empty";
                          }
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.emailAddress,
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
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please enter a valid email");
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: authpadding(),
                      child: TextFormField(
                        obscureText: _isObscure,
                        controller: passwordController,
                        //decoration: authdecoration('Password'),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          hintText: 'Password',
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: errortextcolor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: errortextcolor),
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
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: authpadding(),
                      child: TextFormField(
                        obscureText: _isObscure2,
                        controller: confirmpassController,
                        //decoration: authdecoration('Confirm Password'),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure2
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure2 = !_isObscure2;
                                });
                              }),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          hintText: 'Confirm Password',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: errortextcolor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: errortextcolor),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                        ),
                        validator: (value) {
                          if (confirmpassController.text !=
                              passwordController.text) {
                            return "Password did not match";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /* Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Role : ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        DropdownButton<String>(
                          dropdownColor: Colors.blue[900],
                          isDense: true,
                          isExpanded: false,
                          iconEnabledColor: Colors.white,
                          focusColor: Colors.white,
                          items: options.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            setState(() {
                              _currentItemSelected = newValueSelected!;
                              role = newValueSelected;
                            });
                          },
                          value: _currentItemSelected,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MaterialButton(
                          shape: authbuttonshape(),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            const CircularProgressIndicator();
                            Navigator.of(context)
                                .push(FadeRoute(page: LoginPage()));
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );*/
                          },
                          color: authbuttoncolor,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 20, color: authbuttontextcolor),
                          ),
                        ),
                        MaterialButton(
                          shape: authbuttonshape(),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () async {
                            setState(() {
                              error = '';
                            });
                            // const CircularProgressIndicator();
                            try {
                              signUp(emailController.text,
                                  passwordController.text, 'Custom');
                            } catch (e) {
                              _formkey.currentState!.validate();
                              setState(() {
                                error = 'Please Select Image';
                              });
                              // print('Image selection failed');
                            }
                            setState(() {
                              showProgress = true;
                            });
                          },
                          color: authbuttoncolor,
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 20, color: authbuttontextcolor),
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

  void signUp(String email, String password, String role) async {
    if (_formkey.currentState!.validate()) {
      circle(context);
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, role)})
          .catchError((e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
      });
    }
  }

  postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore.instance;
    var user = _auth.currentUser;
    String? token;
    Uint8List sample = _file!.buffer.asUint8List();
    await StoreData().saveData(
      file: sample,
      ku: "$datee" + 'Profile',
    );
    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    // print('token=$ss');
    //CollectionReference ref = FirebaseFirestore.instance.collection('users');
    await ref1.doc(user!.uid).set({
      'email': emailController.text,
      'role': role,
      'profile': samm[0],
      'username': username.text,
      'uid': user.uid,
      'login': false,
      'add': false,
      'edit': false,
      'info': false,
      'addqty': false,
      'consume': false,
      'qr': false,
      'delete': false,
      'logsheet': false,
      'addc': false,
      'vendor': false,
      'time': DateTime.now(),
      'token': token,
    });
    await FirebaseFirestore.instance
        .collection('All Users Data')
        .doc(user.uid)
        .set({'email': user.email});
    await FirebaseAuth.instance.signOut().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          snacks("Your Request Has Been Sent To Admin, Wait Till He Accepts"));
      Navigator.of(context).push(FadeRoute(page: LoginPage()));
    });

    /*Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));*/
  }
}
