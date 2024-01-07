import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Authentication/Login_Page.dart';
import 'package:flutter_application_2/Home/Employee_Home.dart';
import 'package:flutter_application_2/Scan/Scan_Page.dart';
import 'package:flutter_application_2/Search/Search_Page.dart';
import 'package:flutter_application_2/constants/Decorations.dart';
import 'package:flutter_application_2/constants/colors.dart';
import 'package:flutter_application_2/drawer/admin.dart';
import 'package:flutter_application_2/main.dart';

int currentIndex = 0;

class navigation extends StatefulWidget {
  navigation({super.key});

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            )));
  }

  int check = 2;
  final screens = [const Employee(), const SearchPage(), scannerpg()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
          if (currentIndex == 0) {
            setState(() {
              chk = true;
            });
          } else {
            setState(() {
              chk = false;
            });
          }
        },
        // indicatorColor: Colors.amber,
        selectedIndex: currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code),
            label: 'Barcode',
          ),
        ],
      ),

      /* bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          // color: Colors.black,
          // buttonBackgroundColor: buttonbackcolor,
          // backgroundColor: buttongroundcolor,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOutQuad,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            if (currentIndex == 0) {
              setState(() {
                chk = true;
              });
            } else {
              setState(() {
                chk = false;
              });
            }
          },
          items: [
            Icon(
              Icons.home,
              color: bottomiconcolor,
            ),
            Icon(
              Icons.search,
              color: bottomiconcolor,
            ),
            Icon(
              Icons.qr_code_2_rounded,
              color: bottomiconcolor,
            )
          ]),
      */
      appBar: chk
          ? AppBar(
              leading: null,
              shape: appbarshape(),
              //backgroundColor: appbarcolor,
              title: const Text(
                "I S M O - Bio Photonics",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              // centerTitle: true,
              actions: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Badge(
                      // label: Text(),
                      child: Icon(Icons.notifications),
                    ),
                  )
                  /*IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              "Do You Want To LogOut ?",
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text(
                                        'No',
                                        style: TextStyle(color: Colors.green),
                                      )),
                                  TextButton(
                                    onPressed: () async {
                                      logout(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snacks(
                                              "Your Have Been Logged Out"));
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout))
                */
                ])
          : null,
      drawer: chk ? drawe(isdrawer) : null,
    );
  }
}

drawe(bool isdrawer) {
  if (isdrawer == false) {
    return opena();
  } else if (isdrawer == true) {
    return openu();
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
