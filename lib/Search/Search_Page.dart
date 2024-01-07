import 'package:alert_banner/exports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Constants/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../Home/bottomnavigation.dart';
import '../Constants/Decorations.dart';
import '../CustomWidget/bottom_notification.dart';
import '../Delete/delete_pop.dart';
import '../Edit/Edit_Page.dart';
import '../Home/Employee_Home.dart';
import '../Read/Info_Page.dart';
import '../Zoomer/pinch_zoom.dart';

final FocusNode _searchFocusNode = FocusNode();
var format = DateFormat('dd-MM-yyyy (hh:mm:ss)');
String result = 'Search';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      result = 'search';
    });

    _searchFocusNode.requestFocus(); // Request focus on page load
  }

  @override
  void dispose() {
    _searchController.dispose();
    print('dispose sucess');
    super.dispose();
  }

  final TextEditingController _searchController = TextEditingController();
  Stream<List<QueryDocumentSnapshot>>? _searchStream;
  bool _isTextFieldVisible = false;
  void _startSearch(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        result = 'Search';
        _searchStream = null;
      });
    } else {
      setState(() {
        _searchStream = _getSearchStream(searchText);
      });
    }
  }

  Stream<List<QueryDocumentSnapshot>> _getSearchStream(String searchText) {
    return FirebaseFirestore.instance
        .collection('Stocks')
        .get()
        .then((mainCollectionSnapshot) async {
      List<QueryDocumentSnapshot> searchResults = [];

      for (QueryDocumentSnapshot mainDocument in mainCollectionSnapshot.docs) {
        final subcollectionQuery = await mainDocument.reference
            .collection('productss')
            // .where('name'.toLowerCase(),
            //     isGreaterThanOrEqualTo: searchText.toLowerCase())
            .get();
        //searchResults.addAll(subcollectionQuery.docs);
        for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
            in subcollectionQuery.docs) {
          // Access individual fields using field names
          // print(documentSnapshot.get('name'));
          if (documentSnapshot['name']
              .toString()
              .toLowerCase()
              .startsWith(searchText.toLowerCase())) {
            print('result==${documentSnapshot['name']}');
            searchResults.add(documentSnapshot);
          }
          setState(() {
            result = 'No result found';
          });
          // Do something with the field
        }
        // for (int i = 0; i < searchResults.length; i++) {
        //   print(searchResults[i].get('field'));
        // }
      }

      return searchResults;
    }).asStream();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          centerTitle: true,
          // backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: _isTextFieldVisible,
                      child: TextField(
                        // canRequestFocus: false,
                        //onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        autofocus: true,
                        controller: _searchController,
                        onChanged: _startSearch,
                        decoration: InputDecoration(
                          enabledBorder: enabledadd(),
                          focusedBorder: focussadd(),
                          errorBorder: errorborderadd(),
                          focusedErrorBorder: errorfocusadd(),
                          hintText: 'Search...',
                          fillColor: Colors.grey.shade200,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: _searchStream != null
                      ? IconButton(
                          icon: const Icon(Icons.clear_sharp),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              result = 'search';
                            });
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              _isTextFieldVisible = !_isTextFieldVisible;
                            });
                          },
                        ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<List<QueryDocumentSnapshot>>(
                stream: _searchStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text(result));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data![index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.all(5.0),
                        child: Slidable(
                          closeOnScroll: true,
                          endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  // flex: 8,
                                  autoClose: true,

                                  onPressed: (context) {
                                    ref1.doc(user!.uid).get().then(
                                        (DocumentSnapshot documentSnapshot) {
                                      if (documentSnapshot.exists) {
                                        if (documentSnapshot.get('edit') ==
                                            true) {
                                          // raja(data);
                                          Navigator.of(context).push(FadeRoute(
                                              page: Edit(
                                            snapshot: data,
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
                                                AlertBannerLocation.bottom,
                                          );
                                        }
                                      }
                                    });
                                  },
                                  icon: Icons.mode_edit_outlined,
                                  foregroundColor: Colors.blue,
                                )
                              ]),
                          startActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  autoClose: true,
                                  backgroundColor: deletecolor,
                                  onPressed: (context) {
                                    ref1.doc(user!.uid).get().then(
                                        (DocumentSnapshot documentSnapshot) {
                                      if (documentSnapshot.exists) {
                                        if (documentSnapshot.get('delete') ==
                                            true) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Center(
                                                      child: deletepop(
                                                    snap: data,
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
                                                AlertBannerLocation.bottom,
                                          );
                                        }
                                      }
                                    });
                                  },
                                  icon: Icons.delete_forever_outlined,
                                  foregroundColor: Colors.red,
                                )
                              ]),
                          child: ListTile(
                              onTap: () {
                                ref1
                                    .doc(user!.uid)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) {
                                  if (documentSnapshot.exists) {
                                    if (documentSnapshot.get('info') == true) {
                                      raj(data);
                                      Navigator.of(context)
                                          .push(FadeRoute(page: info()));
                                    } else {
                                      showAlertBanner(
                                        context,
                                        () => print("TAPPED"),
                                        ExampleAlertBannerChild(
                                          text: 'Your not allowed!',
                                          color: Colors.red,
                                        ),
                                        alertBannerLocation:
                                            AlertBannerLocation.top,
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
                                              sanj: data['dp']);
                                        });
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(data['dp']),
                                  )),
                              title: Text(
                                data['name'],
                                style: listtiletextstyle(),
                              ),
                              subtitle: Text(
                                data['location'],
                                style: listsubtitlestyle(),
                              ),
                              trailing: Column(
                                children: [
                                  const SizedBox(
                                    width: 50,
                                    height: 13,
                                  ),
                                  const Spacer(),
                                  quantitygrade(data['quantity'], data['mqty'])
                                ],
                              )),
                        ),
                      );
                      // Build your list item UI using snapshot.data![index].data()
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CollectionReference _products = FirebaseFirestore.instance.collection('Stocks');
bool isRefresh = false;
// List stockItems = [];
// bool seload = false;
// var format = DateFormat('dd-MM-yyyy (hh:mm:ss a )');
/*
class searchpage extends StatefulWidget {
  const searchpage({super.key});
  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    stockItems.clear();
    super.dispose();
  }

  @override
  void initState() {
    seload = true;
    search();

    super.initState();
  }

  search() async {
    var collection = FirebaseFirestore.instance.collection('Stocks');
    var snaps = await collection.get();

    for (var doc in snaps.docs) {
      var collection1 = FirebaseFirestore.instance
          .collection('Stocks')
          .doc(doc.id)
          .collection('productss');
      var snap = await collection1.get();

      for (var doc1 in snap.docs) {
        //print('sdfsdf  ${doc1['name']}');
        stockItems.add(doc1);
      }
    }
    setState(() {
      seload = false;
    });
  }

  Future<void> _refresh() {
    setState(() {
      isRefresh = true;
    });

    setState(() {
      isRefresh = false;
    });
    return Future.delayed(const Duration(milliseconds: 1));
  }

  String name = "";
  //var newaa;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: seload
            ? CircleIndicator()
            : Scaffold(
                backgroundColor: screenbackgroundcolor,
                appBar: AppBar(
                  shape: appbarshape(),
                  backgroundColor: appbarcolor,
                  title: TextField(
                      style: searchtextt(),
                      cursorColor: searchcursorcolor,
                      decoration: searchborders(),
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      }),
                  automaticallyImplyLeading: false,
                ),
                body: SingleChildScrollView(
                  child: Column(children: [
                    for (var data in stockItems)
                      if (data['name']
                          .toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase()))
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.all(5.0),
                          child: Slidable(
                            closeOnScroll: true,
                            endActionPane: ActionPane(
                                extentRatio: 0.2,
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    // flex: 8,
                                    autoClose: true,
                                    backgroundColor: editcolor,
                                    onPressed: (context) {
                                      ref1.doc(user!.uid).get().then(
                                          (DocumentSnapshot documentSnapshot) {
                                        if (documentSnapshot.exists) {
                                          if (documentSnapshot.get('edit') ==
                                              true) {
                                            // raja(data);
                                            Navigator.of(context)
                                                .push(FadeRoute(
                                                    page: Edit(
                                              snapshot: data,
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
                                                  AlertBannerLocation.bottom,
                                            );
                                          }
                                        }
                                      });
                                    },
                                    icon: Icons.mode_edit_outlined,
                                    foregroundColor: Colors.blue,
                                  )
                                ]),
                            startActionPane: ActionPane(
                                extentRatio: 0.2,
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    autoClose: true,
                                    backgroundColor: deletecolor,
                                    onPressed: (context) {
                                      ref1.doc(user!.uid).get().then(
                                          (DocumentSnapshot documentSnapshot) {
                                        if (documentSnapshot.exists) {
                                          if (documentSnapshot.get('delete') ==
                                              true) {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Center(
                                                        child: deletepop(
                                                      snap: data,
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
                                                  AlertBannerLocation.bottom,
                                            );
                                          }
                                        }
                                      });
                                    },
                                    icon: Icons.delete_forever_outlined,
                                    foregroundColor: Colors.red,
                                  )
                                ]),
                            child: ListTile(
                                onTap: () {
                                  ref1.doc(user!.uid).get().then(
                                      (DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      if (documentSnapshot.get('info') ==
                                          true) {
                                        raj(data);
                                        Navigator.of(context)
                                            .push(FadeRoute(page: info()));
                                      } else {
                                        showAlertBanner(
                                          context,
                                          () => print("TAPPED"),
                                          ExampleAlertBannerChild(
                                            text: 'Your not allowed!',
                                            color: Colors.red,
                                          ),
                                          alertBannerLocation:
                                              AlertBannerLocation.top,
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
                                                sanj: data['dp']);
                                          });
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(data['dp']),
                                    )),
                                title: Text(
                                  data['name'],
                                  style: listtiletextstyle(),
                                ),
                                subtitle: Text(
                                  data['location'],
                                  style: listsubtitlestyle(),
                                ),
                                trailing: Column(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      height: 13,
                                    ),
                                    Spacer(),
                                    quantitygrade(
                                        data['quantity'], data['mqty'])
                                  ],
                                )),
                          ),
                        ),
                    // Spacer(),
                    // SizedBox()
                    //print(data['name']  .toString() .toLowerCase() .startsWith(name.toLowerCase()));
                    /*Card(
                      shape: listtileshape(),
                      color: listtilecolor,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                          onTap: () {
                            ref1
                                .doc(user!.uid)
                                .get()
                                .then((DocumentSnapshot documentSnapshot) {
                              if (documentSnapshot.exists) {
                                if (documentSnapshot.get('info') == true) {
                                  raj(data);
                                  Navigator.of(context)
                                      .push(FadeRoute(page: info()));
                                  /* Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        info()));
                                                          });*/
                                } else {
                                  showAlertBanner(
                                    context,
                                    () => print("TAPPED"),
                                    ExampleAlertBannerChild(
                                      text: 'Your not allowed!',
                                      color: Colors.red,
                                    ),
                                    alertBannerLocation:
                                        AlertBannerLocation.top,
                                  );
            
                                  //print('Your not allowed');
                                }
                              }
                            });
                          },
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: listtiletextstyle(),
                          ),
                          subtitle: Text(
                            data['location'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: listtiletextstyle(),
                          ),
                          leading: GestureDetector(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(data['dp']),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PinchZoomImage(
                                        sanj: data['dp'],
                                      );
                                    });
                              }),
                          trailing: SizedBox(
                              width: 85,
                              child: Row(children: [
                                quantitygrade(data['quantity'], data['mqty']),
                                PopupMenuButton(
                                    color: listtileiconcolor,
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                              value: '1',
                                              child: Icon(
                                                Icons.mode_edit_outlined,
                                                color: popupmenuiconcolor,
                                              )),
                                          PopupMenuItem(
                                              value: '2',
                                              child: Icon(
                                                Icons.delete_rounded,
                                                color: popupmenuiconcolor,
                                              )),
                                          PopupMenuItem(
                                              value: '3',
                                              child: Icon(
                                                Icons.qr_code_outlined,
                                                color: popupmenuiconcolor,
                                              ))
                                        ],
                                    onSelected: (value) async {
                                      if (value == '1') {
                                        ref1.doc(user!.uid).get().then(
                                            (DocumentSnapshot
                                                documentSnapshot) {
                                          if (documentSnapshot.exists) {
                                            if (documentSnapshot.get('edit') ==
                                                true) {
                                              raja(data);
                                              Navigator.of(context).push(
                                                  FadeRoute(
                                                      page: const kushal()));
                                              /*Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              kushal()));*/
                                            } else {
                                              showAlertBanner(
                                                context,
                                                () => print("TAPPED"),
                                                ExampleAlertBannerChild(
                                                  text: 'Your not allowed!',
                                                  color: Colors.red,
                                                ),
                                                alertBannerLocation:
                                                    AlertBannerLocation.bottom,
                                                // .. EDIT MORE FIELDS HERE ...
                                              );
            
                                              // print('Your not allowed');
                                            }
                                          }
                                        });
                                      } else if (value == '2') {
                                        showDialog(
                                            context: context,
                                            builder: (context) => Center(
                                                    child: deletepop(
                                                  snap: data,
                                                  /*col: FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'Stocks/${documentSnapshot['Category']}/productss')*/
                                                )));
                                        /*popup(context,);
              
                                                                                        try{
              
                                                                                        FirebaseStorage.instance.
                                                                                        refFromURL(sun.get('dp')).delete();
                                                                                        }catch(e){
                                                                                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                            content: Text('You have successfully deleted a product',style:TextStyle(color: Colors.green) ,)));
                                                            }*/
                                      } else if (value == '3') {
                                        ref1.doc(user!.uid).get().then(
                                            (DocumentSnapshot
                                                documentSnapshot) {
                                          if (documentSnapshot.exists) {
                                            if (documentSnapshot.get('qr') ==
                                                true) {
                                              Navigator.of(context).push(
                                                  FadeRoute(
                                                      page:
                                                          baroce(raja: data)));
                                              /*Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => baroce(
                                                                                raja: data['qrname'],
                                                                              )));*/
                                            } else {
                                              showAlertBanner(
                                                context,
                                                () => print("TAPPED"),
                                                ExampleAlertBannerChild(
                                                  text: 'Your not allowed!',
                                                  color: Colors.red,
                                                ),
                                                alertBannerLocation:
                                                    AlertBannerLocation.bottom,
                                                // .. EDIT MORE FIELDS HERE ...
                                              );
            
                                              //                            print('Your not allowed');
                                            }
                                          }
                                        });
                                      }
                                    }),
                                Container()
                              ]))))*/
                  ]),
                ),

                // : StreamBuilder(
                //     stream: _products.snapshots(),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return const CircularProgressIndicator();
                //       } else {
                //         return ListView.builder(
                //             itemCount: snapshot.data!.docs.length,
                //             itemBuilder: (context, index) {
                //               DocumentSnapshot documentSnapshot =
                //                   snapshot.data!.docs[index];
                //               return Column(children: <Widget>[
                //                 FutureBuilder(
                //                     future: FirebaseFirestore.instance
                //                         .collection(
                //                             'Stocks/${documentSnapshot['Category']}/productss')
                //                         .get(),
                //                     builder: (BuildContext context, snap) {
                //                       if (snap.hasData) {
                //                         if (snap.data != null) {
                //                           var ss = snap.data!.docs.toList();
                //                           //print('result of ss=$ss');
                //                           for (var data in ss) {
                //                             stockItems.add(
                //                               data.data(),
                //                             );
                //                             // print('najak=${snap.data!.docs.length}\n---------------------------------');
                //                             // print('object');
                //                             if (data['name']
                //                                 .toString()
                //                                 .toLowerCase()
                //                                 .startsWith(
                //                                     name.toLowerCase())) {
                //                               // print(data['name']  .toString() .toLowerCase() .startsWith(name.toLowerCase()));
                //                               return Card(
                //                                   shape: listtileshape(),
                //                                   color: listtilecolor,
                //                                   margin:
                //                                       const EdgeInsets.all(10),
                //                                   child: ListTile(
                //                                       onTap: () {
                //                                         ref1
                //                                             .doc(user!.uid)
                //                                             .get()
                //                                             .then((DocumentSnapshot
                //                                                 documentSnapshot) {
                //                                           if (documentSnapshot
                //                                               .exists) {
                //                                             if (documentSnapshot
                //                                                     .get(
                //                                                         'info') ==
                //                                                 true) {
                //                                               raj(data);
                //                                               Navigator.of(
                //                                                       context)
                //                                                   .push(FadeRoute(
                //                                                       page:
                //                                                           info()));
                //                                               /* Navigator.push(
                //                                           context,
                //                                           MaterialPageRoute(
                //                                               builder:
                //                                                   (context) =>
                //                                                       info()));
                //                                         });*/
                //                                             } else {
                //                                               showAlertBanner(
                //                                                 context,
                //                                                 () => print(
                //                                                     "TAPPED"),
                //                                                 ExampleAlertBannerChild(
                //                                                   text:
                //                                                       'Your not allowed!',
                //                                                   color: Colors
                //                                                       .red,
                //                                                 ),
                //                                                 alertBannerLocation:
                //                                                     AlertBannerLocation
                //                                                         .top,
                //                                               );

                //                                               //print('Your not allowed');
                //                                             }
                //                                           }
                //                                         });
                //                                       },
                //                                       title: Text(
                //                                         data['name'],
                //                                         maxLines: 1,
                //                                         overflow: TextOverflow
                //                                             .ellipsis,
                //                                         style:
                //                                             listtiletextstyle(),
                //                                       ),
                //                                       subtitle: Text(
                //                                         data['location'],
                //                                         maxLines: 1,
                //                                         overflow: TextOverflow
                //                                             .ellipsis,
                //                                         style:
                //                                             listtiletextstyle(),
                //                                       ),
                //                                       leading: GestureDetector(
                //                                           child: CircleAvatar(
                //                                             backgroundImage:
                //                                                 NetworkImage(
                //                                                     data['dp']),
                //                                           ),
                //                                           onTap: () {
                //                                             showDialog(
                //                                                 context:
                //                                                     context,
                //                                                 builder:
                //                                                     (context) {
                //                                                   return PinchZoomImage(
                //                                                     sanj: data[
                //                                                         'dp'],
                //                                                   );
                //                                                 });
                //                                           }),
                //                                       trailing: SizedBox(
                //                                           width: 85,
                //                                           child: Row(children: [
                //                                             quantitygrade(
                //                                                 data[
                //                                                     'quantity'],
                //                                                 data['mqty']),
                //                                             PopupMenuButton(
                //                                                 color:
                //                                                     listtileiconcolor,
                //                                                 itemBuilder:
                //                                                     (context) =>
                //                                                         [
                //                                                           PopupMenuItem(
                //                                                               value: '1',
                //                                                               child: Icon(
                //                                                                 Icons.mode_edit_outlined,
                //                                                                 color: popupmenuiconcolor,
                //                                                               )),
                //                                                           PopupMenuItem(
                //                                                               value: '2',
                //                                                               child: Icon(
                //                                                                 Icons.delete_rounded,
                //                                                                 color: popupmenuiconcolor,
                //                                                               )),
                //                                                           PopupMenuItem(
                //                                                               value: '3',
                //                                                               child: Icon(
                //                                                                 Icons.qr_code_outlined,
                //                                                                 color: popupmenuiconcolor,
                //                                                               ))
                //                                                         ],
                //                                                 onSelected:
                //                                                     (value) async {
                //                                                   if (value ==
                //                                                       '1') {
                //                                                     ref1
                //                                                         .doc(user!
                //                                                             .uid)
                //                                                         .get()
                //                                                         .then((DocumentSnapshot
                //                                                             documentSnapshot) {
                //                                                       if (documentSnapshot
                //                                                           .exists) {
                //                                                         if (documentSnapshot.get('edit') ==
                //                                                             true) {
                //                                                           raja(
                //                                                               data);
                //                                                           Navigator.of(context)
                //                                                               .push(FadeRoute(page: const kushal()));
                //                                                           /*Navigator.push(
                //                                                     context,
                //                                                     MaterialPageRoute(
                //                                                         builder: (context) =>
                //                                                             kushal()));*/
                //                                                         } else {
                //                                                           showAlertBanner(
                //                                                             context,
                //                                                             () =>
                //                                                                 print("TAPPED"),
                //                                                             ExampleAlertBannerChild(
                //                                                               text: 'Your not allowed!',
                //                                                               color: Colors.red,
                //                                                             ),
                //                                                             alertBannerLocation:
                //                                                                 AlertBannerLocation.bottom,
                //                                                             // .. EDIT MORE FIELDS HERE ...
                //                                                           );

                //                                                           // print('Your not allowed');
                //                                                         }
                //                                                       }
                //                                                     });
                //                                                   } else if (value ==
                //                                                       '2') {
                //                                                     showDialog(
                //                                                         context:
                //                                                             context,
                //                                                         builder: (context) =>
                //                                                             Center(
                //                                                                 child: deletepop(
                //                                                               snap: data,
                //                                                               /*col: FirebaseFirestore
                //                                                           .instance
                //                                                           .collection(
                //                                                               'Stocks/${documentSnapshot['Category']}/productss')*/
                //                                                             )));
                //                                                     /*popup(context,);

                //                                                                       try{

                //                                                                       FirebaseStorage.instance.
                //                                                                       refFromURL(sun.get('dp')).delete();
                //                                                                       }catch(e){
                //                                                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //                                           content: Text('You have successfully deleted a product',style:TextStyle(color: Colors.green) ,)));
                //                                           }*/
                //                                                   } else if (value ==
                //                                                       '3') {
                //                                                     ref1
                //                                                         .doc(user!
                //                                                             .uid)
                //                                                         .get()
                //                                                         .then((DocumentSnapshot
                //                                                             documentSnapshot) {
                //                                                       if (documentSnapshot
                //                                                           .exists) {
                //                                                         if (documentSnapshot.get('qr') ==
                //                                                             true) {
                //                                                           Navigator.of(context)
                //                                                               .push(FadeRoute(page: baroce(raja: data)));
                //                                                           /*Navigator.push(
                //                                                     context,
                //                                                     MaterialPageRoute(
                //                                                         builder: (context) => baroce(
                //                                                               raja: data['qrname'],
                //                                                             )));*/
                //                                                         } else {
                //                                                           showAlertBanner(
                //                                                             context,
                //                                                             () =>
                //                                                                 print("TAPPED"),
                //                                                             ExampleAlertBannerChild(
                //                                                               text: 'Your not allowed!',
                //                                                               color: Colors.red,
                //                                                             ),
                //                                                             alertBannerLocation:
                //                                                                 AlertBannerLocation.bottom,
                //                                                             // .. EDIT MORE FIELDS HERE ...
                //                                                           );

                //                                                           //                            print('Your not allowed');
                //                                                         }
                //                                                       }
                //                                                     });
                //                                                   }
                //                                                 })
                //                                           ]))));
                //                             }

                //                             // print('kdsfks=${Stocks.data()}');
                //                             //Text('${ss.get('operation')}');
                //                             //print(stockItems);
                //                           }

                //                           //Text('${stockItems}');
                //                         } else {
                //                           return const Text("");
                //                         }
                //                       }

                //                       return Container();
                //                     }),
                //                 /*TextButton(
                //               onPressed: () {
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                         builder: (context) => Search_Page()));
                //               },
                //               child: Text('data')),*/
                //               ]);
                //             });
                //       }
                //     })
              ),
      ),
    );
  }
}
*/