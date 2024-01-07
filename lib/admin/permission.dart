import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Edit/Edit_Page.dart';
import 'package:flutter_application_2/Notification/notification.dart';
import 'package:flutter_application_2/authentication/Sign_Up_Page.dart';
import 'package:flutter_application_2/constants/Decorations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import '../Constants/colors.dart';
import '../Home/bottomnavigation.dart';
import '../Zoomer/pinch_zoom.dart';

// final CollectionReference _products = FirebaseFirestore.instance
//     .collection('permissions')
//     .doc('waiting')
//     .collection('permission');
// final CollectionReference accepted = FirebaseFirestore.instance
//     .collection('permissions')
//     .doc('waiting')
//     .collection('permission');
DocumentSnapshot? user;

String? perm;

String? _currentItemSelected;

/*class check extends StatefulWidget {
  const check({super.key});

  @override
  State<check> createState() => _checkState();
}

class _checkState extends State<check> {
  // final CollectionReference _products =
  //     FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _products.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              user = documentSnapshot;
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}*/

class permission extends StatefulWidget {
  const permission({super.key});

  @override
  State<permission> createState() => _permissionState();
}

class _permissionState extends State<permission> {
  // String serverKey =
  //     "AAAAYj148hA:APA91bF5aVnKs5Ru_XkdyvKBiFghCpmvvoDxsVqH1jsjS-5eLOF8mtmD32B3d9cov0P4IYSDYL4rR3MbE9xmUk6xZ4wtj6kb_d2eNzzdDVdAfRu0E-QIc0vRBvCbU8-3GfTmO1aIFyJ5";
  // void sendNotification(String token, String title, String body) async {
  //   final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  //   //final url = 'https://fcm.googleapis.com/fcm/send';
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'key=$serverKey',
  //   };

  //   final message = {
  //     'notification': {
  //       'title': title,
  //       'body': body,
  //     },
  //     'to': token,
  //   };

  //   final response =
  //       await http.post(url, headers: headers, body: json.encode(message));

  //   if (response.statusCode == 200) {
  //     print('Notification sent successfully.');
  //   } else {
  //     print('Failed to send notification. Status code: ${response.statusCode}');
  //   }
  // }

  bool load = false;
  var status;
  void sendDataToNodeServer(String uid) async {
    setState(() {
      load = true;
    });
    final url = 'http://192.168.1.7:3000/api/add';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'uid': uid}),
      );
      if (response.statusCode == 200) {
        //_firebaseMessaging.requestPermission();
        // FirebaseMessaging.instance.getToken().then((valdfsue) {
        //   var ss = valdfsue;
        //   print(ss);
        // });
        setState(() {
          status = json.decode(response.body)['result'];
          load = false;
        });
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(status),
                ));
        // print(result);
      } else {
        setState(() {
          status = 'Error occured try again'; // Indicate an error occurred
        });
      }
    } catch (e) {
      setState(() {
        load = false;
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('$e'),
              ));
    }
  }

  Widget login() {
    return StreamBuilder(
        stream: ref1.orderBy('time', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = streamSnapshot.data!.docs[index];
                  if (doc.get('login') != true &&
                      doc.get('role') != 'Admin' &&
                      doc.exists) {
                    return Slidable(
                      closeOnScroll: true,
                      endActionPane: ActionPane(
                          extentRatio: 0.3,
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: editcolor,
                              onPressed: (context) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: Text(
                                              "Do Want To Accept ${doc['username']}'s Login Request ? ",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            actions: <Widget>[
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false),
                                                        child: const Text('No',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green))),
                                                    TextButton(
                                                        onPressed: () async {
                                                          await ref1
                                                              .doc(doc.id)
                                                              .update({
                                                            'login': true
                                                          });
                                                          sendNotification(
                                                              doc.get('token'),
                                                              'Admin accepted Your Login Request',
                                                              'You can login now');

                                                          Navigator.of(context)
                                                              .pop(false);
                                                          Navigator.of(context)
                                                              .push(FadeRoute(
                                                                  page: MyHomePage(
                                                                      raja:
                                                                          doc)));
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(snacks(
                                                                  "You've Accepted ${doc['username']}'s Login Request" +
                                                                      '\n' +
                                                                      "Now You Can Set The Permissions"));
                                                        },
                                                        child: const Text('Yes',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red)))
                                                  ])
                                            ]));
                              },
                              label: "A C C E P T",
                            )
                          ]),
                      startActionPane: ActionPane(
                          extentRatio: 0.3,
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: deletecolor,
                              onPressed: (context) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: Text(
                                              "Do Want To Reject ${doc['username']}'s Login Request ? ",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            actions: <Widget>[
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false),
                                                        child: const Text('No',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green))),
                                                    TextButton(
                                                        onPressed: () async {
                                                          sendDataToNodeServer(
                                                              doc['uid']);
                                                          await ref1
                                                              .doc(doc.id)
                                                              .delete();
                                                          Navigator.of(context)
                                                              .pop(false);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(snacks(
                                                                  "You've Rejected ${doc['username']}'s Login Request"));
                                                        },
                                                        child: const Text('Yes',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red)))
                                                  ])
                                            ]));
                              },
                              label: "R E J E C T",
                            )
                          ]),
                      child: Card(
                          shape: listtileshape(),
                          color: listtilecolor,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return PinchZoomImage(
                                            sanj: doc.get('profile'));
                                      });
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      NetworkImage(doc.get('profile')),
                                )),
                            title: Text(
                              doc['username'],
                              style: TextStyle(
                                  color: listtiletextcolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              doc['email'],
                              style: TextStyle(
                                  color: listtiletextcolor, fontSize: 16),
                            ),
                            /*trailing: SizedBox(
                                      width: 150,
                                      child: Row(children: [
                                        TextButton(
                                            child: Text('Accept'),
                                            onPressed: () async {
                                              ref1
                                                  .doc(doc.id)
                                                  .update({'login': true});
                                              Navigator.of(context).push(FadeRoute(
                                                  page: MyHomePage(
                                                raja: doc,
                                              )));
                                            }),
                                        TextButton(
                                            child: Text('Reject'),
                                            onPressed: () async {
                                              await ref1.doc(doc.id).delete();
                                            }),
                                      ]))*/
                          )),
                    );
                  }
                  return Container();
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  bool res = false;
  List<DocumentSnapshot<Object?>> suggestions = [];
  search() async {
    setState(() {
      res = true;
    });
    final snap = await FirebaseFirestore.instance.collection('Stocks').get();
    QuerySnapshot? querySnapshot;

    //print(doc.reference.collection('productss').get());
    for (QueryDocumentSnapshot doc in snap.docs) {
      querySnapshot = await doc.reference.collection('productss').get();

      //  DocumentReference name1=await querySnapshot.docs[0].get('two');
      //  DocumentReference name2=await querySnapshot.docs[0].get('three');
      //  DocumentReference name3=await querySnapshot.docs[0].get('four');

      // DocumentSnapshot loc1=await name1.get();
      // DocumentSnapshot loc2=await name2.get();
      // DocumentSnapshot loc3=await name3.get();

      for (DocumentSnapshot ss in querySnapshot.docs) {
        dynamic name = await ss.get('one');
        dynamic name1 = await ss.get('two');
        dynamic name2 = await ss.get('three');
        dynamic name3 = await ss.get('four');
        if (name != null) {
          dynamic loc = await name.get();
          if (!loc.exists) {
            suggestions.add(ss);
          }
        }
        if (name1 != null) {
          dynamic loc = await name1.get();
          if (!loc.exists) {
            suggestions.add(ss);
          }
        }
        if (name2 != null) {
          dynamic loc = await name2.get();
          if (!loc.exists) {
            suggestions.add(ss);
          }
        }
        if (name3 != null) {
          dynamic loc = await name3.get();
          if (!loc.exists) {
            suggestions.add(ss);
          }
        }
      }

      // if(!loc1.exists ){
      //  suggestions.add(querySnapshot.docs[0]) ;
      // }
      // if(!loc2.exists ){
      //  suggestions.add(querySnapshot.docs[0]) ;
      // }
      // if(!loc3.exists ){
      //  suggestions.add(querySnapshot.docs[0]) ;
      // }
    }
    // if (querySnapshot!.docs.isNotEmpty) {
    //   for (var document in querySnapshot.docs) {
    //     suggestions.add(document['name'].toString());
    //   }
    // }
    // setState(() {
    //   // Set suggestions after processing all documents
    //   suggestions = suggestions.toSet().toList();
    //   // Remove duplicates if necessary
    // });
    if (mounted) {
      setState(() {
        res = false;
      });
    }
  }

  Widget location() {
    return res
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () {
              suggestions.clear();
              search();
              return Future.delayed(const Duration(milliseconds: 1));
            },
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  Edit(snapshot: suggestions[index])))
                      .then((value) {
                    suggestions.clear();

                    search();
                  }),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),

                    margin: const EdgeInsets.all(5.0),

                    child: ListTile(
                        title: Text(suggestions[index].get('name')),
                        subtitle: Text(
                          suggestions[index].get('location'),
                          style: listsubtitlestyle(),
                        ),
                        leading: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PinchZoomImage(
                                        sanj: suggestions[index].get('dp'));
                                  });
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(suggestions[index].get('dp')),
                            ))),

                    // You can add more customization to each list item here
                  ),
                );
              },
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    // Call the search method once when the widget is initialized
    search();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: screenbackgroundcolor,
        appBar: AppBar(
          title: const Text(
            'NOTIFICATION',
            style: TextStyle(letterSpacing: 5),
          ),
          centerTitle: true,
          // backgroundColor: appbarcolor,
          bottom: const TabBar(
            indicatorWeight: 5.0,
            // indicatorColor: Colors.redAccent,
            tabs: [Tab(text: 'Login'), Tab(text: 'Issues')],
          ),
        ),
        body: TabBarView(
          children: [login(), location()],
        ),
        /*StreamBuilder(
          stream: ref1.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData &&
                streamSnapshot.connectionState == ConnectionState.active) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  if (documentSnapshot.get('login') != true &&
                      documentSnapshot.exists) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: red,
                      elevation: 15,
                      shadowColor: Colors.orangeAccent,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(documentSnapshot.get('profile')),
                        ),
                        title: Text(
                          documentSnapshot.get('username'),
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          documentSnapshot['email'],
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              TextButton(
                                  child: Text('Accept'),
                                  onPressed: () {
                                    /*_products
                                      .doc('waiting')
                                      .collection('permission')
                                      .doc(documentSnapshot.id)
                                      .update({'login': true});*/
    
                                    ref1
                                        .doc(documentSnapshot.id)
                                        .update({'login': true});
                                    //perm = documentSnapshot.id;
                                    // _products.doc(documentSnapshot.id).delete();
                                    Navigator.of(context).push(FadeRoute(
                                        page: MyHomePage(
                                      raja: documentSnapshot,
                                    )));
                                    /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyHomePage(
                                                  raja: documentSnapshot.id,
                                                )));*/
                                  }),
                              TextButton(
                                  child: Text('Reject'),
                                  onPressed: () {
                                    ref1
                                        .doc(documentSnapshot.id)
                                        .update({'login': false});
                                    //var user = documentSnapshot.id;
    
                                    //Navigator.pop(context);
                                    //User? user = FirebaseAuth.instance.currentUser;
                                    //documentSnapshot.();
                                  }),
    
                              /*IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                onPressed: () {}
                                //=>_update(documentSnapshot)
                                ),
                            IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                onPressed: () => {}),*/
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              );
            }
    
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),*/
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final DocumentSnapshot? raja;
  MyHomePage({
    Key? key,
    this.raja,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final rolexs = FirebaseFirestore.instance
      .collection('permissions')
      .doc('waiting')
      .collection('rolex');
  bool? _checkBox = false;
  bool? _checkBox1 = false;
  bool? _checkBox2 = false;
  bool? _checkBox3 = false;
  bool? _checkBox4 = false;
  bool? _checkBox5 = false;
  bool? _checkBox6 = false;
  bool? _checkBox7 = false;
  bool? _checkBox8 = false;
  bool? _checkBox9 = false;
  bool? _checkBox0 = false;
  String? dpp;

  String? uname;

  changee() async {
    if (widget.raja!.exists) {
      setState(() {
    
        _checkBox1 = widget.raja!.get('addc');
        _checkBox2 = widget.raja!.get('add');
        _checkBox3 = widget.raja!.get('edit');
        _checkBox4 = widget.raja!.get('info');
        _checkBox5 = widget.raja!.get('addqty');
        _checkBox6 = widget.raja!.get('consume');
        _checkBox7 = widget.raja!.get('qr');
        _checkBox8 = widget.raja!.get('delete');
        _checkBox9 = widget.raja!.get('logsheet');
        _checkBox0 = widget.raja!.get('vendor');
        _currentItemSelected = widget.raja!.get('role');
        dpp = widget.raja!.get('profile');
        uname = widget.raja!.get('username');
      });
    }
  }

  @override
  void initState() {
    changee();
    super.initState();
  }

  late BuildContext dialogContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: appbarshape(),
          // backgroundColor: appbarcolor,
          actions: [
            IconButton(
                onPressed: () async {
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
                        'You are about to delete $uname. Are you sure?',
                        style: const TextStyle(fontSize: 16),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);

                            // Add your deletion logic here
                            // await FirebaseStorage.instance
                            //     .refFromURL('$dpp')
                            //     .delete()
                            //     .then((value) => widget.raja!.reference
                            //         .delete()
                            //         .then((value) =>
                            //             Navigator.pushReplacement(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         const Userdata()))));
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
                    // showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator()));
                    await FirebaseStorage.instance
                        .refFromURL('$dpp')
                        .delete()
                        .then((value) => widget.raja!.reference
                            .delete()
                            .then((value) => Navigator.pop(context)));
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
          leadingWidth: MediaQuery.of(context).size.width * 0.15,
          title: const Text('U S E R  I N F O'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        // backgroundColor: screenbackgroundcolor,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return PinchZoomImage(sanj: dpp.toString());
                    });
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(dpp.toString()),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            uname.toString(),
            style: TextStyle(
                color: checkboxtextcolor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          )),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "   Desigination : ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: checkboxtextcolor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: rolexs.snapshots(),
                  builder: (context, snapshots) {
                    List<DropdownMenuItem> stockItems = [];
                    if (!snapshots.hasData) {
                      const CircularProgressIndicator();
                    } else {
                      final Stock = snapshots.data?.docs.toList();
                      // print(Stock);
                      Stock != null;
                      for (var Stocks in Stock!) {
                        stockItems.add(
                          DropdownMenuItem(
                            value: Stocks.id,
                            child: Text(
                              Stocks['role'],
                              style: TextStyle(color: dropdowntextcolor),
                            ),
                          ),
                        );
                      }
                    }
                    return DropdownButton(
                      iconEnabledColor: dropdowniconenabledcolor,
                      iconDisabledColor: dropdownicondisabledcolor,
                      focusColor: dropdownfocuscolor,
                      borderRadius: dropdownborder(),
                      dropdownColor: dropdownbackcolor,
                      hint: Text(
                        'Select Role',
                        style: TextStyle(color: dropdowntextcolor),
                      ),
                      items: stockItems,
                      onChanged: (StockValue) {
                        setState(
                          () {
                            _currentItemSelected = StockValue;
                            rolexs
                                .doc(_currentItemSelected)
                                .get()
                                .then((DocumentSnapshot perms) {
                              if (perms.exists) {
                                setState(() {
                                  _checkBox1 = perms.get('addc');
                                  _checkBox2 = perms.get('add');
                                  _checkBox3 = perms.get('edit');
                                  _checkBox4 = perms.get('info');
                                  _checkBox5 = perms.get('addqty');
                                  _checkBox6 = perms.get('consume');
                                  _checkBox7 = perms.get('qr');
                                  _checkBox8 = perms.get('delete');
                                  _checkBox9 = perms.get('logsheet');
                                  _checkBox0 = perms.get('vendor');
                                });
                              }
                            });
                          },
                        );
                      },
                      value: _currentItemSelected,
                      // },
                    );
                  }),
            ],
          ),
          /* Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "   Desigination : ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.white,
                  isDense: true,
                  isExpanded: false,
                  iconEnabledColor: Colors.black,
                  focusColor: Colors.black,
                  items: options.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                        style: const TextStyle(
                          color: Colors.black,
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
            ),*/
          const SizedBox(
            height: 10,
          ),
          Text(
            '   Permissions :',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: checkboxtextcolor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 250),
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'All',
                style: TextStyle(color: checkboxtextcolor),
              ),
              value: _checkBox,
              onChanged: (value) {
                setState(() {
                  //print('$value');
                  //print(value);

                  _checkBox = value;
                  _checkBox1 = value;
                  _checkBox2 = value;
                  _checkBox3 = value;
                  _checkBox4 = value;
                  _checkBox5 = value;
                  _checkBox6 = value;
                  _checkBox7 = value;
                  _checkBox7 = value;
                  _checkBox8 = value;
                  _checkBox9 = value;
                  _checkBox0 = value;
                });
              },
              activeColor: checkboxtickbackcolor,
              checkColor: checkboxtickcolor,
              shape: checkboxtileshape(),
              splashRadius: checkboxsplash(),
              checkboxShape: checkboxshape(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'Add Category',
                style: TextStyle(color: checkboxtextcolor),
              ),
              value: _checkBox1,
              onChanged: (value) {
                setState(() {
                  //print('$value');
                  _checkBox1 = value;
                });
              },
              activeColor: checkboxtickbackcolor,
              checkColor: checkboxtickcolor,
              shape: checkboxtileshape(),
              splashRadius: checkboxsplash(),
              checkboxShape: checkboxshape(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 100),
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'Add Product',
                style: TextStyle(color: checkboxtextcolor),
              ),
              value: _checkBox2,
              onChanged: (value) {
                setState(() {
                  //print('$value');
                  _checkBox2 = value;
                });
              },
              activeColor: checkboxtickbackcolor,
              checkColor: checkboxtickcolor,
              shape: checkboxtileshape(),
              splashRadius: checkboxsplash(),
              checkboxShape: checkboxshape(),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 200),
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'Edit',
                    style: TextStyle(color: checkboxtextcolor),
                  ),
                  value: _checkBox3,
                  onChanged: (value) {
                    setState(() {
                      //print('$value');
                      _checkBox3 = value;
                    });
                  },
                  activeColor: checkboxtickbackcolor,
                  checkColor: checkboxtickcolor,
                  shape: checkboxtileshape(),
                  splashRadius: checkboxsplash(),
                  checkboxShape: checkboxshape())),
          Padding(
              padding: const EdgeInsets.only(right: 200),
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'Info',
                    style: TextStyle(color: checkboxtextcolor),
                  ),
                  value: _checkBox4,
                  onChanged: (value) {
                    setState(() {
                      //print('$value');
                      _checkBox4 = value;
                    });
                  },
                  activeColor: checkboxtickbackcolor,
                  checkColor: checkboxtickcolor,
                  shape: checkboxtileshape(),
                  splashRadius: checkboxsplash(),
                  checkboxShape: checkboxshape()
                  // checkboxShape: StadiumBorder,
                  )),
          Padding(
              padding: const EdgeInsets.only(right: 200),
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'addqty',
                    style: TextStyle(color: checkboxtextcolor),
                  ),
                  value: _checkBox5,
                  onChanged: (value) {
                    setState(() {
                      //print('$value');
                      _checkBox5 = value;
                    });
                  },
                  activeColor: checkboxtickbackcolor,
                  checkColor: checkboxtickcolor,
                  shape: checkboxtileshape(),
                  splashRadius: checkboxsplash(),
                  checkboxShape: checkboxshape())),
          Padding(
              padding: const EdgeInsets.only(right: 200),
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'consume',
                    style: TextStyle(color: checkboxtextcolor),
                  ),
                  value: _checkBox6,
                  onChanged: (value) {
                    setState(() {
                      //print('$value');
                      _checkBox6 = value;
                    });
                  },
                  activeColor: checkboxtickbackcolor,
                  checkColor: checkboxtickcolor,
                  shape: checkboxtileshape(),
                  splashRadius: checkboxsplash(),
                  checkboxShape: checkboxshape())),
          Padding(
              padding: const EdgeInsets.only(right: 200),
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'qr',
                    style: TextStyle(color: checkboxtextcolor),
                  ),
                  value: _checkBox7,
                  onChanged: (value) {
                    setState(() {
                      //print('$value');
                      _checkBox7 = value;
                    });
                  },
                  activeColor: checkboxtickbackcolor,
                  checkColor: checkboxtickcolor,
                  shape: checkboxtileshape(),
                  splashRadius: checkboxsplash(),
                  checkboxShape: checkboxshape())),
          Padding(
              padding: const EdgeInsets.only(right: 200),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  'delete',
                  style: TextStyle(color: checkboxtextcolor),
                ),
                value: _checkBox8,
                onChanged: (value) {
                  setState(() {
                    //print('$value');
                    _checkBox8 = value;
                  });
                },
                activeColor: checkboxtickbackcolor,
                checkColor: checkboxtickcolor,
                shape: checkboxtileshape(),
                splashRadius: checkboxsplash(),
                checkboxShape: checkboxshape(),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 200),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  'logsheet',
                  style: TextStyle(color: checkboxtextcolor),
                ),
                value: _checkBox9,
                onChanged: (value) {
                  setState(() {
                    //print('$value');
                    _checkBox9 = value;
                  });
                },
                activeColor: checkboxtickbackcolor,
                checkColor: checkboxtickcolor,
                shape: checkboxtileshape(),
                splashRadius: checkboxsplash(),
                checkboxShape: checkboxshape(),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 200),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  'Vendor',
                  style: TextStyle(color: checkboxtextcolor),
                ),
                value: _checkBox0,
                onChanged: (value) {
                  setState(() {
                    //print('$value');
                    _checkBox0 = value;
                  });
                },
                activeColor: checkboxtickbackcolor,
                checkColor: checkboxtickcolor,
                shape: checkboxtileshape(),
                splashRadius: checkboxsplash(),
                checkboxShape: checkboxshape(),
              )),
          Center(
              child: ElevatedButton(
                  style: buttonstyle(),
                  onPressed: () {
                    ref1.doc(widget.raja!.id).update({
                      'role': _currentItemSelected,
                      'addc': _checkBox1,
                      'add': _checkBox2,
                      'edit': _checkBox3,
                      'info': _checkBox4,
                      'addqty': _checkBox5,
                      'consume': _checkBox6,
                      'qr': _checkBox7,
                      'delete': _checkBox8,
                      'logsheet': _checkBox9,
                      'vendor': _checkBox0
                    });
                    sendNotification(widget.raja!.get('token'),
                        'Admin has set your permissions', 'You can use now');
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(snacks(
                        "Permissions Has Been Set To ${uname.toString()} "));
                  },
                  child: Text(
                    'Done',
                    style: buttontextstyle(),
                  )))
        ])));
  }
}
