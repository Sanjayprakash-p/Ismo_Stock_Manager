// import 'dart:js';
// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import '../../Home/bottomnavigation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter_application_2/CustomWidget/snack_bar.dart';
import 'package:flutter_application_2/PDF/All_Product_Export/all_product_expt.dart';

import 'package:flutter_application_2/Constants/colors.dart';
import 'package:flutter_application_2/Zoomer/pinch_zoom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../Authentication/Authentication.dart';
import '../Constants/Decorations.dart';
import '../Image/Image_Picker.dart';
import '../PDF/pdf_gen.dart';
import '../main.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _categoryController = TextEditingController();
final TextEditingController _dateController = TextEditingController();
final TextEditingController _locationController = TextEditingController();
final TextEditingController _qtyController = TextEditingController();
final TextEditingController _mqtyController = TextEditingController();
final TextEditingController _vendornameController = TextEditingController();
final TextEditingController _vendoradressController = TextEditingController();
final TextEditingController _vendorphnoController = TextEditingController();
final TextEditingController _priceController = TextEditingController();
final TextEditingController _qr = TextEditingController();

final CollectionReference _products =
    FirebaseFirestore.instance.collection('products');
// final double height = MediaQuery.of(context).size.height;
late Size mq;

Uint8List? _image;

DocumentSnapshot? sanjay;
File? file;
final key = GlobalKey();

Future<void> raj(DocumentSnapshot? documentSnapshot) async {
  sanjay = documentSnapshot;
  if (sanjay != null) {
    _nameController.text = sanjay!.get('name');
    _categoryController.text = sanjay!.get('category');
    _dateController.text = sanjay!.get('date');
    _locationController.text = sanjay!.get('location');
    _qtyController.text = sanjay!.get('quantity');
    _mqtyController.text = sanjay!.get('mqty');
    _vendornameController.text = sanjay!.get("vendorname");
    _vendoradressController.text = sanjay!.get("address");
    _vendorphnoController.text = sanjay!.get("phoneno");
    _priceController.text = sanjay!.get("price");
    // String san = sanjay!.get('profile');
  }
}

class info extends StatefulWidget {
  info({super.key});

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
// height = MediaQuery.of(context).size;
  bool vendorr = false;
  checkvendor() {
    final User? user = Auth().currentUser;
    FirebaseFirestore.instance
        .collection('permissions')
        .doc('waiting')
        .collection('permission')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('vendor') == true) {
          setState(() {
            vendorr = false;
          });
        } else {
          setState(() {
            vendorr = true;
          });
        }
      }
    });
  }

  selectImage() async {
    Uint8List img = await pickimage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  bool visible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    checkvendor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBody: true,
        // backgroundColor: screenbackgroundcolor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Tooltip(
              message: 'Add to queue',
              child: IconButton(
                  onPressed: () {
                    sanjay!.reference.update({'print': true}).then((value) =>
                        ScaffoldMessenger.of(context).showSnackBar(snacks(
                            '${_nameController.text} has been Added to Queue')));
                  },
                  icon: const Icon(
                    Icons.add_chart_rounded,
                    color: Colors.black87,
                  )),
            ),
            Tooltip(
              message: "Generate PDF",
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(FadeRoute(
                        page: pdf_preview_page(
                      pdf: sanjay!,
                    )));
                  },
                  icon: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.black87,
                  )),
            )
          ],
          title: Text("INFO", style: headingstyle()),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.redAccent,
                size: 30,
              )),
        ),
        body: load
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.grey,
              ))
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //     IconButton(
                          //         onPressed: () {
                          //           Navigator.pop(context);
                          //         },
                          //         icon: const Icon(
                          //           Icons.close,
                          //           color: Colors.redAccent,
                          //           size: 30,
                          //         )),
                          //     SizedBox(
                          //       height: height * 0.01,
                          //     ),
                          //     Center(
                          //         child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         // SizedBox(),
                          //         Text("P R O D U C T  D E T A I L S",
                          //             style: headingstyle()),
                          //       ],
                          //     )
                          //         /* .animate(
                          //   delay: 1000.ms,
                          //   onPlay: (controller) => controller.repeat(),
                          // )
                          // .fadeIn(delay: 1.ms)*/
                          //         ),
                          //     Row(
                          //       children: [
                          //         SizedBox(
                          //           width: width * 0.8,
                          //         ),
                          //         IconButton(
                          //             onPressed: () {
                          //               Navigator.of(context).push(FadeRoute(
                          //                   page: pdf_preview_page(
                          //                 pdf: sanjay!,
                          //               )));
                          //             },
                          //             icon: Icon(Icons.picture_as_pdf)),
                          //       ],
                          //     ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PinchZoomImage(
                                        sanj: sanjay!.get('dp'));
                                  }),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(sanjay!.get('dp')),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Center(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Colors.grey[100],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 8),
                                child: Container(
                                  width: width * 0.9,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        // TextField(
                                        //   toolbarOptions: const ToolbarOptions(
                                        //     copy: false,
                                        //     selectAll: false,
                                        //     paste: false,
                                        //     cut: false,
                                        //   ),
                                        //   readOnly: true,
                                        //   style: texttt(),
                                        //   decoration: InputDecoration(
                                        //     enabledBorder: enabled1(),
                                        //     focusedBorder: focuss1(),
                                        //     labelStyle: labell(),
                                        //     labelText: 'Product Name:',
                                        //     fillColor: Colors.transparent,
                                        //     filled: true,
                                        //   ),
                                        //   controller: _nameController,
                                        // ),
                                        Text(
                                          'Product Name:',
                                          style: labell(),
                                        ),
                                        SizedBox(
                                          height: height * 0.0008,
                                        ),
                                        Text(_nameController.text,
                                            style: texttt()),
                                        SizedBox(
                                          height: height * 0.008,
                                        ),
                                        // TextField(
                                        //   readOnly: true,
                                        //   controller: _categoryController,
                                        //   style: textt(),
                                        //   decoration: InputDecoration(
                                        //     enabledBorder: enabled1(),
                                        //     focusedBorder: focuss1(),
                                        //     labelStyle: labell(),
                                        //     labelText: 'Category:',
                                        //   ),
                                        // ),
                                        Text(
                                          'Category:',
                                          style: labell(),
                                        ),
                                        SizedBox(
                                          height: height * 0.0008,
                                        ),
                                        Text(_categoryController.text,
                                            style: texttt()),

                                        SizedBox(
                                          height: height * 0.008,
                                        ),
                                        // TextField(
                                        //   readOnly: true,
                                        //   controller: _dateController,
                                        //   style: textt(),
                                        //   decoration: InputDecoration(
                                        //     enabledBorder: enabled1(),
                                        //     focusedBorder: focuss1(),
                                        //     labelStyle: labell(),
                                        //     labelText: 'Date:',
                                        //   ),
                                        // ),
                                        Text(
                                          'Date:',
                                          style: labell(),
                                        ),
                                        SizedBox(
                                          height: height * 0.0008,
                                        ),
                                        Text(_dateController.text,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade800)),
                                        SizedBox(
                                          height: height * 0.008,
                                        ),
                                        // TextField(
                                        //   readOnly: true,
                                        //   style: textt(),
                                        //   controller: _locationController,
                                        //   decoration: InputDecoration(
                                        //       enabledBorder: enabled1(),
                                        //       focusedBorder: focuss1(),
                                        //       labelText: 'Location:',
                                        //       labelStyle: labell()),
                                        // ),
                                        Text(
                                          'Location:',
                                          style: labell(),
                                        ),
                                        SizedBox(
                                          height: height * 0.0008,
                                        ),
                                        Text(_locationController.text,
                                            style: texttt()),
                                        SizedBox(
                                          height: height * 0.008,
                                        ),
                                        // TextField(
                                        //   readOnly: true,
                                        //   style: textt(),
                                        //   controller: _qtyController,
                                        //   decoration: InputDecoration(
                                        //       enabledBorder: enabled1(),
                                        //       focusedBorder: focuss1(),
                                        //       labelText: 'Quantity:',
                                        //       labelStyle: labell()),
                                        // ),
                                        Text(
                                          'Quantity:',
                                          style: labell(),
                                        ),
                                        SizedBox(
                                          height: height * 0.0008,
                                        ),
                                        Text(_qtyController.text,
                                            style: texttt()),
                                        SizedBox(
                                          height: height * 0.008,
                                        ),
                                        // TextField(
                                        //   readOnly: true,
                                        //   style: textt(),
                                        //   controller: _mqtyController,
                                        //   decoration: InputDecoration(
                                        //       enabledBorder: enabled1(),
                                        //       focusedBorder: focuss1(),
                                        //       labelText: 'Min.Qty:',
                                        //       labelStyle: labell()),
                                        // ),
                                        Text(
                                          'Min.Qty:',
                                          style: labell(),
                                        ),
                                        SizedBox(
                                          height: height * 0.0008,
                                        ),
                                        Text(_mqtyController.text,
                                            style: texttt()),
                                        SizedBox(
                                          height: height * 0.028,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.028,
                          ),
                          Center(
                            child: Text('V E N D O R  D E T A I L S',
                                style: stabletextstyle()),
                          ),
                          SizedBox(
                            height: height * 0.008,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 8),
                              child: Container(
                                width: width * 9,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height * 0.028,
                                      ),
                                      // TextField(
                                      //   obscureText: vendorr,
                                      //   readOnly: true,
                                      //   style: textt1(),
                                      //   controller: _vendornameController,
                                      //   decoration: InputDecoration(
                                      //       enabledBorder: enabled1(),
                                      //       focusedBorder: focuss1(),
                                      //       labelText: 'Vendor Name:',
                                      //       labelStyle: labell1()),
                                      // ),
                                      Text(
                                        'Vendor Name:',
                                        style: labell(),
                                      ),
                                      SizedBox(
                                        height: height * 0.0008,
                                      ),
                                      Text(_vendornameController.text,
                                          style: texttt()),
                                      SizedBox(
                                        height: height * 0.008,
                                      ),
                                      // SizedBox(
                                      //   height: height * 0.0008,
                                      // ),
                                      // TextField(
                                      //   obscureText: vendorr,
                                      //   readOnly: true,
                                      //   style: textt1(),
                                      //   controller: _vendoradressController,
                                      //   decoration: InputDecoration(
                                      //       enabledBorder: enabled1(),
                                      //       focusedBorder: focuss1(),
                                      //       labelText: 'Address:',
                                      //       labelStyle: labell1()),
                                      // ),
                                      Text(
                                        'Address:',
                                        style: labell(),
                                      ),
                                      SizedBox(
                                        height: height * 0.0008,
                                      ),
                                      Text(_vendoradressController.text,
                                          style: texttt()),
                                      SizedBox(
                                        height: height * 0.008,
                                      ),
                                      // SizedBox(
                                      //   height: height * 0.0008,
                                      // ),
                                      // TextField(
                                      //   obscureText: vendorr,
                                      //   readOnly: true,
                                      //   style: textt1(),
                                      //   controller: _vendorphnoController,
                                      //   decoration: InputDecoration(
                                      //       enabledBorder: enabled1(),
                                      //       focusedBorder: focuss1(),
                                      //       labelText: 'Phone no:',
                                      //       labelStyle: labell1()),
                                      // ),
                                      // SizedBox(
                                      //   height: height * 0.0008,
                                      // ),
                                      Text(
                                        'Phone no:',
                                        style: labell(),
                                      ),
                                      SizedBox(
                                        height: height * 0.0008,
                                      ),
                                      Text(_vendorphnoController.text,
                                          style: texttt()),
                                      SizedBox(
                                        height: height * 0.008,
                                      ),
                                      // TextField(
                                      //   obscureText: vendorr,
                                      //   readOnly: true,
                                      //   style: textt1(),
                                      //   decoration: InputDecoration(
                                      //       enabledBorder: enabled1(),
                                      //       focusedBorder: focuss1(),
                                      //       labelText: 'Unit Price:',
                                      //       labelStyle: labell1()),
                                      //   controller: _priceController,
                                      // ),
                                      Text(
                                        'Unit Price:',
                                        style: labell(),
                                      ),
                                      SizedBox(
                                        height: height * 0.0008,
                                      ),
                                      Text(_priceController.text,
                                          style: texttt()),
                                      SizedBox(
                                        height: height * 0.028,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Center(
                            child: GestureDetector(
                              onLongPress: () async {
                                await share();
                              },
                              child: Column(
                                children: [
                                  Text('Q R  C O D E',
                                      style: stabletextstyle()),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    height: 250,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      color: Colors.grey[100],
                                      child: Center(
                                        child: RepaintBoundary(
                                          key: key,
                                          child: Container(
                                            color: Colors.grey[100],
                                            child: QrImageView(
                                              size: 200,
                                              data: sanjay!
                                                  .get('qrname')
                                                  .toString(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black87),
                                      onPressed: () async {
                                        setState(() {
                                          load = true;
                                        });
                                        await share();
                                        setState(() {
                                          load = false;
                                        });
                                      },
                                      child: const Text(
                                        'Share Qr',
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                        ]))));
  }

  Future share() async {
    // File? file;
    // final key = GlobalKey();
    // RepaintBoundary(
    //     key: key,
    //     child: Container(
    //       color: Colors.grey[100],
    //       child: QrImageView(
    //         size: 100,
    //         data: sanjay!.get('qrname').toString(),
    //       ),
    //     ));

    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 20.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final appDir = await getApplicationDocumentsDirectory();
      var datetime = DateTime.now();
      file = await File('${appDir.path}/$datetime.png').create();
      await file?.writeAsBytes(pngBytes);
      await Share.shareFiles(
        [file!.path],
        mimeTypes: ["image/png"],
        text: 'Product Name:${sanjay!.get("name")}',
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // Future opend() => showDialog(
  //     context: context,
  //     builder: (context) {
  //       File? file;
  //       final key = GlobalKey();
  //       return AlertDialog(
  //         title: SizedBox(
  //             height: 248,
  //             width: 200,
  //             child: Center(
  //               child: Column(
  //                 children: [
  //                   RepaintBoundary(
  //                       key: key,
  //                       child: Center(
  //                           child: Container(
  //                               color: Colors.white,
  //                               child: QrImageView(
  //                                   size: 200,
  //                                   data: sanjay!.get('qrname').toString())))),
  //                   ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: Colors.black87),
  //                       onPressed: () async {
  //                         try {
  //                           RenderRepaintBoundary boundary = key.currentContext!
  //                               .findRenderObject() as RenderRepaintBoundary;
  //                           var image = await boundary.toImage();
  //                           ByteData? byteData = await image.toByteData(
  //                               format: ImageByteFormat.png);
  //                           Uint8List pngBytes = byteData!.buffer.asUint8List();
  //                           final appDir =
  //                               await getApplicationDocumentsDirectory();
  //                           var datetime = DateTime.now();
  //                           file = await File('${appDir.path}/$datetime.png')
  //                               .create();
  //                           await file?.writeAsBytes(pngBytes);
  //                           await Share.shareFiles(
  //                             [file!.path],
  //                             mimeTypes: ["image/png"],
  //                             text: "Share the QR Code",
  //                           );
  //                         } catch (e) {
  //                           print(e.toString());
  //                         }
  //                       },
  //                       child: const Text(
  //                         'Share',
  //                         style: TextStyle(color: Colors.white),
  //                       ))
  //                 ],
  //               ),
  //             )),
  //       );
  //     });
}
