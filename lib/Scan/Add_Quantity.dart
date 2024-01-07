// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Constants/colors.dart';
import '../Home/Employee_Home.dart';
import '../Zoomer/pinch_zoom.dart';
import '../constants/Decorations.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _categoryController = TextEditingController();
final TextEditingController _qtyController = TextEditingController();
final TextEditingController _dateController = TextEditingController();
final TextEditingController _vendornameController = TextEditingController();
final TextEditingController _vendoradressController = TextEditingController();
final TextEditingController _vendorphnoController = TextEditingController();
final TextEditingController _priceController = TextEditingController();
final TextEditingController _mqtyController = TextEditingController();

DocumentSnapshot? sanjay;
List stockItems = [];
int quantity = 0;
final _formkey2 = GlobalKey<FormState>();
String? get;
Future<void> addqr(String getresult) async {
  get = await getresult;
}

class addqty extends StatefulWidget {
  const addqty({super.key});

  @override
  State<addqty> createState() => _addqtyState();
}

class _addqtyState extends State<addqty> {
  final _products = FirebaseFirestore.instance.collection('Stocks');
  final _analysis = FirebaseFirestore.instance.collection('Analysis');
  final _log = FirebaseFirestore.instance.collection('All Users Data');
  var datee = DateTime.now();
  int _selectednum = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      // backgroundColor: screenbackgroundcolor,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        bottomOpacity: 0.5,
        title: Text(
          'A D D  Q U A N T I T Y',
          style: headingstyle(),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              size: 35,
              color: red,
            )),
      ),
      body: StreamBuilder(
          stream: _products.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection(
                                      'Stocks/${documentSnapshot['Category']}/productss')
                                  .get(),
                              builder: (BuildContext context, snap) {
                                if (snap.hasData) {
                                  if (snap.data != null) {
                                    var ss = snap.data!.docs.toList();
                                    //print('result of ss=$ss');
                                    for (var data in ss) {
                                      stockItems.add(
                                        data.data(),
                                      );
                                      DocumentSnapshot sun = snap.data!
                                          .docs[snap.data!.docs.length - 1];
                                      if (data['qrname'] == get) {
                                        _nameController.text = data['name'];
                                        _categoryController.text =
                                            data['category'];
                                        _qtyController.text = data['quantity'];
                                        _dateController.text = datee.toString();
                                        _vendornameController.text =
                                            data["vendorname"];
                                        _vendoradressController.text =
                                            data["address"];
                                        _vendorphnoController.text =
                                            data["phoneno"];
                                        _priceController.text = data["price"];
                                        _mqtyController.text = data["mqty"];

                                        quantity = int.parse(data['quantity']);

                                        return Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () => showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return PinchZoomImage(
                                                            sanj: data['dp']);
                                                      }),
                                                  child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            data['dp']),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                color: Colors.grey[100],
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 8),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                        height: 18,
                                                      ),
                                                      TextField(
                                                        readOnly: true,
                                                        style: textt(),
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              enabled1(),
                                                          focusedBorder:
                                                              focuss1(),
                                                          labelStyle: labell(),
                                                          labelText:
                                                              'Product Name:',
                                                          fillColor: Colors
                                                              .transparent,
                                                          filled: true,
                                                        ),
                                                        controller:
                                                            _nameController,
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.0008,
                                                      ),
                                                      TextField(
                                                        readOnly: true,
                                                        controller:
                                                            _categoryController,
                                                        style: textt(),
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              enabled1(),
                                                          focusedBorder:
                                                              focuss1(),
                                                          labelStyle: labell(),
                                                          labelText:
                                                              'Category:',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.0008,
                                                      ),
                                                      TextField(
                                                        readOnly: true,
                                                        controller:
                                                            _dateController,
                                                        style: textt(),
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              enabled1(),
                                                          focusedBorder:
                                                              focuss1(),
                                                          labelStyle: labell(),
                                                          labelText: 'Date:',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.0008,
                                                      ),
                                                      TextField(
                                                        readOnly: true,
                                                        style: textt(),
                                                        controller:
                                                            _qtyController,
                                                        decoration:
                                                            InputDecoration(
                                                                enabledBorder:
                                                                    enabled1(),
                                                                focusedBorder:
                                                                    focuss1(),
                                                                labelText:
                                                                    'Quantity:',
                                                                labelStyle:
                                                                    labell()),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.0008,
                                                      ),
                                                      TextField(
                                                        readOnly: true,
                                                        style: textt(),
                                                        controller:
                                                            _mqtyController,
                                                        decoration:
                                                            InputDecoration(
                                                                enabledBorder:
                                                                    enabled1(),
                                                                focusedBorder:
                                                                    focuss1(),
                                                                labelText:
                                                                    'Min.Qty:',
                                                                labelStyle:
                                                                    labell()),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.08,
                                              ),
                                              Text(
                                                'V E N D O R  D E T A I L S',
                                                style: stabletextstyle(),
                                              ),
                                              SizedBox(
                                                height: height * 0.008,
                                              ),
                                              TextField(
                                                style: textt(),
                                                controller:
                                                    _vendornameController,
                                                decoration: InputDecoration(
                                                    enabledBorder: enabledadd(),
                                                    focusedBorder: focussadd(),
                                                    errorBorder:
                                                        errorborderadd(),
                                                    focusedErrorBorder:
                                                        errorfocusadd(),
                                                    labelText: 'Vendor Name',
                                                    labelStyle: labelladd()),
                                              ),
                                              SizedBox(
                                                height: height * 0.0008,
                                              ),
                                              TextField(
                                                style: textt(),
                                                controller:
                                                    _vendoradressController,
                                                decoration: InputDecoration(
                                                  enabledBorder: enabledadd(),
                                                  focusedBorder: focussadd(),
                                                  errorBorder: errorborderadd(),
                                                  focusedErrorBorder:
                                                      errorfocusadd(),
                                                  labelText: 'Address',
                                                  labelStyle: labell(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.0008,
                                              ),
                                              TextField(
                                                style: textt(),
                                                controller:
                                                    _vendorphnoController,
                                                decoration: InputDecoration(
                                                  enabledBorder: enabledadd(),
                                                  focusedBorder: focussadd(),
                                                  errorBorder: errorborderadd(),
                                                  focusedErrorBorder:
                                                      errorfocusadd(),
                                                  labelText: 'Phone no:',
                                                  labelStyle: labell(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.0008,
                                              ),
                                              Form(
                                                key: _formkey2,
                                                child: TextFormField(
                                                  style: textt(),
                                                  decoration: InputDecoration(
                                                    enabledBorder: enabledadd(),
                                                    focusedBorder: focussadd(),
                                                    errorBorder:
                                                        errorborderadd(),
                                                    focusedErrorBorder:
                                                        errorfocusadd(),
                                                    labelText: 'Price',
                                                    labelStyle: labell(),
                                                  ),
                                                  controller: _priceController,
                                                  validator: (value) {
                                                    if (_selectednum == 0) {
                                                      return 'Please enter valid number';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.008,
                                              ),
                                              ElevatedButton(
                                                style: buttonstyle(),
                                                child: Text(
                                                  'Value = $_selectednum',
                                                  style: buttontextstyle(),
                                                ),
                                                onPressed: () =>
                                                    showModalBottomSheet(
                                                  useSafeArea: false,
                                                  enableDrag: true,
                                                  showDragHandle: true,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  context: context,
                                                  builder: (_) =>
                                                      // Column(
                                                      // children: [
                                                      SizedBox(
                                                    width: width * 1,
                                                    height: height * 1,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child:
                                                              CupertinoPicker(
                                                            useMagnifier: true,
                                                            offAxisFraction:
                                                                0.1,
                                                            looping: false,
                                                            selectionOverlay:
                                                                const CupertinoPickerDefaultSelectionOverlay(
                                                              background: Colors
                                                                  .white30,
                                                              capEndEdge: true,
                                                              capStartEdge:
                                                                  true,
                                                            ),
                                                            backgroundColor:
                                                                scrollercolor,
                                                            itemExtent: 100,
                                                            scrollController:
                                                                FixedExtentScrollController(
                                                              initialItem: 1,
                                                            ),
                                                            onSelectedItemChanged:
                                                                ((value) {
                                                              setState(() {
                                                                _selectednum =
                                                                    value;
                                                              });
                                                            }),
                                                            children: [
                                                              for (int i = 0;
                                                                  i <= 10000;
                                                                  i++) ...[
                                                                Text('$i'),
                                                              ],
                                                            ],
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          style: buttonstyle(),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'Done',
                                                            style:
                                                                buttontextstyle(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.008,
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  if (_formkey2.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      int newqty = int.parse(
                                                          _qtyController.text);
                                                      int change =
                                                          newqty + _selectednum;
                                                      _qtyController.text =
                                                          change.toString();
                                                    });
                                                    final quantity =
                                                        _qtyController.text;
                                                    final date =
                                                        _dateController.text;
                                                    final Vendorname =
                                                        _vendornameController
                                                            .text;
                                                    final address =
                                                        _vendoradressController
                                                            .text;
                                                    final phno =
                                                        _vendorphnoController
                                                            .text;
                                                    final price =
                                                        _priceController.text;

                                                    await _analysis
                                                        .doc(_nameController
                                                            .text)
                                                        .collection(
                                                            _nameController
                                                                .text)
                                                        .add({
                                                      "quantity": quantity,
                                                      "date": date,
                                                      "vendorname": Vendorname,
                                                      "address": address,
                                                      "phoneno": phno,
                                                      "price": price,
                                                    });
                                                    await _log
                                                        .doc(user!.uid)
                                                        .collection(
                                                            'operations')
                                                        .add({
                                                      'product':
                                                          _nameController.text,
                                                      'uid': user!.uid,
                                                      'email': user!.email,
                                                      'time': datee,
                                                      "vendorname": Vendorname,
                                                      "address": address,
                                                      "phoneno": phno,
                                                      "price": price,
                                                      "quantity": _selectednum
                                                          .toString(),
                                                      "category":
                                                          _categoryController
                                                              .text,
                                                      "operation": 'Add Qty',
                                                      'pic': data["dp"],
                                                    });
                                                    await data.reference
                                                        .update({
                                                      "quantity": quantity,
                                                      "date": date,
                                                      "vendorname": Vendorname,
                                                      "address": address,
                                                      "phoneno": phno,
                                                      "price": price,
                                                    }).then((value) {
                                                      _qtyController.text = '';
                                                      _dateController.text = '';
                                                      _vendornameController
                                                          .text = '';
                                                      _vendoradressController
                                                          .text = '';
                                                      _vendorphnoController
                                                          .text = '';
                                                      _priceController.text =
                                                          '';
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(snacks(
                                                              "$_selectednum Units Of ${_nameController.text} Has Been Updated"));
                                                    });
                                                  }
                                                },
                                                style: buttonstyle(),
                                                child: Text(
                                                  "Modify The Details",
                                                  style: buttontextstyle(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // ),
                                        );
                                      }
                                    }
                                  } else {
                                    return const Text("");
                                  }
                                }

                                return Container();
                              })
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
