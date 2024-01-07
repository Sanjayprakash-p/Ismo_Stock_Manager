import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/PDF/All_Product_Export/pdf_all_axport.dart';
import 'package:flutter_application_2/CustomWidget/CircleProgressIndicator%202.dart';
import '../../Constants/Decorations.dart';
import '../../Home/bottomnavigation.dart';

// import 'package:flutter_application_2/Scan/Add_Quantity.dart';

bool load = false;
List stockItems = [];
List d = [];
final Color blk = Color.fromARGB(0, 0, 0, 0);

class all_pdt_expt extends StatefulWidget {
  const all_pdt_expt({super.key});

  @override
  State<all_pdt_expt> createState() => _all_pdt_exptState();
}

class _all_pdt_exptState extends State<all_pdt_expt> {
  // var data;

  @override
  void initState() {
    load = true;
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
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return load
        ? Center(child: CircleIndicator())
        : Scaffold(
            body: RawScrollbar(
              thumbColor: Colors.grey,
              radius: Radius.circular(5),
              thickness: 8,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.12,
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 8),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text("P R O D U C T  D E T A I L S",
                                    style: stabletextstyle())),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                    width: width * 0.8,
                                    child: Text("All Products ",
                                        style: TextStyle(fontSize: 25),
                                        textAlign: TextAlign.center)),
                              ],
                            ),
                          ],
                        )),
                      )),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.7,
                      ),
                      SizedBox(
                          width: width * 0.25,
                          child: ElevatedButton(
                              style: buttonstyle(),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(FadeRoute(page: pdfalexport()));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Export',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // backgroundColor: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.00001,
                                  ),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    size: 25,
                                  )
                                ],
                              ))),
                    ],
                  ),
                  for (var data in stockItems)
                    // d.add(i);
                    // print('hiiiiii$i');
                    // print('Product name: ${data['quantity']}');
                    if (data != null)
                      // SizedBox(height: height * 0.02,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Colors.grey[100],
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 8),
                                  child: Container(
                                    width: width * 0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Product Name:'),
                                        Text(data['name']),
                                        Text('Category:'),
                                        Text(data['category']),
                                        Text('Date:'),
                                        Text(data['date']),
                                        Text("Location:"),
                                        Text(data['location']),
                                        Text('Quantity:'),
                                        Text(data['quantity']),
                                        // Text('Min.Qty:'),
                                        // Text(data['mqty']),
                                        // Text('VENDOR DETAILS'),
                                        // Text('Name:'),
                                        // Text(data['vendorname']),
                                        // Text('Phone.No:'),
                                        // Text(data['phoneno']),
                                        Text('Unit Price:'),
                                        Text(data['price']),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                      ],
                                    ),
                                  ))),
                        ],
                      ),

                  //  SizedBox(height: 20,),

                  //  for(var data in stockItems ) {
                  //   // d.add(i);
                  //   // print('hiiiiii$i');
                  //   print('Product name: ${data['quantity']}');
                  //  }
                ],
              )),
            ),
          );
  }

//   Card buildcard(){
//     return Card(
//       shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20)),
//               color: Colors.grey[100],
//               child: Padding(padding: const EdgeInsets.only(left: 10, top: 8),
//               child:Column(
//               children: [
//           Text(data['name']),
//           Text('Category:'),
//           Text(data['category']),
//           Text('Date:'),
//           Text(data['date']),
//           Text("Location:"),
//           Text(data['location']),
//           Text('Quantity:'),
//           Text(data['quantity']),
//           Text('Min.Qty:'),
//           Text(data['mqty']),
//           Text('VENDOR DETAILS'),
//           Text('Name:'),
//           Text(data['vendorname']),
//           Text('Phone.No:'),
//           Text(data['phoneno']),
//           Text('Unit Price:'),
//           Text(data['price']),
//               ],
//             ),
//               ),

//     );
//   }
}
