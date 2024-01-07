import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings/app_info.dart';
import 'package:flutter_application_2/settings/theme.dart';
import '../../Home/bottomnavigation.dart';
import '../Authentication/Forgot_Password.dart';
import 'profile.dart';

class setting_page extends StatefulWidget {
  const setting_page({super.key});

  @override
  State<setting_page> createState() => _setting_pageState();
}

class _setting_pageState extends State<setting_page> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  size: 30,
                ),
                color: Colors.red,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.04,
          ),
          // ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.person_4_outlined,
                        size: 35,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Account',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: width * 0.9,
                      child: const Divider(
                        thickness: 2,
                      ))
                ],
              )),
          SizedBox(
            height: height * 0.01,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(FadeRoute(page: const profile_page()));
            },
            child: ListTile(
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right,
                    size: 35,
                    color: Colors.black87,
                  )),
            ),
          ),

          //

          SizedBox(
            height: height * 0.01,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(FadeRoute(page: const Forgotpw()));
              },
              child: ListTile(
                title: const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 35,
                      color: Colors.black87,
                    )),
              )),
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        size: 35,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'General',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: width * 0.9,
                      child: const Divider(
                        thickness: 2,
                      ))
                ],
              )),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).push(FadeRoute(page: const Theme_data())),
            child: ListTile(
              title: Text(
                'Theme',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: 35,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 35,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'About',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: width * 0.9,
                      child: const Divider(
                        thickness: 2,
                      ))
                ],
              )),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(FadeRoute(page: const App_info_page())),
            child: const ListTile(
              title: Text(
                'App Info',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: 35,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
