import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/* Your ......other important..... code here */

List exl = [];
exceling() async {
  exl.clear();

  ByteData data = await rootBundle.load('assets/document.xlsx');
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    print(table);
    print(excel.tables[table]!.maxColumns);
    print(excel.tables[table]!.maxRows);
    for (var row in excel.tables[table]!.rows) {
      exl.add((row.map((e) => e?.value)).toList());

      print("   ${((row.map((e) => e?.value)).toList())}");
      print(" nknklkk  ${exl[0][0]}");
    }
  }
}

class exceldata extends StatefulWidget {
  const exceldata({super.key});

  @override
  State<exceldata> createState() => _exceldataState();
}

class _exceldataState extends State<exceldata> {
  var excel = Excel.createExcel();
  @override
  void initState() {
    exceling();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Excel'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () async {
                exl.clear();

                ByteData data = await rootBundle.load('assets/document.xlsx');
                var bytes = data.buffer
                    .asUint8List(data.offsetInBytes, data.lengthInBytes);
                var excel = Excel.decodeBytes(bytes);

                for (var table in excel.tables.keys) {
                  print(table);
                  print(excel.tables[table]!.maxColumns);
                  print(excel.tables[table]!.maxRows);
                  for (var row in excel.tables[table]!.rows) {
                    setState(() {
                      exl.add((row.map((e) => e?.value)).toList());
                    });

                    print("   ${((row.map((e) => e?.value)).toList())}");
                    print(" nknklkk  ${exl[0][0]}");
                  }
                }

                var fileBytes = excel.save();
                if (fileBytes != null) {
                  final appDir = await getApplicationDocumentsDirectory();
                  var datetime = DateTime.now();
                  File? file =
                      await File('${appDir.path}/$datetime.xlsx').create();
                  await file.writeAsBytes(fileBytes);
                  await Share.shareFiles(
                    [file.path],
                    mimeTypes: ["image/png"],
                    text: "Share the QR Code",
                  );
                }
              },
              icon: Icon(Icons.import_export)),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('temp').snapshots(),
            builder: (context, snapshots) {
              final Stock = snapshots.data?.docs.toList();
              print('hdjdjdj${Stock?.length}');
              return Container();
            })
        /*SingleChildScrollView(
        child: Column(
          children: [
            //Text('${exl[i][j]}'),
            TextButton(
                onPressed: () async {
                  if (exl.isNotEmpty) {
                    for (int i = 0; i < exl.length; i++) {
                      print('nknklkkdkdk  ${exl.length}');
                      //for(int j=0;j<exl[i].length;j++){
                      await FirebaseFirestore.instance.collection('temp').add({
                        'email': exl[i][0].toString(),
                        'operation': exl[i][1].toString(),
                        'time': exl[i][2].toString()
                      });
                    }
                  }
                },
                child: Icon(Icons.add))
          ],
        ),
      ),*/
        );
  }
}



/*
 var excel = Excel.createExcel();
           var fileBytes = excel.save();
           if(fileBytes!=null){
             final appDir = await getApplicationDocumentsDirectory();
                  var datetime = DateTime.now();
                  File? file = await File('${appDir.path}/$datetime.xlsx').create();
                  await file.writeAsBytes(fileBytes);
                  await Share.shareFiles(
                    [file.path],
                    mimeTypes: ["image/png"],
                    text: "Share the QR Code",*/