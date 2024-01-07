import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_2/Constants/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../Constants/Decorations.dart';
import '../Zoomer/pinch_zoom.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _categoryController = TextEditingController();

class baroce extends StatefulWidget {
  DocumentSnapshot raja;
  baroce({
    Key? key,
    required this.raja,
  }) : super(key: key);

  @override
  State<baroce> createState() => _baroceState();
}

class _baroceState extends State<baroce> {
  File? file;
  final key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.raja['name'];
    _categoryController.text = widget.raja['category'];
    return Scaffold(
        extendBody: true,
        // backgroundColor: screenbackgroundcolor,
        appBar: AppBar(
          shape: appbarshape(),
          backgroundColor: appbarcolor,
          title: const Text("Barcode"),
          centerTitle: true,
        ),
        body: Column(children: [
          const SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return PinchZoomImage(sanj: widget.raja['dp']);
                  }),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.raja['dp']),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              readOnly: true,
              style: textt(),
              decoration: InputDecoration(
                enabledBorder: enabled(),
                focusedBorder: focuss(),
                labelStyle: labell(),
                labelText: 'Name',
              ),
              controller: _nameController,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              readOnly: true,
              style: textt(),
              controller: _categoryController,
              decoration: InputDecoration(
                  enabledBorder: enabled(),
                  focusedBorder: focuss(),
                  labelText: 'Category',
                  labelStyle: labell()),
            ),
          ),
          const SizedBox(height: 20),
          Center(
              child: Container(
                  color: barcodebackcolor,
                  child: QrImageView(
                    size: 200,
                    data: widget.raja['qrname'],
                  ))),
          ElevatedButton(
              style: buttonstyle(),
              onPressed: () async {
                try {
                  RenderRepaintBoundary boundary = key.currentContext!
                      .findRenderObject() as RenderRepaintBoundary;
                  var image = await boundary.toImage();
                  ByteData? byteData =
                      await image.toByteData(format: ImageByteFormat.png);
                  Uint8List pngBytes = byteData!.buffer.asUint8List();
                  final appDir = await getApplicationDocumentsDirectory();
                  var datetime = DateTime.now();
                  file = await File('${appDir.path}/$datetime.png').create();
                  await file?.writeAsBytes(pngBytes);
                  await Share.shareFiles(
                    [file!.path],
                    mimeTypes: ["image/png"],
                    text: "Share the QR Code",
                  );
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Text(
                'Share',
                style: buttontextstyle(),
              ))
        ]));
  }
}
