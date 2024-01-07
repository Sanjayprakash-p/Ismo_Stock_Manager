import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/authentication/Login_Page.dart';
import 'package:flutter_application_2/authentication/Sign_Up_Page.dart';

// import 'package:flutter_application_2/log/detaill.dart';

import '../Home/bottomnavigation.dart';
import '../main.dart';
import 'detaill.dart';

String? selectedStock;

class logsheet extends StatefulWidget {
  const logsheet({super.key});

  @override
  State<logsheet> createState() => _logsheetState();
}

class _logsheetState extends State<logsheet> {
  int _selectednum = 0;
  bool loadingg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOG sheet'),
      ),
      body: loadingg
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: ref1.snapshots(),
                      builder: (context, snapshots) {
                        List<DropdownMenuItem> stockItems = [];

                        if (!snapshots.hasData) {
                          const CircularProgressIndicator();
                        } else {
                          final stock = snapshots.data?.docs.toList();
                          //final sub = snapshots.data?.docs.toList();
                          ////(stock);
                          stockItems.add(const DropdownMenuItem(
                              value: "0",
                              child: Text(
                                'All Users',
                                style: TextStyle(color: Colors.orangeAccent),
                              )));

                          if (stock!.isNotEmpty) {
                            for (var stocks in stock) {
                              stockItems.add(
                                DropdownMenuItem(
                                  value: stocks.get('email'),
                                  child: Text(
                                    stocks['email'],
                                    style:
                                        TextStyle(color: Colors.orangeAccent),
                                  ),
                                ),
                              );
                            }
                          }
                          // stockItems.add(DropdownMenuItem(
                          //     //value: "0",
                          //     child: TextField(
                          //         cursorColor: Colors.orangeAccent,
                          //         style:
                          //             TextStyle(color: Colors.orangeAccent),
                          //         decoration: InputDecoration(
                          //           enabledBorder: UnderlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Colors.orangeAccent),
                          //           ),
                          //           focusedBorder: UnderlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Colors.orangeAccent),
                          //           ),
                          //           labelStyle:
                          //               TextStyle(color: Colors.orangeAccent),
                          //           labelText: 'Name',
                          //         ))));

                          //}
                        }
                        return DropdownButton(
                          items: stockItems,
                          onChanged: (StockValue) {
                            setState(
                              () {
                                selectedStock = StockValue;
                                // san();
                              },
                            );
                            // //('uid :$StockValue');
                            // //('result:$stockItems');

                            // FirebaseFirestore.instance
                            //     .collection('users')
                            //     .doc(selectedStock)
                            //     .get()
                            //     .then((DocumentSnapshot documentSnapshot) {
                            //   //(documentSnapshot['username']);
                            // });
                            // //(selectedStock);
                            //raja.doc('MLwAJxrPT6QXgsUwmFHD').get();
                            ////(raja);
                          },
                          value: selectedStock,
                          isExpanded: true,
                        );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loadingg = true;
                        });
                        stockItems.clear();
                        var collection = FirebaseFirestore.instance
                            .collection('All Users Data');
                        var snaps = await collection.get();

                        for (var doc in snaps.docs) {
                          var collection1 = FirebaseFirestore.instance
                              .collection('All Users Data')
                              .doc(doc.id)
                              .collection('operations');
                          var snap = await collection1.get();

                          for (var doc1 in snap.docs) {
                            stockItems.add(doc1.data());
                          }
                        }

                        // adddaa(selectedStock, 'All');
                        // setState(() {
                        //   loadingg = false;
                        // });
                        // Navigator.push(
                        //   context,
                        //   PageRouteBuilder(
                        //     pageBuilder: (_, __, ___) => MyWidget(),
                        //     transitionDuration: Duration(seconds: 2),
                        //     transitionsBuilder: (_, a, __, c) =>
                        //         FadeTransition(opacity: a, child: c),
                        //   ),
                        // );

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MyWidget()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Set the button's background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(16)), // Set the button's padding
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Set the button's border radius
                          ),
                        ),
                      ),
                      child: Text('ALL DATA')),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        adddaa(selectedStock, 'Add');
                        Navigator.of(context).push(FadeRoute(page: dummylog()));
                        /* Navigator.push(context,
                      MaterialPageRoute(builder: (context) => dummylog()));*/
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Set the button's background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(16)), // Set the button's padding
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Set the button's border radius
                          ),
                        ),
                      ),
                      child: Text('ADD DATA')),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        adddaa(selectedStock, 'Edit');
                        Navigator.of(context).push(FadeRoute(page: dummylog()));
                        /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => dummylog()));*/
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Set the button's background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(16)), // Set the button's padding
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Set the button's border radius
                          ),
                        ),
                      ),
                      child: Text('EDIT DATA')),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        adddaa(selectedStock, 'Delete');
                        Navigator.of(context).push(FadeRoute(page: dummylog()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Set the button's background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(16)), // Set the button's padding
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Set the button's border radius
                          ),
                        ),
                      ),
                      child: Text('DELETE DATA')),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      adddaa(selectedStock, 'Consume');
                      Navigator.of(context).push(FadeRoute(page: dummylog()));
                      /*Navigator.push(context,
                    MaterialPageRoute(builder: (context) => dummylog()));*/
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue), // Set the button's background color
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(16)), // Set the button's padding
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // Set the button's border radius
                        ),
                      ),
                    ),
                    child: Text('CONSUME DATA'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        adddaa(selectedStock, 'Add Qty');
                        Navigator.of(context).push(FadeRoute(page: dummylog()));
                        /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => dummylog()));*/
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Set the button's background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(16)), // Set the button's padding
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Set the button's border radius
                          ),
                        ),
                      ),
                      child: Text('ADD QUANTITY')),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        adddaa(selectedStock, 'Add C');
                        Navigator.of(context).push(FadeRoute(page: dummylog()));
                        /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => dummylog()));*/
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Set the button's background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(16)), // Set the button's padding
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Set the button's border radius
                          ),
                        ),
                      ),
                      child: Text('ADD CATEGORY')),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}


/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/log/addlog.dart';
import 'package:flutter_application_2/log/dummy.dart';

class logsheet extends StatefulWidget {
  const logsheet({super.key});

  @override
  State<logsheet> createState() => _logsheetState();
}

class _logsheetState extends State<logsheet> {
  int _selectednum = 0;
  String? selectedStock;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOG sheet'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshots) {
                  List<DropdownMenuItem> stockItems = [];

                  if (!snapshots.hasData) {
                    const CircularProgressIndicator();
                  } else {
                    final stock = snapshots.data?.docs.toList();
                    //final sub = snapshots.data?.docs.toList();
                    //(stock);
                    stockItems.add(const DropdownMenuItem(
                        value: "0",
                        child: Text(
                          'All Users',
                          style: TextStyle(color: Colors.orangeAccent),
                        )));

                    if (stock!.isNotEmpty) {
                      for (var stocks in stock) {
                        stockItems.add(
                          DropdownMenuItem(
                            value: stocks.id,
                            child: Text(
                              stocks['username'],
                              style: TextStyle(color: Colors.orangeAccent),
                            ),
                          ),
                        );
                      }
                    }
                    // stockItems.add(DropdownMenuItem(
                    //     //value: "0",
                    //     child: TextField(
                    //         cursorColor: Colors.orangeAccent,
                    //         style:
                    //             TextStyle(color: Colors.orangeAccent),
                    //         decoration: InputDecoration(
                    //           enabledBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(
                    //                 color: Colors.orangeAccent),
                    //           ),
                    //           focusedBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(
                    //                 color: Colors.orangeAccent),
                    //           ),
                    //           labelStyle:
                    //               TextStyle(color: Colors.orangeAccent),
                    //           labelText: 'Name',
                    //         ))));

                    //}
                  }
                  return DropdownButton(
                    items: stockItems,
                    onChanged: (StockValue) {
                      setState(
                        () {
                          selectedStock = StockValue;
                          // san();
                        },
                      );
                      // //('uid :$StockValue');
                      // //('result:$stockItems');

                      // FirebaseFirestore.instance
                      //     .collection('users')
                      //     .doc(selectedStock)
                      //     .get()
                      //     .then((DocumentSnapshot documentSnapshot) {
                      //   //(documentSnapshot['username']);
                      // });
                      // //(selectedStock);
                      //raja.doc('MLwAJxrPT6QXgsUwmFHD').get();
                      ////(raja);
                    },
                    value: selectedStock,
                    isExpanded: true,
                  );
                }),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  adddata(selectedStock, 'All');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addlog()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue), // Set the button's background color
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(16)), // Set the button's padding
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Set the button's border radius
                    ),
                  ),
                ),
                child: Text('ALL DATA')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  adddata(selectedStock, 'add');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addlog()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue), // Set the button's background color
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(16)), // Set the button's padding
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Set the button's border radius
                    ),
                  ),
                ),
                child: Text('ADD DATA')),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => dummylog()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue), // Set the button's background color
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(16)), // Set the button's padding
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Set the button's border radius
                    ),
                  ),
                ),
                child: Text('EDIT DATA')),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue), // Set the button's background color
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(16)), // Set the button's padding
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Set the button's border radius
                    ),
                  ),
                ),
                child: Text('DELETE DATA')),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                adddata(selectedStock, 'consume');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => addlog()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.blue), // Set the button's background color
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.all(16)), // Set the button's padding
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30), // Set the button's border radius
                  ),
                ),
              ),
              child: Text('CONSUME DATA'),
            ),
            SizedBox(height: 20,),
             CupertinoButton.filled(child: Text('Consume qty = $_selectednum'), onPressed:()=> showCupertinoModalPopup(
                                  context: context,
                                  builder: (_)=> SizedBox(
                                    width: 200,
                                    height: 250,
                                    child: CupertinoPicker(
                                      backgroundColor: Colors.transparent,
                                      itemExtent: 100,
                                      scrollController: FixedExtentScrollController(
                                        initialItem: 1,
                                      ),
                                         children: const[
                                          Text('0'),
                                          Text('1'),
                                          Text('2'),
                                          Text('3'),
                                          Text('4'),
                                          Text('5'),
                                          Text('6'),
                                          Text('7'),
                                          Text('8'),
                                          Text('9'),
                                          Text('10'),
                                          Text('11'),
                                          Text('12'),
                                          Text('13'),
                                          Text('14'),
                                          Text('15'),
                                          Text('16'),
                                          Text('17'),
                                          Text('18'),
                                          Text('19'),
                                          Text('20'),
                                         ],
                                      onSelectedItemChanged: ( (value) {
                                        setState(() {
                                          _selectednum = value;
                                          
                                        });
                                        
                                      }),
                                   
                                      ),
                                  ))),
          ],
        ),
      ),
    );
  }
}*/
