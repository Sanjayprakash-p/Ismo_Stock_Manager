// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:typed_data';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/CustomWidget/CircleProgressIndicator%202.dart';
// import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class pdf_preview_page extends StatefulWidget {
  DocumentSnapshot pdf;
   pdf_preview_page({
    Key? key,
    required this.pdf,
  }) : super(key: key);

  @override
  State<pdf_preview_page> createState() => _PdfPreview_pageState();
}

class _PdfPreview_pageState extends State<pdf_preview_page> {
//  DocumentSnapshot? pdf = pwdf;
 var name;
 var category;
 var date;
 var location;
 var qty;
 var mqty;
 var vendorname;
 var vendoradress;
 var vendorphno;
 var price;
 var san;
 var img;
//  var for(format.format(date));

  @override
  void initState() {
    setState(() {
   name = widget.pdf.get('name');
   category= widget.pdf.get('category');
   date = widget.pdf.get('date');
   location = widget.pdf.get('location');
   qty= widget.pdf.get('quantity');
   mqty = widget.pdf.get('mqty');
   vendorname= widget.pdf.get("vendorname");
   vendoradress= widget.pdf.get("address");
   vendorphno= widget.pdf.get("phoneno");
   price= widget.pdf.get("price");
   san = widget.pdf.get('qrname');
   img = widget.pdf.get('dp');
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
       return Scaffold(appBar: AppBar(),body: 
        PdfPreview(
          build: (format) => generateDocument(format),
    onPrinted: _showPrintedToast,
    allowPrinting: true, 
    allowSharing: true,
    pdfFileName: '$name.pdf',
    onShared: _showSharedToast,
    canChangeOrientation: false,
    canDebug: false,
    canChangePageFormat: false,
    // pages: const [],
    loadingWidget:const CircleIndicator(),
    ));
  }
  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    // final font3 = await PdfGoogleFonts.openSansMedium();
    final image = (await rootBundle.load('assets/logo_transparent.png')).buffer.asUint8List();
    final black = await PdfColor(0,0,0);
    // final red = await PdfColor(1,0,0);
    // final green = await PdfColor(0,1,0);
    // final blue = await PdfColor(0,0,1);
    final headstyle = await pw.TextStyle(fontBold: font1,fontSize: 22,color: PdfColor(1,0.5,0));
    final headstyle1 = await pw.TextStyle(fontBold: font2,fontSize: 18,color: black);
    // final dividedot = await pw.BorderStyle.dotted;
    // final aligncenter = await pw.TextAlign.center;
      final alignleft = await pw.TextAlign.left;
      final labeltxt = await pw.TextStyle(fontBold: font2,fontSize: 10,color: black);
      final netimg = await networkImage(img);
     doc.addPage(pw.MultiPage(
      // margin: mar,
      maxPages: 100000,
        pageTheme: pw.PageTheme(
          margin:pw. EdgeInsets.only(top: 0.2*PdfPageFormat.cm,bottom: 0.2*PdfPageFormat.cm,left: 0.2*PdfPageFormat.cm,right: 0.2*PdfPageFormat.cm),
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
              pw.Stack(
                alignment: pw.Alignment.center,
                children: [
                  ///// image
                  pw.Container(
                    child: pw.Column(
                    children: [
                         pw.Opacity(opacity: 0.09,
                  child:pw.Container(
                    alignment:pw.Alignment.center,
              child:
               pw.Image(pw.MemoryImage(image),
              width:150.000 ,
              height:500.00 ,
              fit: pw.BoxFit.cover,
            ),
              ),
                  ),
                  pw.SizedBox(height: 1*PdfPageFormat.cm),
                  ]
                  )
                  ),
                  //////
                  pw.Container(
                    child:pw.Column(children: [
                      pw.Container(
                        child:pw.Text('PRODUCT DETAILS',style: headstyle,textAlign:pw.TextAlign.center), ),
            pw.SizedBox(height: 0.5*PdfPageFormat.cm),
            //  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            //   children: [
                 pw.Container(
                  decoration: pw.BoxDecoration(borderRadius:pw.BorderRadius.circular(20.0),),
                        alignment: pw.Alignment.center,
                        child:pw.Image(netimg,
                        height: 4*PdfPageFormat.cm,width: 4*PdfPageFormat.cm,fit: pw.BoxFit.cover,
                        ),
                        ),
                
            // ]),
            pw.SizedBox(height: 0.3*PdfPageFormat.inch),
            pw.Text('Product Name:',style:labeltxt,textAlign: alignleft),
            pw.Text(name,style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text('Category:',style:labeltxt,textAlign: alignleft),
            pw.Text(category,style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text('Date:',style:labeltxt,textAlign: alignleft),
            pw.Text(date,style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text("Location:",style:labeltxt,textAlign: alignleft),
            pw.Text(location,style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text('Quantity:',style:labeltxt,textAlign: alignleft),
            pw.Text(qty,style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text('Min.Qty:',style:labeltxt,textAlign: alignleft),
            pw.Text(mqty,style:headstyle1,textAlign: alignleft),
            pw.Divider(thickness: 0.5),
            pw.Container(alignment: pw.Alignment.center,
            child: pw.Text('VENDOR DETAILS',style: pw.TextStyle(fontBold: font1,fontSize: 25,color:PdfColor(1,0.5,0) ),textAlign: alignleft),
            ),
            // pw.Divider(),
            pw.Text('Name:',style:labeltxt,textAlign: alignleft),
            pw.Text(vendorname,style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text('Phone.No:',style:labeltxt,textAlign: alignleft),
            pw.Text(vendorphno,style:headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.Text('Unit Price:',style:labeltxt,textAlign: alignleft),
            pw.Text(price,style: headstyle1,textAlign: alignleft),
            // pw.Divider(thickness: 0.5),
            pw.SizedBox(height: 0.5*PdfPageFormat.cm),
             pw.Container(alignment: pw.Alignment.center,width: 4*PdfPageFormat.cm,height: 4*PdfPageFormat.cm,child:pw.BarcodeWidget(barcode: Barcode.qrCode(),
              data: san,
          ),
        ),
        ],
        ),
        ),
                ],
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