import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Create/Add_Page.dart';
import 'package:flutter_application_2/admin/permission.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Home/Employee_Home.dart';
import 'Home/bottomnavigation.dart';
import 'authentication/Login_Page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

var isLogin = false;
bool chk = true;
var isdrawer = true;
var auth = FirebaseAuth.instance;
bool visible = false;
late DocumentSnapshot docsnap;
Future<PermissionStatus> _requestlocation() async {
  var result = await Permission.location.status;
  if (result.isPermanentlyDenied || result.isDenied) {
    if (result.isDenied) {
      result = await Permission.location.request();
    }
    if (result.isPermanentlyDenied) {
      print("Permanently disabled");
    }

    // if (status.isDenied) {
    //   _requestlocation();
    // }
  }
  return result;
}

Future<PermissionStatus> _requestnotification() async {
  var result = await Permission.notification.status;
  if (result.isDenied) {
    result = await Permission.notification.request();
    _requestnotification();
  }
  return result;
}

class _MyAppState extends State<MyApp> {
  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        ref1.doc(user.uid).get().then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            if (documentSnapshot.get('login') == true) {
              setState(() {
                isLogin = true;
                visible = true;
                profile = documentSnapshot.get('profile');
                docsnap = documentSnapshot;
                username = documentSnapshot.get('username');
              });
              if (documentSnapshot.get('role') == 'Admin') {
                setState(() {
                  isdrawer = false;
                });
              } else {
                setState(() {
                  isdrawer = true;
                });
              }
            }
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    checkIfLogin();
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.requestPermission(
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // cardColor: Colors.white60,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.light)
          // primarySwatch: Colors.blue,
          // appBarTheme: AppBarTheme(color: Colors.white),
          // scaffoldBackgroundColor: Colors.white
          ),
      themeMode: ThemeMode.system,
      // themeMode: ThemeMode.d,
      debugShowCheckedModeBanner: false,
      home: isLogin ? navigation() : LoginPage(),
    );
  }
}
