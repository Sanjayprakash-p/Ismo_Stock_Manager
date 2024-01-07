import 'package:alert_banner/types/enums.dart';
import 'package:alert_banner/widgets/alert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Authentication/Authentication.dart';
import 'package:flutter_application_2/CustomWidget/bottom_notification.dart';
import 'package:flutter_application_2/CustomWidget/imagecache.dart';
import 'package:flutter_application_2/Home/Employee_Home.dart';
import 'package:flutter_application_2/LogSheet/pages/tabpage.dart';
import 'package:flutter_application_2/PDF/All_Product_Export/all_product_expt.dart';
import 'package:flutter_application_2/admin/permission.dart';
import 'package:flutter_application_2/admin/roles.dart';
import 'package:flutter_application_2/admin/userdata.dart';
import 'package:flutter_application_2/constants/Decorations.dart';
import 'package:flutter_application_2/constants/colors.dart';
import 'package:flutter_application_2/price/price_Analysis.dart';
import 'package:flutter_application_2/settings/setting.dart';
import '../Home/bottomnavigation.dart';
import '../Home/repot.dart';
import '../Scan/QRcodes.dart';

Widget listtile(BuildContext context, Widget icon, String text, Widget name) {
  return ListTile(
      // titleAlignment: ListTileTitleAlignment.center,
      // iconColor: drawerlisttileiconcolor,
      // textColor: drawerlisttiletextcolor,
      leading: icon,
      title: Text(
        text,
        // style: drawerlisttiletextstyle(),
      ),
      onTap: () {
        Navigator.of(context).push(
          FadeRoute(
            page: name,
          ),
        );
      });
}

class opena extends StatelessWidget {
  opena({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _usermail() {
    return Text(
      user?.email ?? 'User Email',
      // style: TextStyle(color: drawerheadtextcolor),
    );
  }

  Widget _useruid() {
    return Text(
      "Admin",
      // style: TextStyle(color: drawerheadtextcolor),
    );
  }

  @override
  Widget build(BuildContext context) => Drawer(
          // backgroundColor: drawerbodybackcolor,
          // shape: drawershape(),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ])));
  Widget buildHeader(BuildContext context) =>
      Container(decoration: drawerheadershape());
  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          UserAccountsDrawerHeader(
              // decoration: BoxDecoration(color: Colors.redAccent),
              accountName: _useruid(),
              accountEmail: _usermail(),
              currentAccountPicture: CircleAvatar(
                // backgroundColor: Colors.blueAccent,
                child: catchimage(profile.toString()),
                // backgroundImage: NetworkImage(profile.toString()),
              )),
          listtile(
            context,
            const Icon(Icons.padding_outlined),
            "Log Sheet",
            const TabPage(
              mystock: false,
              title: 'LOG SHEET',
            ),
          ),
          listtile(
              context,
              const Icon(Icons.inbox),
              "My Stocks",
              const TabPage(
                mystock: true,
                title: 'My Stocks',
              )),
          listtile(context, const Icon(Icons.inbox), "View QR Code's",
              const QRCode()),
          listtile(context, const Icon(Icons.supervised_user_circle_outlined),
              "User Details", const Userdata()),
          listtile(context, const Icon(Icons.notifications), "Notifications",
              const permission()),
          listtile(context, const Icon(Icons.people_alt_outlined), "Roles",
              const Roles()),
          listtile(context, const Icon(Icons.monetization_on_outlined),
              'Analysis', const price()),
          listtile(context, const Icon(Icons.data_exploration_sharp),
              "All Product Export", const all_pdt_expt()),
          listtile(context, const Icon(Icons.settings), "Settings",
              const setting_page()),
          listtile(
              context,
              Image.asset(
                'assets/discuss-issue.png',
                color: Theme.of(context).iconTheme.color,
                height: 28,
                width: 28,
              ),
              "Report",
              const ChatPage()),
        ],
      );
}

class openu extends StatelessWidget {
  openu({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _usermail() {
    return Text(
      user?.email ?? 'User Email',
      style: TextStyle(color: drawerheadtextcolor),
    );
  }

  Widget _useruid() {
    return Text(
      '$username',
      style: TextStyle(color: drawerheadtextcolor),
    );
  }

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: drawerbodybackcolor,
        shape: drawershape(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) =>
      Container(decoration: drawerheadershape());
  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: drawerheadercolorshape(),
            accountName: _useruid(),
            accountEmail: _usermail(),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                profile.toString(),
              ),
            ),
          ),
          Padding(
            padding: drawerpadding(),
            child: ListTile(
                //shape: drawerlisttileshape(),
                tileColor: drawerlisttilecolor,
                iconColor: drawerlisttileiconcolor,
                textColor: drawerlisttiletextcolor,
                leading: const Icon(Icons.inbox),
                title: Text(
                  "My Stocks",
                  style: drawerlisttiletextstyle(),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    FadeRoute(
                      page: const TabPage(
                        mystock: true,
                        title: 'My Stocks',
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: drawerpadding(),
            child: ListTile(
                //shape: drawerlisttileshape(),
                tileColor: drawerlisttilecolor,
                iconColor: drawerlisttileiconcolor,
                textColor: drawerlisttiletextcolor,
                leading: const Icon(Icons.padding_outlined),
                title: Text(
                  "Log Sheet",
                  style: drawerlisttiletextstyle(),
                ),
                onTap: () {
                  ref1
                      .doc(user!.uid)
                      .get()
                      .then((DocumentSnapshot documentSnapshot) {
                    if (documentSnapshot.exists) {
                      if (documentSnapshot.get('logsheet') == true) {
                        Navigator.of(context).push(FadeRoute(
                            page: const TabPage(
                          mystock: false,
                          title: 'LOG SHEET',
                        )));
                      } else {
                        showAlertBanner(
                          context,
                          () => print("TAPPED"),
                          ExampleAlertBannerChild(
                            text: 'Your not allowed!',
                            color: Colors.red,
                          ),
                          alertBannerLocation: AlertBannerLocation.bottom,
                        );
                      }
                    }
                  });
                }),
          ),
          Padding(
            padding: drawerpadding(),
            child: ListTile(
                //shape: drawerlisttileshape(),
                tileColor: drawerlisttilecolor,
                iconColor: drawerlisttileiconcolor,
                textColor: drawerlisttiletextcolor,
                leading: const Icon(Icons.inbox),
                title: Text(
                  "View QR Code's",
                  style: drawerlisttiletextstyle(),
                ),
                onTap: () {
                  Navigator.of(context).push(FadeRoute(page: const QRCode()));
                }),
          ),
          Padding(
            padding: drawerpadding(),
            child: ListTile(
                // shape: drawerlisttileshape(),
                tileColor: drawerlisttilecolor,
                iconColor: drawerlisttileiconcolor,
                textColor: drawerlisttiletextcolor,
                leading: const Icon(Icons.settings),
                title: Text(
                  "Settings",
                  style: drawerlisttiletextstyle(),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(FadeRoute(page: const setting_page()));
                }),
          ),
          Padding(
            padding: drawerpadding(),
            child: ListTile(
                // shape: drawerlisttileshape(),
                tileColor: drawerlisttilecolor,
                iconColor: drawerlisttileiconcolor,
                textColor: drawerlisttiletextcolor,
                leading: Image.asset(
                  'assets/discuss-issue.png',
                  height: 28,
                  width: 28,
                ),
                // const Icon(Icons.settings),
                title: Text(
                  "Report",
                  style: drawerlisttiletextstyle(),
                ),
                onTap: () {
                  Navigator.of(context).push(FadeRoute(page: const ChatPage()));
                }),
          ),
        ],
      );
}
