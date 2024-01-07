// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_application_2/log/detaill.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// class PdfPreview_page extends StatefulWidget {
//   const PdfPreview_page({super.key});

//   @override
//   State<PdfPreview_page> createState() => _PdfPreview_pageState();
// }

// class _PdfPreview_pageState extends State<PdfPreview_page> {
    
//   @override
//   Widget build(BuildContext context) {
//        return PdfPreview(build: (format) => generateDocument(format),
//     onPrinted: _showPrintedToast,
//     onShared: _showSharedToast,
//     canChangeOrientation: false,
//     canDebug: false,
//     canChangePageFormat: false,
//     );
//   }
//   Future<Uint8List> generateDocument(PdfPageFormat format) async {
//     final doc = pw.Document(pageMode: PdfPageMode.outlines);


//     final font1 = await PdfGoogleFonts.openSansRegular();
//     final font2 = await PdfGoogleFonts.openSansBold();
//     // final image = await imageFromAssetBundle('assets/r2.svg');

//     // doc.addPage(MultiPage(
//     //   build: (context)=>[
//     //     builTitle(),

//     //   ]
//     // ));

//      doc.addPage(pw.MultiPage(
//       maxPages: 100,
    
//         pageTheme: pw.PageTheme(
//             pageFormat: PdfPageFormat.a4,
//           // pageFormat: format.copyWith(
//           //   marginBottom: 3,
//           //   marginLeft: 3,
//           //   marginRight: 3,
//           //   marginTop: 3,
//           // ),
//           orientation: pw.PageOrientation.portrait,
//           theme: pw.ThemeData.withFont(
//             base: font1,
//             bold: font2,
//           ),
//         ),
//         build: (pw.Context context) {
//           var formatt = DateFormat('dd-MM-yyyy hh:mm:ss a ');
//           return
//            <pw.Widget>[
//             // for(int i=0;i<10;i++)...[

//             //   //Text in pdf
//             // pw.Header(
//             //     level: 0, child: pw.Text("Hi bro",style: pw.TextStyle(fontSize: 40))),
//             // pw.Paragraph(
//             //     text:"hi"),
//             // pw.Header(level: 1, child: pw.Text(" Welcome p****",style: pw.TextStyle(fontSize: 30))),
//             // pw.Paragraph(
//             //     text:
//             //         " Sanjay",style: pw.TextStyle(fontItalic: pw.Font(),fontSize: 20)),
//             // pw.Paragraph(
//             //     text:
//             //         "hi")
//             // ],
//             pw.Container(
//         color: PdfColors.white,
//         padding:pw. EdgeInsets.all(20.0),
//         child: pw.Table(
//           border: pw.TableBorder.all(color: PdfColors.black),
//           children: [
//             pw.TableRow(
//               children: [
//               pw.Text('Email'),
//               pw.Text('operation'),
//               pw.Text('Time'),
//             ]),
//             for(int i=0;i<tt.length;i++)...[

//             pw.TableRow(children: [
//               pw.Text('${tt[i]['email']}'),
//               pw.Text('${tt[i]['operation']}       '),
//               pw.Text(formatt.format(tt[i]['time'].toDate()).toString()),
//             ])
//          ],
//          ],
//         ),
//       )
//              ];
//         },
//         ),
//      );
//     return doc.save();
//   }


//   // print pdf

//   void _showPrintedToast(BuildContext context) {
//       const SnackBar(
//         content: Text('Document printed successfully'),
//       );
//   }
//   // share pdf
//   void _showSharedToast(BuildContext context) {
//       const SnackBar(
//         content: Text('Document shared successfully'),
//     );
//   }


// }


// import 'package:flutter/material.dart';

// // External package imports
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:syncfusion_flutter_datagrid_export/export.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

// // Local import
// import 'helper/save_file_mobile.dart'
//     if (dart.library.html) 'helper/save_file_web.dart' as helper;



// /// The home page of the application which hosts the datagrid.
// class xcel extends StatefulWidget {
//   /// Creates the home page.
//   const xcel({Key? key}) : super(key: key);

//   @override
//   xcelState createState() => xcelState();
// }

// /// A state class of a [xcel] stateful widget.
// class xcelState extends State<xcel> {
//   List<Employee> _employees = <Employee>[];
//   late EmployeeDataSource _employeeDataSource;

//   final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

//   @override
//   void initState() {
//     super.initState();
//     _employees = _getEmployeeData();
//     _employeeDataSource = EmployeeDataSource(employeeData: _employees);
//   }

//   Future<void> _exportDataGridToExcel() async {
//     final Workbook workbook = _key.currentState!.exportToExcelWorkbook();

//     final List<int> bytes = workbook.saveAsStream();
//     workbook.dispose();

//     await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');
//   }

//   Future<void> _exportDataGridToPdf() async {
//     final PdfDocument document =
//         _key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true);

//     final List<int> bytes = document.saveSync();
//     await helper.saveAndLaunchFile(bytes, 'DataGrid.pdf');
//     document.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Syncfusion Flutter DataGrid Export',
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.all(12.0),
//             child: Row(
//               children: <Widget>[
//                 SizedBox(
//                   height: 40.0,
//                   width: 150.0,
//                   child: MaterialButton(
//                       color: Colors.blue,
//                       onPressed: _exportDataGridToExcel,
//                       child: const Center(
//                           child: Text(
//                         'Export to Excel',
//                         style: TextStyle(color: Colors.white),
//                       ))),
//                 ),
//                 const Padding(padding: EdgeInsets.all(20)),
//                 SizedBox(
//                   height: 40.0,
//                   width: 150.0,
//                   child: MaterialButton(
//                       color: Colors.blue,
//                       onPressed: _exportDataGridToPdf,
//                       child: const Center(
//                           child: Text(
//                         'Export to PDF',
//                         style: TextStyle(color: Colors.white),
//                       ))),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SfDataGrid(
//               key: _key,
//               source: _employeeDataSource,
//               columns: <GridColumn>[
//                 GridColumn(
//                     columnName: 'ID',
//                     label: Container(
//                         padding: const EdgeInsets.all(16.0),
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'ID',
//                         ))),
//                 GridColumn(
//                     columnName: 'Name',
//                     label: Container(
//                         padding: const EdgeInsets.all(8.0),
//                         alignment: Alignment.center,
//                         child: const Text('Name'))),
//                 GridColumn(
//                     columnName: 'Designation',
//                     label: Container(
//                         padding: const EdgeInsets.all(8.0),
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'Designation',
//                           overflow: TextOverflow.ellipsis,
//                         ))),
//                 GridColumn(
//                     columnName: 'Salary',
//                     label: Container(
//                         padding: const EdgeInsets.all(8.0),
//                         alignment: Alignment.center,
//                         child: const Text('Salary'))),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Employee> _getEmployeeData() {
//     return <Employee>[
//       Employee(10001, 'James', 'Project Lead', 20000),
//       Employee(10002, 'Kathryn', 'Manager', 30000),
//       Employee(10003, 'Lara', 'Developer', 15000),
//       Employee(10004, 'Michael', 'Designer', 15000),
//       Employee(10005, 'Martin', 'Developer', 15000),
//       Employee(10006, 'Newberry', 'Developer', 15000),
//       Employee(10007, 'Balnc', 'Developer', 15000),
//       Employee(10008, 'Perry', 'Developer', 15000),
//       Employee(10009, 'Gable', 'Developer', 15000),
//       Employee(10010, 'Grimes', 'Developer', 15000)
//     ];
//   }
// }

// /// Custom business object class which contains properties to hold the detailed
// /// information about the employee which will be rendered in datagrid.
// class Employee {
//   /// Creates the employee class with required details.
//   Employee(this.id, this.name, this.designation, this.salary);

//   /// Id of an employee.
//   final int id;

//   /// Name of an employee.
//   final String name;

//   /// Designation of an employee.
//   final String designation;

//   /// Salary of an employee.
//   final int salary;
// }

// /// An object to set the employee collection data source to the datagrid. This
// /// is used to map the employee data to the datagrid widget.
// class EmployeeDataSource extends DataGridSource {
//   /// Creates the employee data source class with required details.
//   EmployeeDataSource({required List<Employee> employeeData}) {
//     _employeeData = employeeData
//         .map<DataGridRow>((Employee e) => DataGridRow(cells: <DataGridCell>[
//               DataGridCell<int>(columnName: 'ID', value: e.id),
//               DataGridCell<String>(columnName: 'Name', value: e.name),
//               DataGridCell<String>(
//                   columnName: 'Designation', value: e.designation),
//               DataGridCell<int>(columnName: 'Salary', value: e.salary),
//             ]))
//         .toList();
//   }

//   List<DataGridRow> _employeeData = <DataGridRow>[];

//   @override
//   List<DataGridRow> get rows => _employeeData;

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((DataGridCell cell) {
//       return Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(8.0),
//         child: Text(cell.value.toString()),
//       );
//     }).toList());
//   }
// }