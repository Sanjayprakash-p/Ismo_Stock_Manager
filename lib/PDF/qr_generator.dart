// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/constants/Decorations.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../Scan/QRcodes.dart';

DateTime dat = DateTime.now();
List qr = [];
int n = stockItems2.length;

class qr_Pdf_gen extends StatefulWidget {
  const qr_Pdf_gen(
    List ff, {
    Key? key,
  }) : super(key: key);

  @override
  State<qr_Pdf_gen> createState() => _PdfPreview_pageState();
}

class _PdfPreview_pageState extends State<qr_Pdf_gen> {
  // @override
  // void initState() {
  //   super.initState();
  //   qr.clear();
  //   for (var i in ff) {
  //     qr.add(i['qrname']);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'P D F',
          style: headingstyle(),
        ),
        centerTitle: true,
        // backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PdfPreview(
        build: (format) => generateDocument(format),
        onPrinted: _showPrintedToast,
        allowPrinting: true,
        allowSharing: true,
        pdfFileName: 'Qr_print$dat.pdf',
        onShared: _showSharedToast,
        canChangeOrientation: false,
        canDebug: false,
        canChangePageFormat: false,
        // onPageFormatChanged: (value) {
        // print("Page Format Changed");
        // },
      ),
      backgroundColor: Colors.black,
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    const black = PdfColor(0, 0, 0);
    final font4 = await PdfGoogleFonts.albertSansExtraBold();
    // adventProExtraBold();
    // abhayaLibreExtraBold();
    final headstyle1 =
        pw.TextStyle(fontBold: font4, color: black, fontSize: 13);
    String truncateString(String input, int startChars, int endChars) {
      if (input.length <= startChars + endChars) {
        return input;
      }

      String startPart = input.substring(0, startChars);
      String endPart = input.substring(input.length - endChars);

      return '$startPart ...$endPart';
    }

    final imag = (await rootBundle.load('assets/logo_transparent.png'))
        .buffer
        .asUint8List();
    final gridItems = ff.map((item) {
      final barocode = pw.BarcodeWidget(
        // decoration: pw.BoxDecoration(image: pw.DecorationImage(image: Image)),
        barcode: Barcode.qrCode(),
        // padding: pw.EdgeInsets.all(2),
        width: 2.5 * PdfPageFormat.cm,
        height: 2.5 * PdfPageFormat.cm,
        data: item['qrname'],
      );
      return pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Column(
          // mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            barocode,
            pw.SizedBox(
                width: 2.5 * PdfPageFormat.cm,
                height: 0.1 * PdfPageFormat.cm,
                child: pw.Center(
                    child: pw.Text(truncateString(item['name'], 5, 2),
                        style: headstyle1)))
          ],
        ),
      );
    }).toList();

    final gridView = pw.GridView(
      crossAxisCount: 7,
      childAspectRatio: 1.0, // Adjust the number of columns as needed
      children: gridItems,
    );

    final doc = pw.Document(pageMode: PdfPageMode.fullscreen);
    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();

    doc.addPage(
      pw.MultiPage(
        // margin: pw.EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        maxPages: 100000,
        pageTheme: pw.PageTheme(
          // margin: pw.EdgeInsets.only(top: 8, bottom: 8),
          margin:
              const pw.EdgeInsets.only(left: 6, top: 10, bottom: 10, right: 6),
          // clip: false,
          pageFormat: format,
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Center(
              child: gridView,
            ),
          ];
        },
      ),
    );
    return doc.save();
  }

  // print pdf
  void _showPrintedToast(BuildContext context) {
    const SnackBar(
      content: Text('Document printed successfully'),
    );
  }

  // share pdf
  void _showSharedToast(BuildContext context) {
    const SnackBar(
      content: Text('Document shared successfully'),
    );
  }

  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    // PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(PdfPageFormat.a4);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File('$appDocPath/Qr_generate$dat.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }
}
