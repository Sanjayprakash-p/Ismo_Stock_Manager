// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// String? selectedStock;
//   DateTimeRange _dateTimeRange =DateTimeRange(start:DateTime(2023,07,01), end: DateTime.now());
//  final start = _dateTimeRange.start;
//   final end = _dateTimeRange.end;
//   // DateTime? date;
//   // DateTime? date1;


// class log_ui extends StatefulWidget {
//   const log_ui({super.key});

//   @override
//   State<log_ui> createState() => _log_uiState();
// }

// class _log_uiState extends State<log_ui> {


//   @override
//   Widget build(BuildContext context) {
//     final today = DateTime.now();

//     final week = today.subtract(
//       Duration(days: 7),
//     );
//     final month = today.subtract(Duration(days: 30));
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         // appBar: AppBar(
//         //   title: Text("UI Page"),
//         //   centerTitle: true,
//         // ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.purple,
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(10, 8, 5, 10),
//                         child: Image.asset(
//                           'assets/files.png',
//                           height: height * 0.5,
//                           width: width * 0.5,
//                         ),
//                       ),
//                       /*Padding(
//                        padding: const EdgeInsets.only(top: 8,left: 20,bottom:100),
//                        child: Text('Log',style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),),
//                      ),*/
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 80, right: 20, bottom: 10, left: 20),
//                         child: Text(
//                           'Sheet',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 40,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       //drop down button option 1
//                     ],
//                   ),
//                 ),
//               ),
//               StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('users')
//                       .snapshots(),
//                   builder: (context, snapshots) {
//                     List<DropdownMenuItem> stockItems = [];

//                     if (!snapshots.hasData) {
//                       const CircularProgressIndicator();
//                     } else {
//                       final stock = snapshots.data?.docs.toList();
//                       //final sub = snapshots.data?.docs.toList();
//                       print(stock);
//                       stockItems.add(const DropdownMenuItem(
//                           value: "0",
//                           child: Text(
//                             'All Users',
//                             style: TextStyle(color: Colors.purple),
//                           )));

//                       if (stock!.isNotEmpty) {
//                         for (var stocks in stock) {
//                           stockItems.add(
//                             DropdownMenuItem(
//                               value: stocks.get('email'),
//                               child: Text(
//                                 stocks['email'],
//                                 style: TextStyle(color: Colors.purple),
//                               ),
//                             ),
//                           );
//                         }
//                       }
//                       // stockItems.add(DropdownMenuItem(
//                       //     //value: "0",
//                       //     child: TextField(
//                       //         cursorColor: Colors.orangeAccent,
//                       //         style:
//                       //             TextStyle(color: Colors.orangeAccent),
//                       //         decoration: InputDecoration(
//                       //           enabledBorder: UnderlineInputBorder(
//                       //             borderSide: BorderSide(
//                       //                 color: Colors.orangeAccent),
//                       //           ),
//                       //           focusedBorder: UnderlineInputBorder(
//                       //             borderSide: BorderSide(
//                       //                 color: Colors.orangeAccent),
//                       //           ),
//                       //           labelStyle:
//                       //               TextStyle(color: Colors.orangeAccent),
//                       //           labelText: 'Name',
//                       //         ))));

//                       //}
//                     }
//                     return DropdownButton(
//                       items: stockItems,
//                       onChanged: (StockValue) {
//                         setState(
//                           () {
//                             selectedStock = StockValue;
//                             // san();
//                           },
//                         );
//                         // print('uid :$StockValue');
//                         // print('result:$stockItems');

//                         // FirebaseFirestore.instance
//                         //     .collection('users')
//                         //     .doc(selectedStock)
//                         //     .get()
//                         //     .then((DocumentSnapshot documentSnapshot) {
//                         //   print(documentSnapshot['username']);
//                         // });
//                         // print(selectedStock);
//                         //raja.doc('MLwAJxrPT6QXgsUwmFHD').get();
//                         //print(raja);
//                       },
//                       value: selectedStock,
//                       isExpanded: true,
//                     );
//                   }),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Category',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Icon(Icons.arrow_forward_ios_outlined),
//                   ),
//                 ],
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     //drop down button option 2

//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ChoiceChip(
//                         elevation: 2,
//                         pressElevation: 4,
//                         labelPadding: EdgeInsets.all(4),
//                         label: Text('ALL...'),
//                         backgroundColor: Colors.red,
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         shadowColor: Colors.blueGrey,
//                         selected: chipselected,
//                         selectedColor: Colors.green,
//                         onSelected: (val) {
//                           setState(() {
//                             chipselected = val;
//                             chipselected0 = val;
//                             chipselected1 = val;
//                             chipselected3 = val;
//                             chipselected2 = val;
//                             chipselected8 = val;
//                           });
//                         },
//                       ),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ChoiceChip(
//                         elevation: 2,
//                         pressElevation: 4,
//                         labelPadding: EdgeInsets.all(4),
//                         label: Text('ADD...'),
//                         backgroundColor: Colors.red,
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         shadowColor: Colors.blueGrey,
//                         selected: chipselected0,
//                         selectedColor: Colors.green,
//                         onSelected: (val) {
//                           setState(() {
//                             chipselected0 = val;
//                           });
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ChoiceChip(
//                         elevation: 2,
//                         pressElevation: 4,
//                         labelPadding: EdgeInsets.all(4),
//                         label: Text('ADD qty'),
//                         backgroundColor: Colors.red,
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         shadowColor: Colors.blueGrey,
//                         selected: chipselected1,
//                         selectedColor: Colors.green,
//                         onSelected: (val) {
//                           setState(() {
//                             chipselected1 = val;
//                           });
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ChoiceChip(
//                         elevation: 2,
//                         pressElevation: 4,
//                         labelPadding: EdgeInsets.all(4),
//                         label: Text('EDIT...'),
//                         backgroundColor: Colors.red,
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         shadowColor: Colors.blueGrey,
//                         selected: chipselected8,
//                         selectedColor: Colors.green,
//                         onSelected: (val) {
//                           setState(() {
//                             chipselected8 = val;
//                           });
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ChoiceChip(
//                         elevation: 2,
//                         pressElevation: 4,
//                         labelPadding: EdgeInsets.all(4),
//                         label: Text('DELETE'),
//                         backgroundColor: Colors.red,
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         shadowColor: Colors.blueGrey,
//                         selected: chipselected2,
//                         selectedColor: Colors.green,
//                         onSelected: (val) {
//                           setState(() {
//                             chipselected2 = val;
//                           });
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ChoiceChip(
//                         elevation: 2,
//                         pressElevation: 4,
//                         labelPadding: EdgeInsets.all(4),
//                         label: Text('CONSUME'),
//                         backgroundColor: Colors.red,
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         shadowColor: Colors.blueGrey,
//                         selected: chipselected3,
//                         selectedColor: Colors.green,
//                         onSelected: (val) {
//                           setState(() {
//                             chipselected3 = val;
//                           });
//                         },

//                         // onSelected: (val){

//                         //       // final date =
//                         //       // await pickDate();
//                         //       // String datee;
//                         //   setState(() {
//                         //     // datee =
//                         //     //     '${date!.day}/${date.month}/${date.year}';

//                         //     chipselected3 = val;
//                         //   });
//                         //   print('$dateTime');

//                         // },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Category',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Icon(Icons.arrow_forward_ios_outlined),
//                   ),
//                 ],
//               ),
//               Row(
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10, left: 10),
//                     child: ChoiceChip(
//                       elevation: 2,
//                       pressElevation: 4,
//                       labelPadding: EdgeInsets.all(4),
//                       label: Text('Today'),
//                       backgroundColor: Colors.red,
//                       labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                       shadowColor: Colors.blueGrey,
//                       selected: chipselected6,
//                       selectedColor: Colors.green,
//                       onSelected: (val) {
//                         setState(() {
//                           chipselected6 = val;
//                         });
//                         print('today==== $today');
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       right: 10,
//                     ),
//                     child: ChoiceChip(
//                       elevation: 2,
//                       pressElevation: 4,
//                       labelPadding: EdgeInsets.all(4),
//                       label: Text('last Week'),
//                       backgroundColor: Colors.red,
//                       labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                       shadowColor: Colors.blueGrey,
//                       selected: chipselected4,
//                       selectedColor: Colors.green,
//                       onSelected: (val) {
//                         setState(() {
//                           chipselected4 = val;
//                         });
//                         print('Week ==== $week');
//                         print('today==== $today');
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: ChoiceChip(
//                       elevation: 2,
//                       pressElevation: 4,
//                       labelPadding: EdgeInsets.all(4),
//                       label: Text(' last Month'),
//                       backgroundColor: Colors.red,
//                       labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                       shadowColor: Colors.blueGrey,
//                       selected: chipselected5,
//                       selectedColor: Colors.green,
//                       onSelected: (val) {
//                         setState(() {
//                           chipselected5 = val;
//                         });
//                         print('month ==== $month');
//                         print('today==== $today');
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: ChoiceChip(
//                       elevation: 2,
//                       pressElevation: 4,
//                       labelPadding: EdgeInsets.all(4),
//                       label: Text('Custom'),
//                       backgroundColor: Colors.red,
//                       labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                       shadowColor: Colors.blueGrey,
//                       selected: chipselected7,
//                       selectedColor: Colors.green,
//                       onSelected: (val) {
//                         setState(() {
//                           chipselected7 = val;
//                         });
//                         print('month ==== $month');
//                         print('today==== $today');
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 216, 88, 239),
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         'Custom',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                              Container(
//                               decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: Colors.white),
//                               child: Text('${start.day.toString()}/'+'${start.month.toString()}/'+ '${start.year.toString()}',
//                               style:TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 20),),
//                               ),
                            
                          
//                           IconButton(onPressed: (){
//                             pickRangeDate();
//                           },icon : Icon(
//                             Icons.calendar_month_outlined
//                             ),
//                             ),
//                           SizedBox(
//                             width: 30,
//                           ),
//                           Text('To'),
//                           SizedBox(
//                             width: 30,
//                           ),
//                             Container(
//                             decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: Colors.white),
//                             child: Text('${end.day.toString()}/'+'${end.month.toString()}/'+ '${end.year.toString()}',
//                             style:TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 20),
//                             ),
//                             ),
//                           IconButton(onPressed: (){
//                             pickRangeDate();
//                             },
//                             icon :  Icon(
//                               Icons.calendar_month_outlined
//                               ),
//                               ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future pickRangeDate()async{
//   DateTimeRange? newDateTimeRange = await showDateRangePicker(
//   context: context,
//   initialDateRange: _dateTimeRange,
//  firstDate: DateTime(2023,07,01), 
//  lastDate: DateTime.now(),
//  );

//  if (newDateTimeRange == null)
//   return null;

//  setState(() {
//    _dateTimeRange = newDateTimeRange;
//  });
// }
// }
