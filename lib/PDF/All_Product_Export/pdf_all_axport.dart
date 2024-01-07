// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter_application_2/PDF/All_Product_Export/all_product_expt.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/CustomWidget/CircleProgressIndicator%202.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class pdfalexport extends StatefulWidget {
  // DocumentSnapshot pdf;
   pdfalexport({
    Key? key,
    // required this.pdf,
  }) : super(key: key);

  @override
  State<pdfalexport> createState() => pdfalexportState();
}

class pdfalexportState extends State<pdfalexport> {
   @override
  void dispose() {
    stockItems.clear();
    super.dispose();
  }
  var e = DateTime.now();
  @override
  Widget build(BuildContext context) {
       return Scaffold(appBar: AppBar(),
       body: 
        PdfPreview(
          build: (format) => generateDocument(format),
    onPrinted: _showPrintedToast,
    allowPrinting: true, 
    allowSharing: true,
    pdfFileName: 'document$e.pdf',
    onShared: _showSharedToast,
    canChangeOrientation: false,
    canDebug: false,
    canChangePageFormat: false,
    loadingWidget:const CircleIndicator(),
    ));
  }
  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    final font3 = await PdfGoogleFonts.openSansMedium();
    final image = (await rootBundle.load('assets/logo_transparent.png')).buffer.asUint8List();
    final black = await PdfColor(0,0,0);
    // final red = await PdfColor(1,0,0);
    // final green = await PdfColor(0,1,0);
    final grey = await PdfColor(1,1,1);
    final headstyle = await pw.TextStyle(fontBold: font1,fontSize: 22,color: PdfColor(1,0.5,0));
    final headstyle1 = await pw.TextStyle(fontBold: font2,fontSize: 18,color: black);
    // final dividedot = await pw.BorderStyle.dotted;
    // final aligncenter = await pw.TextAlign.center;
      final alignleft = await pw.TextAlign.left;
      final labeltxt = await pw.TextStyle(fontBold: font2,fontSize: 10,color: black);
    //img
      // final netimg = await networkImage("${stockItems[i]['dp']}");
     doc.addPage(pw.MultiPage(
      maxPages: 10000,
        pageTheme: pw.PageTheme(
          margin: pw.EdgeInsets.only(left: 6,top: 10),
            pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (pw.Context context) {
          return
           <pw.Widget>[
              // pw.Stack(
                // alignment: pw.Alignment.center,
                // children: [
                  ///// water mark image
      // pw.Container(
      //               child: pw.Column(
      //               children: [
      //                    pw.Opacity(opacity: 0.09,
      //             child:pw.Container(
      //               alignment:pw.Alignment.center,
      //         child:
      //          pw.Image(pw.MemoryImage(image),
      //         width:150.000 ,
      //         height:500.00 ,
      //         fit: pw.BoxFit.cover,
      //       ),
      //     ),
      //             ),
      //             pw.SizedBox(height: 0.5*PdfPageFormat.cm),
      //             ]
      //             )
      // ),
                  //////
      pw.Container(
        decoration: pw.BoxDecoration(borderRadius: pw.BorderRadius.circular(20),color:grey ),
            child:pw.Column(
              // mainAxisAlignment:pw.MainAxisAlignment.start,
              children: [
                      pw.Container(
                        child:pw.Text('PRODUCT DETAILS',style: headstyle,textAlign:pw.TextAlign.center), ),
            pw.SizedBox(height: 0.5*PdfPageFormat.cm),

             for(var i=0;i<stockItems.length;i++ )...[
              // final net = 
            pw.SizedBox(height: 0.03*PdfPageFormat.inch),
            pw.Text('Product Name:',style:labeltxt,textAlign: alignleft),
            pw.Text('${stockItems[i]['name']}',style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text('Category:',style:labeltxt,textAlign: alignleft),
            pw.Text('${stockItems[i]['category']}',style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text('Date:',style:labeltxt,textAlign: alignleft),
            pw.Text('${stockItems[i]['date']}',style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text("Location:",style:labeltxt,textAlign: alignleft),
            pw.Text('${stockItems[i]['location']}',style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text('Quantity:',style:labeltxt,textAlign: alignleft),
            pw.Text('${stockItems[i]['quantity']}',style:headstyle1,textAlign: alignleft),
            pw.Text('Unit Price:',style:labeltxt,textAlign: alignleft),
            pw.Text('${stockItems[i]['price']}',style: headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.SizedBox(height: 0.5*PdfPageFormat.cm),
            pw.Divider(thickness: 0.2),
            pw.SizedBox(height: 2*PdfPageFormat.cm),
             ]
        ],
        ),
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



}