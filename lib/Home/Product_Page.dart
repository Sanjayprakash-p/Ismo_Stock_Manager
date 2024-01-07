// ignore_for_file: unnecessary_string_interpolations

import 'package:alert_banner/types/enums.dart';
import 'package:alert_banner/widgets/alert.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Constants/colors.dart';
import 'package:flutter_application_2/CustomWidget/imagecache.dart';
// import 'package:flutter_application_2/CustomWidget/CircleProgressIndicator%202.dart';
import 'package:flutter_application_2/Zoomer/pinch_zoom.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Constants/Decorations.dart';
import '../CustomWidget/bottom_notification.dart';
import '../Delete/delete_pop.dart';
import '../Edit/Edit_Page.dart';
import '../Read/Info_Page.dart';
import '../Search/Search_Page.dart';
import '../main.dart';
import 'Employee_Home.dart';
import 'bottomnavigation.dart';

// Future<void> _refresh() {
//   isRefresh = true;
//   return Future.delayed(const Duration(seconds: 2));
// }

Future<void> sample(var documentSnapshot) async {
  sanjay = documentSnapshot;
}

String? sanjay;
final _cat = FirebaseFirestore.instance.collection('Stocks');

class productpage extends StatefulWidget {
  const productpage({super.key});
  @override
  State<productpage> createState() => _productpageState();
}

class _productpageState extends State<productpage>
    with SingleTickerProviderStateMixin {
  Future<void> _refresh() {
    setState(() {
      isRefresh = true;
    });

    setState(() {
      isRefresh = false;
    });
    return Future.delayed(const Duration(milliseconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        // backgroundColor: screenbackgroundcolor,
        appBar: AppBar(
          shape: appbarshape(),
          // backgroundColor: appbarcolor,
          title: Text(
            "${sanjay!.toUpperCase()}",
            style: const TextStyle(letterSpacing: 6),
          ),
          centerTitle: true,
        ),
        body: isRefresh
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.grey,
              ))
            : RefreshIndicator(
                color: refreshcolor,
                backgroundColor: refreshbackcolor,
                onRefresh: () => _refresh(),
                child: StreamBuilder<QuerySnapshot>(
                    stream:
                        _cat.doc(sanjay).collection('productss').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Container();
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Card(
                          elevation: 0,
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/empty.png', height: 125),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  const Text(
                                    "No products!",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ]),
                          ),
                        );
                      }
                      return Builder(builder: (context) {
                        return ListView.separated(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final DocumentSnapshot docu =
                                  snapshot.data!.docs[index];
                              return OpenContainer<bool>(
                                transitionType: ContainerTransitionType.fade,
                                openBuilder: (context, action) => info(),
                                tappable: false,
                                closedShape: const RoundedRectangleBorder(),
                                closedElevation: 0,
                                closedBuilder: (context, action) => Slidable(
                                  closeOnScroll: true,
                                  endActionPane: ActionPane(
                                      extentRatio: 0.2,
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          // backgroundColor: editcolor,
                                          onPressed: (context) {
                                            ref1.doc(user!.uid).get().then(
                                                (DocumentSnapshot
                                                    documentSnapshot) {
                                              if (documentSnapshot.exists) {
                                                if (documentSnapshot
                                                        .get('edit') ==
                                                    true) {
                                                  Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (
                                                        context,
                                                      ) =>
                                                          Edit(
                                                        snapshot: docu,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  showAlertBanner(
                                                    context,
                                                    () => print("TAPPED"),
                                                    ExampleAlertBannerChild(
                                                      color: Colors.red,
                                                      text: 'Your not allowed!',
                                                    ),
                                                    alertBannerLocation:
                                                        AlertBannerLocation
                                                            .bottom,
                                                  );
                                                }
                                              }
                                            });
                                          },
                                          icon: Icons.mode_edit_outlined,
                                        )
                                      ]),
                                  startActionPane: ActionPane(
                                      extentRatio: 0.2,
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          // backgroundColor: deletecolor,
                                          onPressed: (context) {
                                            ref1.doc(user!.uid).get().then(
                                                (DocumentSnapshot
                                                    documentSnapshot) {
                                              if (documentSnapshot.exists) {
                                                if (documentSnapshot
                                                        .get('delete') ==
                                                    true) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          Center(
                                                              child: deletepop(
                                                            snap: docu,
                                                          )));
                                                } else {
                                                  showAlertBanner(
                                                    context,
                                                    () => print("TAPPED"),
                                                    ExampleAlertBannerChild(
                                                      color: Colors.red,
                                                      text: 'Your not allowed!',
                                                    ),
                                                    alertBannerLocation:
                                                        AlertBannerLocation
                                                            .bottom,
                                                  );
                                                }
                                              }
                                            });
                                          },
                                          icon: Icons.delete_forever_outlined,
                                        )
                                      ]),
                                  child: ListTile(
                                    onTap: () {
                                      ref1.doc(user!.uid).get().then(
                                          (DocumentSnapshot documentSnapshot) {
                                        if (documentSnapshot.exists) {
                                          if (documentSnapshot.get('info') ==
                                              true) {
                                            raj(docu);
                                            action();
                                            // Navigator.of(context)
                                            //     .push(FadeRoute(page: info()));
                                          } else {
                                            showAlertBanner(
                                              context,
                                              () => print("TAPPED"),
                                              ExampleAlertBannerChild(
                                                color: Colors.red,
                                                text: 'Your not allowed!',
                                              ),
                                              alertBannerLocation:
                                                  AlertBannerLocation.bottom,
                                            );
                                          }
                                        }
                                      });
                                    },
                                    leading: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return PinchZoomImage(
                                                  sanj: docu['dp']);
                                            });
                                      },
                                      child: CircleAvatar(
                                        radius: 25,
                                        child: catchimage(docu['dp']),
                                      ),
                                    ),
                                    title: Text(
                                      docu['name'],
                                      style: listtiletextstyle(),
                                    ),
                                    subtitle: Text(
                                      docu['location'],
                                      style: listtiletextstyle(),
                                    ),
                                    trailing: quantitygrade(
                                        docu['quantity'], docu['mqty']),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            });
                      });
                    })));
  }
}
