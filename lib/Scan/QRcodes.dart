// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/PDF/qr_generator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Constants/Decorations.dart';
import '../main.dart';
import '../../Home/bottomnavigation.dart';

List stockItems2 = [];
List ff = [];
bool fff = false;
bool loadinnn = false;
bool hhh = false;

class QRCode extends StatefulWidget {
  const QRCode({super.key});
  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  // @override
  // void dispose() {
  //   // stockItems2.clear();
  //   // ff.clear();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    search2() async {
      ff.clear();
      var collection = FirebaseFirestore.instance.collection('Stocks');
      var snaps = await collection.get();
      for (var doc in snaps.docs) {
        var collection1 = FirebaseFirestore.instance
            .collection('Stocks')
            .doc(doc.id)
            .collection('productss');
        var snap = await collection1.get();
        for (var doc1 in snap.docs) {
          if (doc1.get('print') == true) {
            ff.add(doc1);
          }
        }
      }
      setState(() {
        loadinnn = false;
      });
    }

    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Colors.white,
          elevation: 0,
          title: Text("GENERATE QR", style: headingstyle()),
          actions: [
            IconButton(
              onPressed: () {
                if (ff.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snacks("No qr to export"));
                } else {
                  Navigator.of(context).push(FadeRoute(page: qr_Pdf_gen(ff)));
                }
              },
              icon: const Icon(
                Icons.picture_as_pdf_outlined,
                color: Colors.black87,
                size: 35,
              ),
            ),
          ],
          leading: IconButton(
              // alignment: Alignment.topLeft,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.redAccent,
                size: 30,
              )),
        ),
        body: loadinnn
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Center(
                      child: ElevatedButton(
                          style: buttonstyle(),
                          onPressed: () async {
                            setState(() {
                              loadinnn = true;
                            });
                            await search2();
                            if (ff.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snacks("No QR Code to generate"));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snacks("The QR Code's Have Been Generated"));
                            }
                          },
                          child: const Text("G E N E R A T E")),
                    ),
                    // SizedBox(
                    //   width: 110,
                    // child: ElevatedButton(
                    //   onPressed: () {},
                    //   style: buttonstyle(),
                    //   //  ElevatedButton.styleFrom(
                    //   //     backgroundColor: Colors.black87),
                    //   child: Row(
                    //     children: [
                    //       const Text(
                    //         "PDF",
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 16),
                    //       ),
                    //       IconButton(
                    //           onPressed: () {
                    //             if (ff.isEmpty) {
                    //               ScaffoldMessenger.of(context).showSnackBar(
                    //                   snacks("No qr to export"));
                    //             } else {
                    //               Navigator.of(context)
                    //                   .push(FadeRoute(page: qr_Pdf_gen(ff)));
                    //             }
                    //           },
                    //           icon: const Icon(
                    //             Icons.picture_as_pdf_outlined,
                    //             color: Colors.white,
                    //           )),
                    //     ],
                    //   ),
                    // ),
                    // ),
                    // IconButton(
                    //     onPressed: () {
                    //       if (ff.isEmpty) {
                    //         ScaffoldMessenger.of(context)
                    //             .showSnackBar(snacks("No qr to export"));
                    //       } else {
                    //         Navigator.of(context)
                    //             .push(FadeRoute(page: qr_Pdf_gen(ff)));
                    //       }
                    //     },
                    //     icon: const Icon(
                    //       Icons.picture_as_pdf_outlined,
                    //       color: Colors.white,
                    //     )),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Card()
                    for (int i = 0; i < ff.length; i++) ...[
                      InkWell(
                        onLongPress: () => setState(() {
                          ff.remove(ff[i]);
                        }),
                        child: Slidable(
                          closeOnScroll: true,
                          endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      ff.remove(ff[i]);
                                    });
                                  },
                                  icon: Icons.delete_forever,
                                  backgroundColor: Colors.red.shade200,
                                )
                              ]),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(ff[i]['dp']),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(children: [
                                    Text(
                                      "Name:" + ff[i]['name'],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Category:" + ff[i]["category"],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ]),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: QrImageView(
                                    size: 80,
                                    data: ff[i]['qrname'].toString(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    // Slidable(closeOnScroll: true,
                    // endActionPane: ActionPane(
                    //   extentRatio: 0.2,motion:const StretchMotion(),children: [
                    //   SlidableAction(onPressed: (context){},icon: Icons.delete_forever,backgroundColor: Colors.red.shade200,)
                    // ]),

                    //   child: ,),

                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: TextButton(
                            onPressed: () async {
                              setState(() {
                                loadinnn = true;
                              });

                              for (var i in ff) {
                                i.reference.update({'print': false});
                              }
                              setState(() {
                                loadinnn = false;
                              });
                              if (fff = true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snacks("The QR Code's Are Cleared"));
                                setState(() {
                                  ff.clear();

                                  fff = false;
                                });
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.refresh),
                                Text("C L E A R"),
                              ],
                            ))),
                  ])));
  }
}
