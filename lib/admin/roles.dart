import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Constants/colors.dart';
import '../constants/Decorations.dart';

final rolex = FirebaseFirestore.instance
    .collection('permissions')
    .doc('waiting')
    .collection('rolex');

class Roles extends StatefulWidget {
  const Roles({super.key});

  @override
  State<Roles> createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  String? _currentItemSelected;
  bool? _checkBox = false;
  bool? _checkBox1 = false;
  bool? _checkBox2 = false;
  bool? _checkBox3 = false;
  bool? _checkBox4 = false;
  bool? _checkBox5 = false;
  bool? _checkBox6 = false;
  bool? _checkBox7 = false;
  bool? _checkBox8 = false;
  bool? _checkBox9 = false;
  bool? _checkBox0 = false;
  final TextEditingController _roleController = TextEditingController();
  final _formkey3 = GlobalKey<FormState>();
  bool dele = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        // backgroundColor: screenbackgroundcolor,
        appBar: AppBar(
          shape: appbarshape(),
          // backgroundColor: appbarcolor,
          title: const Text("R O L E S"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: fabbackcolor,
            splashColor: fabsplashcolor,
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext ctx) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 20,
                          right: 20,
                          left: 20,
                          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                      child: Form(
                        key: _formkey3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "Create Role",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              cursorColor: cursorcolor,
                              style: textt(),
                              controller: _roleController,
                              decoration: InputDecoration(
                                  enabledBorder: enabled(),
                                  focusedBorder: focuss(),
                                  labelText: 'Assign Role',
                                  labelStyle: labell()),
                              validator: (_roleController) {
                                if (_roleController!.isEmpty) {
                                  return "Enter Role";
                                }
                                return null;
                              },
                            ),
                            Center(
                              child: ElevatedButton(
                                  style: buttonstyle(),
                                  onPressed: () async {
                                    if (_formkey3.currentState!.validate()) {
                                      await rolex
                                          .doc(_roleController.text)
                                          .set({
                                        'role': _roleController.text,
                                        'addc': false,
                                        'add': false,
                                        'edit': false,
                                        'info': false,
                                        'addqty': false,
                                        'consume': false,
                                        'qr': false,
                                        'delete': false,
                                        'logsheet': false,
                                        'vendor': false
                                      });
                                      _roleController.clear();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    "Create",
                                    style: buttontextstyle(),
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  });

              //Navigator.of(context).push(FadeRoute(page: ()));
              /*Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => categoryadd()));*/
            },
            child: Icon(
              Icons.add,
              color: fabiconcolor,
            )),
        body: dele
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.grey,
              ))
            : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "   Desigination : ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: checkboxtextcolor,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: rolex.snapshots(),
                              builder: (context, snapshots) {
                                List<DropdownMenuItem> stockItemss = [];
                                // stockItemss.add(DropdownMenuItem(child: Text("Custom")));
                                if (!snapshots.hasData) {
                                  const CircularProgressIndicator();
                                } else {
                                  final Stock = snapshots.data?.docs.toList();
                                  // print(Stock);
                                  Stock != null;
                                  for (var Stocks in Stock!) {
                                    stockItemss.add(
                                      DropdownMenuItem(
                                        value: Stocks.id,
                                        child: Text(
                                          Stocks['role'],
                                          style: TextStyle(
                                              color: dropdowntextcolor),
                                        ),
                                      ),
                                    );
                                  }
                                }

                                return DropdownButtonFormField(
                                  alignment: Alignment.center,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      filled: true),
                                  //s decoration: InputDecoration(),
                                  iconEnabledColor: dropdowniconenabledcolor,
                                  iconDisabledColor: dropdownicondisabledcolor,
                                  focusColor: dropdownfocuscolor,
                                  borderRadius: dropdownborder(),
                                  dropdownColor: dropdownbackcolor,
                                  hint: Text(
                                    'Select Role',
                                    style: TextStyle(color: dropdowntextcolor),
                                  ),
                                  items: stockItemss,
                                  onChanged: (StockValue) {
                                    setState(
                                      () {
                                        _currentItemSelected = StockValue;
                                        rolex
                                            .doc(_currentItemSelected)
                                            .get()
                                            .then((DocumentSnapshot perms) {
                                          if (perms.exists) {
                                            setState(() {
                                              _checkBox1 = perms.get('addc');
                                              _checkBox2 = perms.get('add');
                                              _checkBox3 = perms.get('edit');
                                              _checkBox4 = perms.get('info');
                                              _checkBox5 = perms.get('addqty');
                                              _checkBox6 = perms.get('consume');
                                              _checkBox7 = perms.get('qr');
                                              _checkBox8 = perms.get('delete');
                                              _checkBox9 =
                                                  perms.get('logsheet');
                                              _checkBox0 = perms.get('vendor');
                                            });
                                          }
                                        });
                                      },
                                    );
                                  },
                                  value: _currentItemSelected,
                                  // },
                                );
                              }),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        title: Text(
                                          'Do You Want To Delete "$_currentItemSelected" Role ?',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        actions: <Widget>[
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child: const Text(
                                                      'No',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    )),
                                                TextButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        dele = true;
                                                      });
                                                      await rolex
                                                          .doc(
                                                              _currentItemSelected)
                                                          .delete();
                                                      setState(() {
                                                        _currentItemSelected =
                                                            null;
                                                        dele = false;
                                                      });
                                                      if (!mounted) return;
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: const Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ))
                                              ])
                                        ])
                                /*Center(
                                child: deletepop(
                              snap: roledel(),
                            ))*/
                                );
                          },
                          icon: Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.red,
                          ),
                          splashColor: iconsplashcolor,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '   Permissions :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: checkboxtextcolor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'All',
                          style: TextStyle(color: checkboxtextcolor),
                        ),
                        value: _checkBox,
                        onChanged: (value) {
                          setState(() {
                            //print('$value');
                            //print(value);

                            _checkBox = value;
                            _checkBox1 = value;
                            _checkBox2 = value;
                            _checkBox3 = value;
                            _checkBox4 = value;
                            _checkBox5 = value;
                            _checkBox6 = value;
                            _checkBox7 = value;
                            _checkBox7 = value;
                            _checkBox8 = value;
                            _checkBox9 = value;
                            _checkBox0 = value;
                          });
                        },
                        activeColor: checkboxtickbackcolor,
                        checkColor: checkboxtickcolor,
                        shape: checkboxtileshape(),
                        splashRadius: checkboxsplash(),
                        checkboxShape: checkboxshape(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Add Category',
                          style: TextStyle(color: checkboxtextcolor),
                        ),
                        value: _checkBox1,
                        onChanged: (value) {
                          setState(() {
                            //print('$value');
                            _checkBox1 = value;
                          });
                        },
                        activeColor: checkboxtickbackcolor,
                        checkColor: checkboxtickcolor,
                        shape: checkboxtileshape(),
                        splashRadius: checkboxsplash(),
                        checkboxShape: checkboxshape(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Add Product',
                          style: TextStyle(color: checkboxtextcolor),
                        ),
                        value: _checkBox2,
                        onChanged: (value) {
                          setState(() {
                            //print('$value');
                            _checkBox2 = value;
                          });
                        },
                        activeColor: checkboxtickbackcolor,
                        checkColor: checkboxtickcolor,
                        shape: checkboxtileshape(),
                        splashRadius: checkboxsplash(),
                        checkboxShape: checkboxshape(),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'Edit',
                              style: TextStyle(color: checkboxtextcolor),
                            ),
                            value: _checkBox3,
                            onChanged: (value) {
                              setState(() {
                                //print('$value');
                                _checkBox3 = value;
                              });
                            },
                            activeColor: checkboxtickbackcolor,
                            checkColor: checkboxtickcolor,
                            shape: checkboxtileshape(),
                            splashRadius: checkboxsplash(),
                            checkboxShape: checkboxshape())),
                    Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'Info',
                              style: TextStyle(color: checkboxtextcolor),
                            ),
                            value: _checkBox4,
                            onChanged: (value) {
                              setState(() {
                                //print('$value');
                                _checkBox4 = value;
                              });
                            },
                            activeColor: checkboxtickbackcolor,
                            checkColor: checkboxtickcolor,
                            shape: checkboxtileshape(),
                            splashRadius: checkboxsplash(),
                            checkboxShape: checkboxshape()
                            // checkboxShape: StadiumBorder,
                            )),
                    Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'addqty',
                              style: TextStyle(color: checkboxtextcolor),
                            ),
                            value: _checkBox5,
                            onChanged: (value) {
                              setState(() {
                                //print('$value');
                                _checkBox5 = value;
                              });
                            },
                            activeColor: checkboxtickbackcolor,
                            checkColor: checkboxtickcolor,
                            shape: checkboxtileshape(),
                            splashRadius: checkboxsplash(),
                            checkboxShape: checkboxshape())),
                    Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'consume',
                              style: TextStyle(color: checkboxtextcolor),
                            ),
                            value: _checkBox6,
                            onChanged: (value) {
                              setState(() {
                                //print('$value');
                                _checkBox6 = value;
                              });
                            },
                            activeColor: checkboxtickbackcolor,
                            checkColor: checkboxtickcolor,
                            shape: checkboxtileshape(),
                            splashRadius: checkboxsplash(),
                            checkboxShape: checkboxshape())),
                    Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'qr',
                              style: TextStyle(color: checkboxtextcolor),
                            ),
                            value: _checkBox7,
                            onChanged: (value) {
                              setState(() {
                                //print('$value');
                                _checkBox7 = value;
                              });
                            },
                            activeColor: checkboxtickbackcolor,
                            checkColor: checkboxtickcolor,
                            shape: checkboxtileshape(),
                            splashRadius: checkboxsplash(),
                            checkboxShape: checkboxshape())),
                    Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            'delete',
                            style: TextStyle(color: checkboxtextcolor),
                          ),
                          value: _checkBox8,
                          onChanged: (value) {
                            setState(() {
                              //print('$value');
                              _checkBox8 = value;
                            });
                          },
                          activeColor: checkboxtickbackcolor,
                          checkColor: checkboxtickcolor,
                          shape: checkboxtileshape(),
                          splashRadius: checkboxsplash(),
                          checkboxShape: checkboxshape(),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            'logsheet',
                            style: TextStyle(color: checkboxtextcolor),
                          ),
                          value: _checkBox9,
                          onChanged: (value) {
                            setState(() {
                              //print('$value');
                              _checkBox9 = value;
                            });
                          },
                          activeColor: checkboxtickbackcolor,
                          checkColor: checkboxtickcolor,
                          shape: checkboxtileshape(),
                          splashRadius: checkboxsplash(),
                          checkboxShape: checkboxshape(),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            'Vendor',
                            style: TextStyle(color: checkboxtextcolor),
                          ),
                          value: _checkBox0,
                          onChanged: (value) {
                            setState(() {
                              //print('$value');
                              _checkBox0 = value;
                            });
                          },
                          activeColor: checkboxtickbackcolor,
                          checkColor: checkboxtickcolor,
                          shape: checkboxtileshape(),
                          splashRadius: checkboxsplash(),
                          checkboxShape: checkboxshape(),
                        )),
                    Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: buttonbackgroundcolor),
                            onPressed: () {
                              if (_currentItemSelected == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snacks("Please Select Role "));
                              } else {
                                rolex.doc(_currentItemSelected).set({
                                  'role': _currentItemSelected,
                                  'addc': _checkBox1,
                                  'add': _checkBox2,
                                  'edit': _checkBox3,
                                  'info': _checkBox4,
                                  'addqty': _checkBox5,
                                  'consume': _checkBox6,
                                  'qr': _checkBox7,
                                  'delete': _checkBox8,
                                  'logsheet': _checkBox9,
                                  'vendor': _checkBox0
                                });
                                ScaffoldMessenger.of(context).showSnackBar(snacks(
                                    "The Permissions Has Been Set To The $_currentItemSelected role"));
                              }
                            },
                            child: Text(
                              'Save',
                              style: buttontextstyle(),
                            )))
                  ])));
  }
}
