// import 'dart:io';
// // import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart';


// class excel_epo extends StatefulWidget {
//   const excel_epo({super.key});
  

//   @override
//   State<excel_epo> createState() => _excel_epoState();
// }

// class _excel_epoState extends State<excel_epo> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//     body: Center(child: ElevatedButton(onPressed: createExcel, child: Text('data')),),

//     );
    
//   }
//     Future<void> createExcel() async {
//     final Workbook workbook = Workbook();
//     final Worksheet sheet = workbook.worksheets[0];
//     sheet.getRangeByName('A1').setText('hello world');
//     final List<int> bytes = workbook.saveAsStream();
//     workbook.dispose();

//     final String path =(await getApplicationSupportDirectory()).path;
//     final String filename = '$path/output.xlsx';
//     final File file = File(filename);
//     await file.writeAsBytes(bytes,flush: true);
//     // await Share.shareFiles(
//     //                 [file.path],
//     //                 mimeTypes: ["image/png"],
//     //                 text: "Share the QR Code",
//     //               );
//     OpenFile.open(filename);
//     }
  
// }
