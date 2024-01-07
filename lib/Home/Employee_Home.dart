import 'dart:math';
import 'package:alert_banner/types/enums.dart';
import 'package:alert_banner/widgets/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/Edit/category_edit.dart';
import '../Create/Add_Category.dart';
import '../Create/Add_Page.dart';
import '../CustomWidget/bottom_notification.dart';
import '../constants/Decorations.dart';
import '../constants/colors.dart';
import '../location/locationadd.dart';
import 'Product_Page.dart';
import 'bottomnavigation.dart';

User? user = FirebaseAuth.instance.currentUser;
final _products = FirebaseFirestore.instance.collection('Stocks');
final ref1 = FirebaseFirestore.instance
    .collection('permissions')
    .doc('waiting')
    .collection('permission');
var auth = FirebaseAuth.instance;
late AnimationController controller;
bool isFabVisible = true;
final double bsize = 80;

Future<bool> exitApp(BuildContext context) async {
  return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: const Text(
                    'Are you sure?',
                  ),
                  content: const Text(
                    'Do you want to exit an App',
                  ),
                  actions: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text(
                                'No',
                                style: TextStyle(color: Colors.green),
                              )),
                          TextButton(
                              onPressed: () => SystemNavigator.pop(),
                              child: const Text(
                                'Yes',
                                style: const TextStyle(color: Colors.red),
                              ))
                        ])
                  ]))) ??
      false;
}

String? profile;
String? username;

class Employee extends StatefulWidget {
  const Employee({super.key});
  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  void initState() {
    super.initState();
  }

  var getResult = 'category';

  var document;
  bool loadingg = false;
  bool chkk = false;
  final _log = FirebaseFirestore.instance.collection('All Users Data');
  @override
  Widget build(BuildContext context) {
    circle() async {
      return await showDialog(
          barrierDismissible: false,
          context: context,
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
                  content: Text(
                    'Please wait',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ));
    }

    double width = MediaQuery.of(context).size.width;
    Future<String?> check() => showModalBottomSheet<String>(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          enableDrag: true,
          showDragHandle: true,
          context: context,
          builder: (BuildContext context) {
            return Wrap(
              children: <Widget>[
                ListTile(
                  splashColor: Colors.blue.shade100,
                  leading: const Icon(
                    Icons.edit,
                    color: Colors.blueAccent,
                  ),
                  title: const Text(
                    'Edit',
                    softWrap: true,
                  ),
                  onTap: () {
                    // Handle edit action here
                    Navigator.of(context).pop('edit');
                  },
                ),
                ListTile(
                  splashColor: Colors.red.shade100,
                  leading: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  title: const Text('Delete'),
                  onTap: () async {
                    // Handle delete action here
                    Navigator.of(context).pop('delete');
                  },
                ),
              ],
            );
          },
        );
    void _showBottomSheet(BuildContext context) async {
      bool? ss = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.white,
          title: const Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                'Confirm Deletion',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'You are about to delete this category.\n\nThis is will delete all the product inside this category\n\nAre you sure?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text('No', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    longpress(DocumentSnapshot documentSnapshot) async {
      await check().then((ss) async {
        if (ss == 'edit') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => categoryedit(
                        snapshot: documentSnapshot,
                      )));
        } else if (ss == 'delete') {
          // setState(() {
          //   chkk = true;
          // });
          circle();
          await documentSnapshot.reference
              .collection('productss')
              .count()
              .get()
              .then((value) async {
            if (value.count == 0) {
              Navigator.pop(context);
              bool? ss = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.white,
                  title: const Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Confirm Deletion',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  content: Text(
                    'You are about to delete ${documentSnapshot['Category']}. Are you sure?',
                    style: const TextStyle(fontSize: 16),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop(true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Yes',
                          style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: const Text('No',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );

              if (ss == true) {
                circle();
                documentSnapshot.reference.delete().then((value) async {
                  await _log.doc(user!.uid).collection('operations').add({
                    'product': documentSnapshot.get('Category'),
                    'email': user!.email,
                    'uid': user!.uid,
                    'time': DateTime.now(),
                    "pic": documentSnapshot.get('image'),
                    "operation": 'delete C',
                  }).then((value) => Navigator.pop(context));
                });
              }
            } else {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.white,
                  title: const Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Alert',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  content: const Text(
                    'This category consist of products!!',
                    style: TextStyle(fontSize: 16),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop(true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('OK',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }
          });
        }
      });
    }

    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () => exitApp(context),
      child: GestureDetector(
        onTap: () => controller.reverse(),
        child: Scaffold(
          extendBody: true,
          floatingActionButton: const CircularFabWidget(),
          body: chkk
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : StreamBuilder(
                  stream: _products.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.94,
                        ),
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return InkWell(
                            onLongPress: () async {
                              longpress(documentSnapshot);
                            },
                            onTap: () {
                              sample(documentSnapshot.get('Category'));
                              Navigator.of(context)
                                  .push(FadeRoute(page: const productpage()));
                            },
                            child: Card(
                              elevation: 1,
                              // shape: RoundedRectangleBorder(
                              //   side: BorderSide(
                              //     color: Theme.of(context).colorScheme.outline,
                              //   ),
                              //   borderRadius:
                              //       const BorderRadius.all(Radius.circular(12)),
                              // ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  imagee(documentSnapshot['image'],
                                      documentSnapshot['Category'], 35),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    documentSnapshot['Category']
                                        .toString()
                                        .toUpperCase(),
                                    style: theme.textTheme.titleMedium,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}

class CircularFabWidget extends StatefulWidget {
  const CircularFabWidget({super.key});
  @override
  State<CircularFabWidget> createState() => _CircularFabWidgetState();
}

class _CircularFabWidgetState extends State<CircularFabWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) => Flow(
        clipBehavior: Clip.none,
        delegate: FlowMenuDelegate(controller: controller),
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            // backgroundColor: fabbackcolor,
            // splashColor: fabsplashcolor,
            onPressed: () {
              ref1
                  .doc(user!.uid)
                  .get()
                  .then((DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists) {
                  if (documentSnapshot.get('addc') == true) {
                    Navigator.of(context)
                        .push(FadeRoute(page: const categoryadd()));
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
            },
            child: Icon(
              Icons.category_outlined,
              // color: fabiconcolor,
            ),
          ),
          FloatingActionButton(
              heroTag: "btn2",
              // backgroundColor: fabbackcolor,
              // splashColor: fabsplashcolor,
              onPressed: () {
                Navigator.of(context).push(
                  FadeRoute(
                    page: const MultiLevelDropDownExample(),
                  ),
                );
              },
              child: Icon(
                Icons.add_location_outlined,
                // color: fabiconcolor,
              )),
          FloatingActionButton(
            heroTag: "btn3",
            // backgroundColor: fabbackcolor,
            // splashColor: fabsplashcolor,
            child: Icon(
              Icons.add,
              // color: fabiconcolor,
            ),
            onPressed: () {
              ref1
                  .doc(user!.uid)
                  .get()
                  .then((DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists) {
                  if (documentSnapshot.get('add') == true) {
                    Navigator.of(context).push(
                      FadeRoute(
                        page: crtprd(),
                      ),
                    );
                  } else {
                    showAlertBanner(
                      context,
                      () => print("TAPPED"),
                      ExampleAlertBannerChild(
                        text: 'Your not allowed!',
                        color: Colors.red,
                      ),
                      alertBannerLocation: AlertBannerLocation.bottom,
                      // .. EDIT MORE FIELDS HERE ...
                    );
                    // print('Your not allowed');
                  }
                }
              });
            },
          ),
          FloatingActionButton.extended(
            // backgroundColor: fabbackcolor,
            onPressed: () {
              if (controller.status == AnimationStatus.completed) {
                controller.reverse();
              } else {
                controller.forward();
              }
            },
            label: const Text("Add"),
            icon: Icon(
              Icons.menu_open_outlined,
              // color: fabiconcolor,
            ),
          ),
        ],
      );
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - bsize;
    final yStart = size.height - bsize;

    final n = context.childCount;
    for (int i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      final setValue = (value) => isLastItem ? 0.0 : value;

      final radius = 120 * controller.value;
      final theta = i * pi * 0.5 / (n - 2);
      final x = xStart - setValue(radius * cos(theta));
      final y = yStart - setValue(radius * sin(theta));
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(x, y, 0)
          ..translate(bsize / 2, bsize / 2)
          ..rotateZ(isLastItem ? 0.0 : 180 * (1 - controller.value) * pi / 180)
          ..scale(isLastItem ? 1.0 : max(controller.value, 0.0))
          ..translate(-bsize / 2, -bsize / 2),
      );
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
}
