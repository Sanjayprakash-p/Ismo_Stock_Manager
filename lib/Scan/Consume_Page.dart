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
final TextEditingController _mqtyController = TextEditingController();
final TextEditingController pic = TextEditingController();
bool visible = false;
DocumentSnapshot? sanjay;

List stockItems = [];
int quantity = 0;

String? pick;
Future<void> sa(String getOutput) async {
  pick = await getOutput;
}

class consumepg extends StatefulWidget {
  const consumepg({super.key});

  @override
  State<consumepg> createState() => _consumepgState();
}

class _consumepgState extends State<consumepg> {
  int _selectednum = 0;
  final _log = FirebaseFirestore.instance.collection('All Users Data');
  final _products = FirebaseFirestore.instance.collection('Stocks');

  bool? _checkBox1 = true;
  bool? _checkBox2 = false;
  var datee = DateTime.now();

  var status;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      // backgroundColor: screenbackgroundcolor,
      body: StreamBuilder(
          stream: _products.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return Column(
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
                                  for (var data in ss) {
                                    stockItems.add(
                                      data.data(),
                                    );
                                    DocumentSnapshot sun = snap
                                        .data!.docs[snap.data!.docs.length - 1];
                                    if (data['qrname'] == pick) {
                                      _nameController.text = data['name'];
                                      _categoryController.text =
                                          data['category'];
                                      _qtyController.text = data['quantity'];
                                      _mqtyController.text = data['mqty'];
                                      quantity = int.parse(data['quantity']);
                                      pic.text = data['dp'];
                                      return Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 45,
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: const Icon(
                                                            Icons.arrow_back)),
                                                    Text(
                                                      " C O N S U M E  P R O D U C T ",
                                                      style: headingstyle(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () => showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return PinchZoomImage(
                                                            sanj: pic.text);
                                                      }),
                                                  child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage:
                                                        NetworkImage(pic.text),
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
                                                              enabledadd(),
                                                          focusedBorder:
                                                              focussadd(),
                                                          errorBorder:
                                                              errorborderadd(),
                                                          focusedErrorBorder:
                                                              errorfocusadd(),
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
                                                              enabledadd(),
                                                          focusedBorder:
                                                              focussadd(),
                                                          errorBorder:
                                                              errorborderadd(),
                                                          focusedErrorBorder:
                                                              errorfocusadd(),
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
                                                        style: textt(),
                                                        controller:
                                                            _qtyController,
                                                        decoration: InputDecoration(
                                                            enabledBorder:
                                                                enabledadd(),
                                                            focusedBorder:
                                                                focussadd(),
                                                            errorBorder:
                                                                errorborderadd(),
                                                            focusedErrorBorder:
                                                                errorfocusadd(),
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
                                                              enabledadd(),
                                                          focusedBorder:
                                                              focussadd(),
                                                          errorBorder:
                                                              errorborderadd(),
                                                          focusedErrorBorder:
                                                              errorfocusadd(),
                                                          labelText: 'Min.Qty:',
                                                          labelStyle: labell(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 100),
                                                  child: CheckboxListTile(
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: Text(
                                                        'Non-Returnable',
                                                        style: TextStyle(
                                                            color:
                                                                checkboxtextcolor),
                                                      ),
                                                      activeColor:
                                                          checkboxtickbackcolor,
                                                      checkColor:
                                                          checkboxtickcolor,
                                                      shape:
                                                          checkboxtileshape(),
                                                      splashRadius:
                                                          checkboxsplash(),
                                                      checkboxShape:
                                                          checkboxshape(),
                                                      value: _checkBox1,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _checkBox1 = value;
                                                          if (value == true) {
                                                            setState(() {
                                                              _checkBox2 =
                                                                  false;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              _checkBox2 = true;
                                                            });
                                                          }
                                                        });
                                                      })),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 100),
                                                child: CheckboxListTile(
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(
                                                    'Returnable',
                                                    style: TextStyle(
                                                        color:
                                                            checkboxtextcolor),
                                                  ),
                                                  value: _checkBox2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _checkBox2 = value;
                                                      if (value == true) {
                                                        setState(() {
                                                          _checkBox1 = false;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          _checkBox1 = true;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  activeColor:
                                                      checkboxtickbackcolor,
                                                  checkColor: checkboxtickcolor,
                                                  shape: checkboxtileshape(),
                                                  splashRadius:
                                                      checkboxsplash(),
                                                  checkboxShape:
                                                      checkboxshape(),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: buttonstyle(),
                                                child: Text(
                                                  'Value = $_selectednum',
                                                  style: buttontextstyle(),
                                                ),
                                                onPressed: () =>
                                                    showModalBottomSheet(
                                                  backgroundColor: Colors.white,
                                                  enableDrag: true,
                                                  showDragHandle: true,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
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
                                                                  i <= quantity;
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
                                                  setState(() {
                                                    if (_checkBox1 == true) {
                                                      status = 'NR';
                                                    } else if (_checkBox2 ==
                                                        true) {
                                                      status = 'R';
                                                    }
                                                    int newqty = int.parse(
                                                        _qtyController.text);
                                                    int change =
                                                        newqty - _selectednum;
                                                    _qtyController.text =
                                                        change.toString();
                                                  });
                                                  final quantity =
                                                      _qtyController.text;
                                                  final product =
                                                      _nameController.text;
                                                  final category =
                                                      _categoryController.text;
                                                  {
                                                    await _products
                                                        .doc(_categoryController
                                                            .text)
                                                        .collection('productss')
                                                        .doc(data.id)
                                                        .update({
                                                      "quantity": quantity
                                                    });
                                                    await _log
                                                        .doc(user!.uid)
                                                        .collection(
                                                            'operations')
                                                        .add({
                                                      'product':
                                                          data.get('name'),
                                                      'uid': user!.uid,
                                                      'email': user!.email,
                                                      'time': datee,
                                                      "quantity": _selectednum
                                                          .toString(),
                                                      "category":
                                                          data.get('category'),
                                                      "operation": 'Consume',
                                                      "status": status,
                                                      "pic": data.get('dp'),
                                                    }).then((value) => {
                                                              setState(() {
                                                                _qtyController
                                                                        .text =
                                                                    data[
                                                                        'quantity'];
                                                              }),
                                                              _qtyController
                                                                  .text = '',
                                                              Navigator.pop(
                                                                  context),
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snacks(
                                                                          "$_selectednum Units Of ${data.get('name')} Has Been Consumed "))
                                                            });
                                                  }
                                                },
                                                style: buttonstyle(),
                                                child: Text(
                                                  "Consume The Product",
                                                  style: buttontextstyle(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  return const Text("");
                                }
                              }

                              return Container();
                            }),
                      ],
                    );
                  });
            }
          }),
    );
  }
}
