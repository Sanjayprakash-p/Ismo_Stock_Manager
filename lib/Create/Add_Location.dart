// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// TextEditingController first = TextEditingController();
// TextEditingController second = TextEditingController();
// TextEditingController third = TextEditingController();
// TextEditingController four = TextEditingController();

// class local extends StatefulWidget {
//   const local({Key? key}) : super(key: key);
//   @override
//   State<local> createState() => _localState();
// }

// class _localState extends State<local> {
//   String? selectedMake;
//   late Map<String, List<String>> dataset1;
//   String? selectedStock;
//   String? selected;
//   bool loading = false;
//   int count = 0;
//   bool loading2 = false;
//   List<TextEditingController> listController = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//             backgroundColor: Colors.black,
//             elevation: 10,
//             splashColor: Colors.orangeAccent,
//             onPressed: () {
//               showModalBottomSheet(
//                   isScrollControlled: true,
//                   context: context,
//                   builder: (BuildContext ctx) {
//                     return Padding(
//                       padding: EdgeInsets.only(
//                           top: 20,
//                           right: 20,
//                           left: 20,
//                           bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Center(
//                             child: Text(
//                               "Create Location",
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           TextField(
//                             cursorColor: Colors.orangeAccent,
//                             style: const TextStyle(color: Colors.orangeAccent),
//                             controller: third,
//                             decoration: const InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.orangeAccent),
//                                 ),
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.orangeAccent),
//                                 ),
//                                 labelText: 'Main Location',
//                                 labelStyle:
//                                     TextStyle(color: Colors.orangeAccent)),
//                           ),
//                           Center(
//                             child: ElevatedButton(
//                                 onPressed: () async {
//                                   await FirebaseFirestore.instance
//                                       .collection('location')
//                                       .add({'main': third.text});
//                                   third.clear();
//                                   if (!mounted) return;
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text("Create")),
//                           )
//                         ],
//                       ),
//                     );
//                   });
//             },
//             child: const Icon(
//               Icons.add,
//               color: Colors.orangeAccent,
//             )),
//         body: loading
//             ? const CircularProgressIndicator()
//             : Center(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                       StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance
//                               .collection('location')
//                               .snapshots(),
//                           builder: (context, snapshots) {
//                             List<DropdownMenuItem> stockItems = [];

//                             final Stock = snapshots.data?.docs.toList();
//                             if (Stock != null) {
//                               for (var Stocks in Stock) {
//                                 stockItems.add(
//                                   DropdownMenuItem(
//                                     value: Stocks.id,
//                                     child: Text(
//                                       Stocks['main'],
//                                     ),
//                                   ),
//                                 );
//                               }
//                             }
//                             return DropdownButton(
//                               hint: const Text('Select location'),
//                               items: stockItems,
//                               onChanged: (StockValue) {
//                                 setState(() {
//                                   selectedMake = null;
//                                   selectedStock = StockValue;
//                                   FirebaseFirestore.instance
//                                       .collection('location')
//                                       .doc(StockValue)
//                                       .get()
//                                       .then(
//                                           (DocumentSnapshot documentSnapshot) {
//                                     setState(() {
//                                       if (documentSnapshot['main'] != null) {
//                                         selected = documentSnapshot['main'];
//                                       } else {
//                                         selected = null;
//                                       }
//                                     });
//                                   });
//                                 });
//                               },
//                               value: selectedStock,
//                             );
//                           }),
//                       IconButton(
//                           onPressed: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (ctx) => Center(
//                                       child: SingleChildScrollView(
//                                           child: AlertDialog(
//                                               title: loading2
//                                                   ? const CircularProgressIndicator()
//                                                   : Column(children: [
//                                                       Row(children: [
//                                                         Expanded(
//                                                             flex: 2,
//                                                             child: TextField(
//                                                                 readOnly: true,
//                                                                 controller:
//                                                                     first,
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .center,
//                                                                 decoration:
//                                                                     InputDecoration(
//                                                                   border:
//                                                                       const OutlineInputBorder(),
//                                                                   hintText:
//                                                                       selected,
//                                                                 ))),
//                                                         const SizedBox(
//                                                             width: 10),
//                                                         Expanded(
//                                                             flex: 1,
//                                                             child: TextField(
//                                                               controller:
//                                                                   second,
//                                                               decoration: const InputDecoration(
//                                                                   border:
//                                                                       OutlineInputBorder(),
//                                                                   hintText:
//                                                                       'No fields'),
//                                                             )),
//                                                         Expanded(
//                                                             flex: 1,
//                                                             child: IconButton(
//                                                                 onPressed: () {
//                                                                   setState(() {
//                                                                     loading2 =
//                                                                         true;
//                                                                     count = int
//                                                                         .parse(second
//                                                                             .text);
//                                                                     setState(
//                                                                         () {
//                                                                       for (int i =
//                                                                               0;
//                                                                           i < count;
//                                                                           i++) {
//                                                                         listController
//                                                                             .add(TextEditingController());
//                                                                       }
//                                                                     });
//                                                                   });
//                                                                   setState(() {
//                                                                     Future.delayed(const Duration(
//                                                                         seconds:
//                                                                             2));
//                                                                     loading2 =
//                                                                         false;
//                                                                   });
//                                                                 },
//                                                                 icon:
//                                                                     const Icon(
//                                                                   Icons.check,
//                                                                   color: Colors
//                                                                       .green,
//                                                                 )))
//                                                       ]),
//                                                       if (count != 0)
//                                                         for (int i = 0;
//                                                             i < count;
//                                                             i++)
//                                                           TextField(
//                                                             controller:
//                                                                 listController[
//                                                                     i],
//                                                             decoration:
//                                                                 InputDecoration(
//                                                                     hintText:
//                                                                         'location $i of $selected'),
//                                                           )
//                                                     ]),
//                                               actions: <Widget>[
//                                             MaterialButton(
//                                                 onPressed: () {
//                                                   Navigator.of(ctx).pop();
//                                                 },
//                                                 color: const Color.fromARGB(
//                                                     255, 0, 22, 145),
//                                                 child: const Text("Cancel",
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                     ))),
//                                             MaterialButton(
//                                                 onPressed: () async {
//                                                   if (count != 0) {
//                                                     for (int i = 0;
//                                                         i < count;
//                                                         i++) {
//                                                       await FirebaseFirestore
//                                                           .instance
//                                                           .collection(
//                                                               'location')
//                                                           .doc(selectedStock)
//                                                           .collection(
//                                                               'sublocation')
//                                                           .add({
//                                                         'sub': listController[i]
//                                                             .text
//                                                       });
//                                                       listController[i].clear();
//                                                     }
//                                                     Navigator.of(ctx).pop();
//                                                   }
//                                                 },
//                                                 color: const Color.fromARGB(
//                                                     255, 0, 22, 145),
//                                                 child: const Text("Update",
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                     )))
//                                           ])),
//                                     ));
//                           },
//                           icon: const Icon(Icons.add)),
//                       IconButton(
//                           onPressed: () {},
//                           /* onPressed: () async {
//                             setState(() {
//                               loading = true;
//                             });
//                             var dele = selectedStock;
//                             if (dele != null) {
//                               setState(() {
//                                 selectedStock = null;
//                               });
//                               var collection = FirebaseFirestore.instance
//                                   .collection('location')
//                                   .doc(dele)
//                                   .collection('sublocation');
//                               var snapshots = await collection.get();
//                               for (var doc in snapshots.docs) {
//                                 await doc.reference.delete();
//                               }
//                               await FirebaseFirestore.instance
//                                   .collection('location')
//                                   .doc(dele)
//                                   .delete();
//                             }
//                             setState(() {
//                               loading = false;
//                             });
//                           },*/
//                           icon: const Icon(Icons.delete)),
//                     ]),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('location')
//                             .doc(selectedStock)
//                             .collection('sublocation')
//                             .snapshots(),
//                         builder: (context, snapshots) {
//                           List<DropdownMenuItem> stockItems = [];
//                           List<String> stockItems1 = [];

//                           final Stock = snapshots.data?.docs.toList();
//                           if (Stock != null) {
//                             for (var Stocks in Stock) {
//                               stockItems1.add(Stocks['sub']);
//                               stockItems.add(DropdownMenuItem(
//                                   value: Stocks.id,
//                                   child: Text(
//                                     Stocks['sub'],
//                                   )));
//                             }
//                           }

//                           dataset1 = {
//                             selected.toString(): stockItems1,
//                           };

//                           return DropdownButton<String?>(
//                               value: selectedMake,
//                               items: (dataset1[selected] ?? []).map((e) {
//                                 return DropdownMenuItem<String?>(
//                                   value: e,
//                                   child: Text('$e'),
//                                 );
//                               }).toList(),
//                               onChanged: (val) {
//                                 setState(() {
//                                   selectedMake = val!;
//                                 });
//                               });
//                         }),
//                     Text('$selected / $selectedMake'),
//                     TextButton(
//                       onPressed: () {},
//                       child: const Icon(Icons.add),
//                     )
//                   ])));
//   }
// }
