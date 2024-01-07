// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/authentication/Authentication.dart';

// // import 'package:flutter_application_2/log/detaill.dart';

// import '../main.dart';
// import 'detaill.dart';

// String? selectedStock;

// class mystocks extends StatefulWidget {
//   const mystocks({super.key});

//   @override
//   State<mystocks> createState() => _mystocksState();
// }

// class _mystocksState extends State<mystocks> {
//   int _selectednum = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Stocks'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   adddaa("${Auth().currentUser!.email}", 'All');
//                   Navigator.of(context).push(FadeRoute(page: dummylog()));
//                   /*Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => dummylog()));*/
//                 },
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.blue),
//                   padding:
//                       MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 child: Text('ALL DATA')),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   adddaa("${Auth().currentUser!.email}", 'Add');
//                   Navigator.of(context).push(FadeRoute(page: dummylog()));
//                   /* Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => dummylog()));*/
//                 },
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.blue),
//                   padding:
//                       MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 child: Text('ADD DATA')),
//             SizedBox(
//               height: 30,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   adddaa("${Auth().currentUser!.email}", 'Edit');
//                   Navigator.of(context).push(FadeRoute(page: dummylog()));
//                   /*
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => dummylog()));*/
//                 },
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.blue),
//                   padding:
//                       MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 child: Text('EDIT DATA')),
//             SizedBox(
//               height: 30,
//             ),
//             ElevatedButton(
//                 onPressed: () {},
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.blue),
//                   padding:
//                       MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 child: Text('DELETE DATA')),
//             SizedBox(
//               height: 30,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 adddaa("${Auth().currentUser!.email}", 'Consume');
//                 Navigator.of(context).push(FadeRoute(page: dummylog()));
//                 /*Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => dummylog()));*/
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                 padding:
//                     MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//               ),
//               child: Text('CONSUME DATA'),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   adddaa("${Auth().currentUser!.email}", 'Add Qty');
//                   Navigator.of(context).push(FadeRoute(page: dummylog()));
//                   /*Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => dummylog()));*/
//                 },
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.blue),
//                   padding:
//                       MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 child: Text('ADD QUANTITY')),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   adddaa("${Auth().currentUser!.email}", 'Add C');
//                   Navigator.of(context).push(FadeRoute(page: dummylog()));
//                   /*Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => dummylog()));*/
//                 },
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.blue),
//                   padding:
//                       MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 child: Text('ADD CATEGORY')),
//             SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
