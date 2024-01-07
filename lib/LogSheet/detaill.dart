import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_2/LogSheet/pages/tabpage.dart';
import 'package:flutter_application_2/authentication/Sign_Up_Page.dart';
import 'package:flutter_application_2/constants/colors.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../Constants/Decorations.dart';

Timestamp oo = Timestamp(1689343870, 60000000);
List stockItems = [];
String? emailid = '0';
Map<String, dynamic>? ra;
List tt = [];
int index = 0;

adddaa(String? selectedStock, String s) {}

class dummylog extends StatefulWidget {
  const dummylog({super.key});

  @override
  State<dummylog> createState() => _dummylogState();
}

class _dummylogState extends State<dummylog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: ref1.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 25,
                        ),
                        FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection(
                                    'All Users Data/${documentSnapshot['uid']}/operations')
                                .orderBy(
                                  "time",
                                )
                                //.where('time', isLessThan: oo)
                                .get(),
                            builder: (BuildContext context, snap) {
                              if (snap.hasData) {
                                if (true) {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    tt.clear();
                                  });
                                }
                                if (snap.data != null) {
                                  var ss = snap.data!.docs.toList();

                                  for (var Stocks in ss) {
                                    stockItems.add(
                                      Stocks.data(),
                                    );
                                  }
                                }
                              }

                              return const Text("");
                            }),
                      ],
                    );
                  });
            }
          }),
    );
  }
}

void excel_op() async {
  var format = DateFormat('hh:mm:ss a dd-MM-yyyy');
  final excel = Excel.createExcel();
  final sheet = excel[excel.getDefaultSheet()!];
//             final cellStyle = CellStyle(
//   // backgroundColorHex: Color(0xFF00FF00),
// );

  // CellStyle(backgroundColorHex:'none',fontColorHex: "");
  CellStyle color1 = CellStyle(
    //fontColorHex: "#Ffffff",
    backgroundColorHex: "#ffff00",
    fontFamily: getFontFamily(FontFamily.Calibri),
  );
  TableCell(
    child: Container(
      color: Color(0xFFFFFF00),
      alignment: Alignment.center,
      width: 20,
    ),
  );
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
      TextCellValue('Email');

  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
      TextCellValue('Operation');
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
      TextCellValue('Time');
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
      TextCellValue('Loction');
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
      TextCellValue('Category');
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
      TextCellValue('Product');
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
      TextCellValue('Quantity');
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
      TextCellValue('UID');
  for (int i = 0; i <= 7; i++) {
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
        .cellStyle = color1;
  }
  for (int i = 1; i < tt.length; i++) {
    // print({'$tt[i]'});
    //print('object');

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i)).value =
        tt[i]['email'];
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i)).value =
        tt[i]['operation'];
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i)).value =
        TextCellValue(format.format(tt[i]['time'].toDate()).toString());
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i)).value =
        tt[i]['location'];
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i)).value =
        tt[i]['category'];
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i)).value =
        tt[i]['product'];
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i)).value =
        tt[i]['quantity'];
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i)).value =
        tt[i]['uid'];
  }
  var fileBytes = excel.save();
  if (fileBytes != null) {
    final appDir = await getApplicationDocumentsDirectory();
    var datetime = DateTime.now();
    File? file = await File('${appDir.path}/$datetime.xlsx').create();
    await file.writeAsBytes(fileBytes);
    await Share.shareFiles(
      [file.path],
      mimeTypes: ["image/png"],
      text: "Share the QR Code",
    );
  }
}

class MyWidget extends StatefulWidget {
  final String operation;
  const MyWidget({
    Key? key,
    required this.operation,
  }) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool load = false;
  @override
  void initState() {
    if (true) {
      for (int i = 0; i < 10; i = i + (2)) {
        print('${i + 1} ${i + 2} ${i + 3}');
      }
    }

    setState(() {
      index = 0;
      load = true;
    });
    ttt();

    super.initState();
  }

  ttt() {
    var format = DateFormat('yyyy-MM-dd hh:mm:ss');

    tt.clear();
    for (int i = 0; i < stockItems.length; i++) {
      //DateTimeRange(start: start, end: end)

      if (DateTime.parse(
                  format.format(stockItems[i]['time'].toDate()).toString())
              .isAfter(start) &&
          DateTime.parse(
                  format.format(stockItems[i]['time'].toDate()).toString())
              .isBefore(today)) {
        if (stockItems[i]['email'] == emailid &&
            stockItems[i]['operation'] == widget.operation) {
          ////('objectss $emailid dd');
          tt.add(stockItems[i]);
        } else if (stockItems[i]['email'] == emailid &&
            widget.operation == 'All') {
          tt.add(stockItems[i]);
        } else if (emailid == '0' &&
            stockItems[i]['operation'] == widget.operation) {
          tt.add(stockItems[i]);
        } else if (emailid == '0' && widget.operation == 'All') {
          tt.add(stockItems[i]);
        }
      }
    }
    setState(() {
      load = false;
    });
    if (tt.isEmpty) {
      setState(() {
        load = true;
        index = 1;
      });
    }
  }

  //var len = stockItems.length;
  var len1 = tt.length;
  @override
  Widget build(BuildContext context) {
    colorr<color>(int i) {
      if (tt[i]['operation'] == 'Add') {
        return const Color.fromRGBO(155, 171, 180, 100);
      } else if (tt[i]['operation'] == 'Consume') {
        return const Color.fromRGBO(238, 227, 203, 100);
      } else if (tt[i]['operation'] == 'Add Qty') {
        return const Color.fromRGBO(254, 255, 134, 100);
      } else if (tt[i]['operation'] == 'Edit') {
        return const Color.fromRGBO(255, 132, 0, 100);
      } else if (tt[i]['operation'] == 'Add C') {
        return const Color.fromRGBO(153, 208, 143, 100);
      } else if (tt[i]['operation'] == 'Delete') {
        return const Color.fromARGB(156, 255, 0, 0);
      } else if (tt[i]['operation'] == 'edit C') {
        return Color.fromARGB(132, 173, 166, 102);
      } else if (tt[i]['operation'] == 'delete C') {
        return Color.fromARGB(178, 255, 35, 28);
      }
      return black;
    }

    oper(int i) {
      var format = DateFormat('dd-MM-yyyy (hh:mm:ss a )');
      if (tt[i]['operation'] == 'Add') {
        return ListTile(
          isThreeLine: true,
          title: Text(
            tt[i]['product'] + " \n" + tt[i]['email'],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(tt[i]['pic']),
            radius: 17,
          ),
          subtitle: Text(tt[i]['category'] +
              " \n" +
              tt[i]['operation'] +
              " \t" +
              format.format(tt[i]['time'].toDate()).toString()),
          trailing: SizedBox(
            width: 35,
            child: Row(
              children: [
                CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.red,
                    child: Text(
                      tt[i]['quantity'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        );
      } else if (tt[i]['operation'] == 'Consume') {
        return ListTile(
          isThreeLine: true,
          title: Text(
            tt[i]['product'] + " \n" + tt[i]['email'],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(tt[i]['pic']),
            radius: 17,
          ),
          subtitle: Text(tt[i]['category'] +
              " \n" +
              tt[i]['operation'] +
              " \t" +
              format.format(tt[i]['time'].toDate()).toString()),
          trailing: SizedBox(
            width: 78,
            child: Row(
              children: [
                CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.lightBlueAccent,
                    child: Text(
                      tt[i]['status'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.red,
                    child: Text(
                      tt[i]['quantity'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )),
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        );
      } else if (tt[i]['operation'] == 'Add Qty') {
        return ListTile(
            isThreeLine: true,
            title: Text(
              tt[i]['product'] + " \n" + tt[i]['email'],
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(tt[i]['pic']),
              radius: 17,
            ),
            subtitle: Text('${tt[i]['category']}' +
                " \n" +
                tt[i]['operation'] +
                " \t" +
                format.format(tt[i]['time'].toDate()).toString()),
            trailing: SizedBox(
              width: 35,
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.red,
                      child: Text(
                        tt[i]['quantity'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ))
                ],
              ),
            ));
      } else if (tt[i]['operation'] == 'Edit') {
        return ListTile(
            isThreeLine: true,
            title: Text(
              tt[i]['product'] + " \n" + tt[i]['email'],
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(tt[i]['pic']),
              radius: 17,
            ),
            subtitle: Text(tt[i]['category'] +
                " \n" +
                tt[i]['operation'] +
                " \t" +
                format.format(tt[i]['time'].toDate()).toString()),
            trailing: SizedBox(
              width: 35,
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.red,
                      child: Text(
                        tt[i]['quantity'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ))
                ],
              ),
            ));
      } else if (tt[i]['operation'] == 'Add C') {
        return ListTile(
          title: Text(
            tt[i]['category'] + " \n" + tt[i]['email'],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(tt[i]['pic'] ??
                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'),
            radius: 17,
          ),
          // imagee(tt[i]['pic'].toString(), tt[i]['category'].toString(), 17),
          subtitle: Text(tt[i]['operation'] +
              " \t" +
              format.format(tt[i]['time'].toDate()).toString()),
        );
      } else if (tt[i]['operation'] == 'edit C') {
        return ListTile(
          title: Text(
            tt[i]['category'] + " \n" + tt[i]['email'],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(tt[i]['pic'] ??
                'https://flutter.gskinner.com/wonderous/assets/images/logo-wonderous.svg'),
            radius: 17,
          ),
          // imagee(tt[i]['pic'].toString(), tt[i]['category'].toString(), 17),
          subtitle: Text(tt[i]['operation'] +
              " \t" +
              format.format(tt[i]['time'].toDate()).toString()),
        );
      } else if (tt[i]['operation'] == 'Delete') {
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          isThreeLine: true,
          title: Text(
            tt[i]['product'] + " \n" + tt[i]['email'],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(tt[i]['pic']),
            radius: 17,
          ),
          subtitle: Text(tt[i]['category'] +
              "\t\t" +
              tt[i]['operation'] +
              " \n" +
              format.format(tt[i]['time'].toDate()).toString()),
        );
      } else if (tt[i]['operation'] == 'delete C') {
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          isThreeLine: true,
          title: Text(
            tt[i]['product'] + " \n" + tt[i]['email'],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(tt[i]['pic'] ??
                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'),
            radius: 17,
          ),
          subtitle: Text(tt[i]['operation'] +
              " \n" +
              format.format(tt[i]['time'].toDate()).toString()),
        );
      }
    }

    setState(() {
      tt.sort((a, b) {
        return (a['time']).compareTo(b['time']);
      });
    });

    final body = [
      const Center(
          child: CircularProgressIndicator(
        color: Colors.black54,
      )),
      const Center(child: Text('No data')),
    ];
    return Scaffold(
      body: load
          ? body[index]
          : RawScrollbar(
              thumbColor: Colors.grey,
              radius: Radius.circular(16),
              thickness: 7,
              child: SingleChildScrollView(
                child: Column(children: [
                  if (tt.isNotEmpty)
                    for (int i = 0; i < tt.length; i++) ...[
                      Card(
                        // elevation: 2,
                        color: colorr(i),
                        margin: const EdgeInsets.all(8),
                        child: oper(i),
                      ),
                    ]
                ]),
              ),
            ),
    );
  }
}
