import 'package:alert_banner/types/enums.dart';
import 'package:alert_banner/widgets/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/Constants/Decorations.dart';
import 'package:flutter_application_2/Scan/scaninfo.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../PDF/All_Product_Export/all_product_expt.dart';
import '../Constants/colors.dart';
import '../CustomWidget/bottom_notification.dart';
import '../Home/Employee_Home.dart';
import '../main.dart';
import 'Add_Quantity.dart';
import 'Consume_Page.dart';
import 'package:vibration/vibration.dart';
import '../../Home/bottomnavigation.dart';

var getResult = 'category';

class scannerpg extends StatefulWidget {
  const scannerpg({super.key});
  @override
  State<scannerpg> createState() => _scannerpgState();
}

//

class _scannerpgState extends State<scannerpg> {
  // @override
  // void initState() {
  //   final qrCode = FlutterBarcodeScanner.scanBarcode(
  //       '#ff6666', 'Cancel', true, ScanMode.QR);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBody: true,
        // backgroundColor: screenbackgroundcolor,
        appBar: AppBar(
          shape: appbarshape(),
          // backgroundColor: appbarcolor,
          title: const Text("S C A N N E R"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: ElevatedButton(
                  onPressed: () async {
                    var kk = ref1
                        .doc(user!.uid)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) async {
                      if (documentSnapshot.get('addqty') == true) {
                        try {
                          final qrCode =
                              await FlutterBarcodeScanner.scanBarcode(
                                      '#ff6666', 'Cancel', true, ScanMode.QR)
                                  .whenComplete(
                                      () => Vibration.vibrate(duration: 100));

                          if (!mounted) return;

                          addqr(qrCode);
                          if (qrCode != '-1') {
                            Navigator.of(context)
                                .push(FadeRoute(page: const addqty()));
                            /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const addqty()));*/
                          }
                          // setState(() {
                          //   getResult = qrCode;
                          //   ra(qrCode);
                          // Navigator.push(
                          //     context,
                          //      MaterialPageRoute(
                          //        builder: (context) => addqty(

                          //              )));
                          // //   // MyCustomWidget();
                          //  });
                          // print("QRCode_Result:--");
                          // print(qrCode);
                        } on PlatformException {
                          getResult = 'Failed to scan QR Code.';
                        }
                      } else {
                        showAlertBanner(
                          context,
                          () => print("TAPPED"),
                          ExampleAlertBannerChild(
                            color: Colors.red,
                            text: 'Your not allowed!',
                          ),
                          alertBannerLocation: AlertBannerLocation.bottom,
                          // .. EDIT MORE FIELDS HERE ...
                        );

                        // print('Your not allowed');
                      }
                    });

                    /* if (san!.get('scan') == true) {
                      try {
                        final qrCode = await FlutterBarcodeScanner.scanBarcode(
                            '#ff6666', 'Cancel', true, ScanMode.QR);
                  
                        if (!mounted) return;
                  
                        setState(() {
                          getResult = qrCode;
                          ra(getResult);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => addqty()));
                          // MyCustomWidget();
                        });
                        print("QRCode_Result:--");
                        print(qrCode);
                      } on PlatformException {
                        getResult = 'Failed to scan QR Code.';
                      }
                    } else {
                      showAlertBanner(
                        context,
                        () => print("TAPPED"),
                        const ExampleAlertBannerChild(
                          raja: 'Your not allowed!',
                        ),
                        alertBannerLocation: AlertBannerLocation.bottom,
                        // .. EDIT MORE FIELDS HERE ...
                      );
                  
                      print('Your not allowed');
                    }*/
                  },
                  child: const Text(
                    "Add Some Quantity",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black87),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // const Text(
              //   "Otherwise",
              //   style: TextStyle(
              //       color: Colors.orangeAccent,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 16),
              // ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  var kk = ref1
                      .doc(user!.uid)
                      .get()
                      .then((DocumentSnapshot documentSnapshot) async {
                    if (documentSnapshot.get('consume') == true) {
                      try {
                        final qrCode = await FlutterBarcodeScanner.scanBarcode(
                            '#ff6666', 'Cancel', true, ScanMode.QR);

                        if (!mounted) return;
                        if (qrCode != '-1') {
                          sa(qrCode);
                          Navigator.of(context)
                              .push(FadeRoute(page: consumepg()));
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const consumepg()));*/
                        }
                        // setState(() {
                        //   getResult = qrCode;
                        //   ra(qrCode);
                        // Navigator.push(
                        //     context,
                        //      MaterialPageRoute(
                        //        builder: (context) => addqty(

                        //              )));
                        // //   // MyCustomWidget();
                        //  });
                        // print("QRCode_Result:--");
                        // print(qrCode);
                      } on PlatformException {
                        getResult = 'Failed to scan QR Code.';
                      }
                    } else {
                      showAlertBanner(
                        context,
                        () => print("TAPPED"),
                        ExampleAlertBannerChild(
                          color: Colors.red,
                          text: 'Your not allowed!',
                        ),
                        alertBannerLocation: AlertBannerLocation.bottom,
                        // .. EDIT MORE FIELDS HERE ...
                      );

                      //print('Your not allowed');
                    }
                  });
                },
                /*async {
                  try {
                    final qrCode = await FlutterBarcodeScanner.scanBarcode(
                        '#ff6666', 'Cancel', true, ScanMode.QR);
    
                    if (!mounted) return;
    
                    setState(() {
                      getOutput = qrCode;
                      sa(getOutput);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => consumepg()));
                      // MyCustomWidget();
                    });
                    print("QRCode_Result:--");
                    print(qrCode);
                  } on PlatformException {
                    getResult = 'Failed to scan QR Code.';
                  }
                },*/
                child: Text(
                  "Consume The Product",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.black87),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  var kk = ref1
                      .doc(user!.uid)
                      .get()
                      .then((DocumentSnapshot documentSnapshot) async {
                    if (documentSnapshot.get('info') == true) {
                      try {
                        final qrCode = await FlutterBarcodeScanner.scanBarcode(
                            '#ff6666', 'Cancel', true, ScanMode.QR);

                        if (!mounted) return;
                        if (qrCode != '-1') {
                          da(qrCode);
                          Navigator.of(context)
                              .push(FadeRoute(page: scaninfo()));
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const scaninfo()));*/
                        }
                        // setState(() {
                        //   getResult = qrCode;
                        //   ra(qrCode);
                        // Navigator.push(
                        //     context,
                        //      MaterialPageRoute(
                        //        builder: (context) => addqty(

                        //              )));
                        // //   // MyCustomWidget();
                        //  });
                        // print("QRCode_Result:--");
                        // print(qrCode);
                      } on PlatformException {
                        getResult = 'Failed to scan QR Code.';
                      }
                    } else {
                      showAlertBanner(
                        context,
                        () => print("TAPPED"),
                        ExampleAlertBannerChild(
                          color: Colors.red,
                          text: 'Your not allowed!',
                        ),
                        alertBannerLocation: AlertBannerLocation.bottom,
                        // .. EDIT MORE FIELDS HERE ...
                      );

                      //print('Your not allowed');
                    }
                  });
                },
                child: Text(
                  'Info',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
