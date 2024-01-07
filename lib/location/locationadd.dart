import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_2/PDF/All_Product_Export/all_product_expt.dart';
import 'package:flutter_application_2/constants/colors.dart';
import '../constants/Decorations.dart';

TextEditingController first = TextEditingController();
TextEditingController second = TextEditingController();
TextEditingController third = TextEditingController();
TextEditingController four = TextEditingController();

class MultiLevelDropDownExample extends StatefulWidget {
  const MultiLevelDropDownExample({Key? key}) : super(key: key);

  @override
  State<MultiLevelDropDownExample> createState() =>
      _MultiLevelDropDownExampleState();
}

class _MultiLevelDropDownExampleState extends State<MultiLevelDropDownExample> {
  String? selectedCardModel;
  String? selectedMake;
  String? selectedMake1;
  String? selectedMake2;
  //late Map<String, List<String>> dataset1;
  String? selectedStock;
  String? selected;
  bool loading = false;
  int count = 0;
  bool loading2 = false;
  double value = 0.0;
  double min = 0;
  final double max = 100;
  final divisions = 1000;
  List<TextEditingController> listController = [];
  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  CollectionReference ref1 = FirebaseFirestore.instance.collection('location');
  // void lis(String out) {
  //   List<CollectionReference<Object?>> k = [
  //     FirebaseFirestore.instance
  //         .collection('location')
  //         .doc(out)
  //         .collection('sublocation')
  //   ];
  // }

  bool cir = false;
  void dialogbox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Please select  rack'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok'))
              ],
            ));
  }

  void _showDialog({required CollectionReference<Map<String, dynamic>> out}) {
    setState(() {
      count = 0;
      second.clear();
      listController.clear();
    });

    showDialog(
        context: context,
        builder: (ctx) => Center(
              child: SingleChildScrollView(
                  child: AlertDialog(
                title: Text('Add New Location'),
                content: Form(
                  key: _formkey,
                  child: Column(children: [
                    Column(children: [
                      TextField(
                          readOnly: true,
                          controller: first,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade200)),
                            // border: OutlineInputBorder(
                            //     borderSide: BorderSide(
                            //         color: Colors.grey.shade200)),
                            hintText: selected,
                          )),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: second,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Number of Location to be Added'),
                        validator: (second) {
                          if (second!.isEmpty) {
                            return 'Please Enter value';
                          }
                          if (int.tryParse(second.toString()) == null) {
                            return 'Please Enter Valid number';
                          }
                          return null;
                        },
                      ),
                    ]),
                  ]),
                ),
                actions: [
                  IconButton(
                      splashColor: Colors.redAccent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 35,
                        color: Colors.red,
                      )),
                  IconButton(
                      splashColor: Colors.greenAccent,
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            count = int.parse(second.text);
                            for (int i = 0; i < count; i++) {
                              listController.add(TextEditingController());
                            }
                          });
                          Navigator.pop(context);
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => StatefulBuilder(
                                    builder: (context, setState) => Center(
                                      child: SingleChildScrollView(
                                        child: AlertDialog(
                                            title: Text('Add New Location'),
                                            content: Form(
                                              key: _formkey1,
                                              child: Column(
                                                children: [
                                                  if (count != 0)
                                                    for (int i = 0;
                                                        i < count;
                                                        i++)
                                                      TextFormField(
                                                          controller:
                                                              listController[i],
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      'location ${i + 1} of $selected'),
                                                          validator:
                                                              (listController) {
                                                            if (listController!
                                                                .isEmpty) {
                                                              return 'Please Enter value';
                                                            }

                                                            return null;
                                                          })
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  for (int i = 1;
                                                      i < listController.length;
                                                      i++) {
                                                    setState(() {
                                                      listController[i].value =
                                                          TextEditingValue(
                                                              text:
                                                                  '${listController[0].text}${i + 1}');
                                                    });
                                                  }
                                                  setState(() {
                                                    listController[0].value =
                                                        TextEditingValue(
                                                            text:
                                                                '${listController[0].text}1');
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.auto_mode_rounded,
                                                  size: 30,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              // MaterialButton(
                                              //     onPressed: () {

                                              //     },
                                              //     color:
                                              //         const Color.fromARGB(
                                              //             255, 0, 22, 145),
                                              //     child: const Text(
                                              //         "generate",
                                              //         style: TextStyle(
                                              //           color: Colors.white,
                                              //         ))),
                                              MaterialButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    // for (int i = 1;
                                                    //     i <
                                                    //         listController
                                                    //             .length;
                                                    //     i++) {
                                                    //   setState(() {});
                                                    // }
                                                  },
                                                  color: Colors.red,
                                                  child: const Text("Cancel",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ))),
                                              MaterialButton(
                                                  onPressed: () async {
                                                    // Navigator.of(context)
                                                    //     .pop();
                                                    // showDateRangePicker(
                                                    //     context: context,
                                                    //     firstDate:
                                                    //         DateTime.timestamp(),
                                                    //     lastDate:
                                                    //         DateTime.now());
                                                    //showSearch(context: context, delegate: SearchDelegate)

                                                    if (count != 0 &&
                                                        _formkey1.currentState!
                                                            .validate()) {
                                                      for (int i = 0;
                                                          i < count;
                                                          i++) {
                                                        await out.add({
                                                          'sub':
                                                              listController[i]
                                                                  .text,
                                                          'size': 0
                                                        });
                                                      }
                                                      listController.clear();
                                                      second.clear();
                                                      if (!mounted) return;
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  color: Colors.green,
                                                  child: const Text("Add",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )))
                                            ]),
                                      ),
                                    ),
                                  ));
                        }
                      },
                      icon: const Icon(
                        Icons.check_circle,
                        size: 35,
                        color: Colors.green,
                      )),
                ],
              )),
            ));
  }

  Future<void> _edit({required DocumentReference out}) async {
    double min = 0;
    final double max = 100;
    final divisions = 1000;
    await out.get().then((DocumentSnapshot documentSnapshot) {
      setState(() {
        value = double.parse(documentSnapshot['size'].toString());
        // selected = documentSnapshot['sub'];
        four.value = TextEditingValue(text: documentSnapshot['sub'].toString());
      });
    }).then((v) => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Center(
                child: AlertDialog(
                  title: Column(
                    children: [
                      TextField(
                        controller: four,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'location of $selected'),
                      ),
                      Row(
                        children: [
                          Text(
                            value.round().toString(),
                            style: stabletextstyle(),
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderThemeData(
                                  overlappingShapeStrokeColor: colorrr(value),
                                  overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 20),
                                  activeTrackColor: colorrr(value),
                                  inactiveTrackColor: Colors.grey,
                                  thumbColor: colorrr(value),
                                  overlayColor: colorrr(value),
                                  valueIndicatorColor: colorrr(value)),
                              child: Slider(
                                  min: min,
                                  max: max,
                                  value: value,
                                  divisions: divisions,
                                  label: value.round().toString(),
                                  onChanged: (value) =>
                                      setState(() => this.value = value)),
                            ),
                          ),
                          Text(
                            max.round().toString(),
                            style: stabletextstyle(),
                          ),
                        ],
                      )
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          size: 35,
                          color: Colors.red,
                        )),
                    IconButton(
                        onPressed: () async {
                          await out.update({
                            'sub': four.text,
                            'size': value.round().toString()
                          }).then((value) => {Navigator.pop(context)}

                              // setState(() {
                              //   selected = four.text;
                              // }),
                              );
                        },
                        icon: const Icon(
                          Icons.check_circle,
                          size: 35,
                          color: Colors.green,
                        ))
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    var sizeh = MediaQuery.of(context).size.height;
    var sizew = MediaQuery.of(context).size.width;
    bool chk = false;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          // backgroundColor: screenbackgroundcolor,
          leading: IconButton(
              alignment: Alignment.topLeft,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.redAccent,
                size: 30,
              )),
          title: Text("L O C A T I O N", style: headingstyle()),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            elevation: 10,
            splashColor: Colors.white10,
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
                        key: _formkey,
                        onWillPop: () async {
                          bool ss = await showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) => WillPopScope(
                                    onWillPop: () async {
                                      return false;
                                    },
                                    child: AlertDialog(
                                      title: Text('Are you sure??'),
                                      content: Text('Do you want to exist'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text('Yes')),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text('No'))
                                      ],
                                    ),
                                  ));
                          return ss;
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "Create Location",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              controller: third,
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText: 'Main Location',
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  labelStyle: TextStyle(color: Colors.black)),
                              validator: (third) {
                                if (third!.isEmpty) {
                                  return 'Please Enter value';
                                }
                                if (int.tryParse(third.toString()) != null) {
                                  return 'Please Enter valid Location';
                                }
                                if (chk) {
                                  return 'Already Exits';
                                }

                                return null;
                              },
                            ),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      chk = false;
                                    });
                                    await FirebaseFirestore.instance
                                        .collection('location')
                                        .get()
                                        .then((value) {
                                      for (QueryDocumentSnapshot document
                                          in value.docs) {
                                        if (document
                                                .get('main')
                                                .toString()
                                                .toLowerCase()
                                                .trim() ==
                                            third.text
                                                .toString()
                                                .toLowerCase()
                                                .trim()) {
                                          chk = true;
                                        }
                                      }
                                    });

                                    if (_formkey.currentState!.validate()) {
                                      await FirebaseFirestore.instance
                                          .collection('location')
                                          .add({
                                        'main': third.text,
                                        'size': 0
                                      }).then((value) {
                                        third.clear();

                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                  child: const Text("Create")),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.grey,
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    const SizedBox(
                      height: 25,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('location')
                            .snapshots(),
                        builder: (context, snapshots) {
                          List<DropdownMenuItem> stockItems = [];

                          final Stock = snapshots.data?.docs.toList();
                          if (Stock != null) {
                            for (var Stocks in Stock) {
                              stockItems.add(
                                DropdownMenuItem(
                                  value: Stocks.id,
                                  child: Text(
                                    Stocks['main'],
                                  ),
                                ),
                              );
                            }
                          }

                          return DropdownButtonFormField(
                            //isExpanded: true,
                            dropdownColor: Colors.grey.shade200,
                            decoration: InputDecoration(
                              helperText: 'Main Location ',
                              prefixIcon: const Icon(
                                Icons.location_on_sharp,
                                color: Colors.green,
                              ),
                              suffixIcon: PopupMenuButton<int>(
                                color: Colors.black,
                                position: PopupMenuPosition.under,
                                constraints:
                                    BoxConstraints.tight(const Size(70, 160)),
                                onSelected: (index) async {
                                  if (selectedStock != null) {
                                    if (index == 1) {
                                      _showDialog(
                                          out: FirebaseFirestore.instance
                                              .collection('location')
                                              .doc(selectedStock)
                                              .collection('sublocation'));
                                    }
                                    if (index == 3) {
                                      setState(() {
                                        loading = true;
                                      });
                                      var collection2 = FirebaseFirestore
                                          .instance
                                          .collection('location')
                                          .doc(selectedStock)
                                          .collection('sublocation');

                                      var snapshots1 = await collection2.get();
                                      for (var doc1 in snapshots1.docs) {
                                        var collection2 = FirebaseFirestore
                                            .instance
                                            .collection('location')
                                            .doc(selectedStock)
                                            .collection('sublocation')
                                            .doc(doc1.id)
                                            .collection('sublocation');
                                        var snapshots2 =
                                            await collection2.get();
                                        for (var doc2 in snapshots2.docs) {
                                          var collection2 = FirebaseFirestore
                                              .instance
                                              .collection('location')
                                              .doc(selectedStock)
                                              .collection('sublocation')
                                              .doc(doc1.id)
                                              .collection('sublocation')
                                              .doc(doc2.id)
                                              .collection('sublocation');
                                          var snapshots2 =
                                              await collection2.get();
                                          for (var doc in snapshots2.docs) {
                                            doc.reference.delete();
                                            print('afsfsds  ${doc.get('sub')}');
                                          }
                                          doc2.reference.delete();
                                          print(
                                              'gdsfgasfff  ${doc2.get('sub')}');
                                        }
                                        doc1.reference.delete();
                                        print('dasdfads  ${doc1.get('sub')}');
                                      }
                                      FirebaseFirestore.instance
                                          .collection('location')
                                          .doc(selectedStock)
                                          .delete();

                                      setState(() {
                                        selectedStock = null;
                                        loading = false;
                                      });
                                    }
                                    if (index == 2) {
                                      await FirebaseFirestore.instance
                                          .collection('location')
                                          .doc(selectedStock)
                                          .get()
                                          .then((DocumentSnapshot
                                              documentSnapshot) {
                                        setState(() {
                                          value = double.parse(
                                              documentSnapshot['size']
                                                  .toString());
                                        });
                                      });

                                      four.value = TextEditingValue(
                                          text: selected.toString());
                                      if (!mounted) return;
                                      showDialog(
                                          context: context,
                                          builder: (context) => StatefulBuilder(
                                                builder: (context, setState) =>
                                                    Center(
                                                  child: AlertDialog(
                                                    title: Column(
                                                      children: [
                                                        TextField(
                                                          controller: four,
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              hintText:
                                                                  'location of $selected'),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              value
                                                                  .round()
                                                                  .toString(),
                                                              style:
                                                                  stabletextstyle(),
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  SliderTheme(
                                                                data: SliderThemeData(
                                                                    overlappingShapeStrokeColor:
                                                                        colorrr(
                                                                            value),
                                                                    overlayShape:
                                                                        const RoundSliderOverlayShape(
                                                                            overlayRadius:
                                                                                20),
                                                                    activeTrackColor:
                                                                        colorrr(
                                                                            value),
                                                                    inactiveTrackColor:
                                                                        Colors
                                                                            .grey,
                                                                    thumbColor:
                                                                        colorrr(
                                                                            value),
                                                                    overlayColor:
                                                                        colorrr(
                                                                            value),
                                                                    valueIndicatorColor:
                                                                        colorrr(
                                                                            value)),
                                                                child: Slider(
                                                                    min: min,
                                                                    max: max,
                                                                    value:
                                                                        value,
                                                                    divisions:
                                                                        divisions,
                                                                    label: value
                                                                        .round()
                                                                        .toString(),
                                                                    onChanged: (value) =>
                                                                        setState(() =>
                                                                            this.value =
                                                                                value)),
                                                              ),
                                                            ),
                                                            Text(
                                                              max
                                                                  .round()
                                                                  .toString(),
                                                              style:
                                                                  stabletextstyle(),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    actions: [
                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                            size: 35,
                                                            color: Colors.red,
                                                          )),
                                                      IconButton(
                                                          onPressed: () async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'location')
                                                                .doc(
                                                                    selectedStock)
                                                                .update({
                                                              'main': four.text,
                                                              'size': value
                                                                  .round()
                                                                  .toString()
                                                            }).then((value) => {
                                                                      setState(
                                                                          () {
                                                                        selected =
                                                                            four.text;
                                                                      }),
                                                                      Navigator.pop(
                                                                          context)
                                                                    });
                                                          },
                                                          icon: const Icon(
                                                            Icons.check_circle,
                                                            size: 35,
                                                            color: Colors.green,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ));
                                      setState(() {});
                                    }
                                  } else {
                                    dialogbox();
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem<int>(
                                      value: 1,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 2,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 3,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ];
                                },
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(20)),
                              // border: const OutlineInputBorder()
                            ),
                            //alignment: AlignmentDirectional.center,
                            disabledHint: const Text(
                              'No location',
                              style: TextStyle(color: Colors.red),
                            ),
                            //dropdownColor: Colors.lightBlueAccent,
                            hint: const Text('Select location'),
                            items: stockItems,
                            onChanged: (StockValue) {
                              setState(() {
                                selectedMake = null;
                                selectedStock = StockValue;
                                FirebaseFirestore.instance
                                    .collection('location')
                                    .doc(StockValue)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) {
                                  setState(() {
                                    if (documentSnapshot['main'] != null) {
                                      selected = documentSnapshot['main'];
                                      value = double.parse(
                                          documentSnapshot['size'].toString());
                                    } else {
                                      selected = null;
                                    }
                                  });
                                });
                              });
                            },

                            value: selectedStock,
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: ref1
                            .doc(selectedStock)
                            .collection('sublocation')
                            .orderBy('sub', descending: false)
                            .snapshots(),
                        builder: (context, snapshots) {
                          List<DropdownMenuItem> stockItems1 = [];
                          //List<String> stockItems1 = [];
                          final Stock = snapshots.data?.docs.toList();
                          if (Stock != null) {
                            for (var Stocks in Stock) {
                              // stockItems1.add(Stocks['sub']);
                              stockItems1.add(
                                DropdownMenuItem(
                                  value: Stocks.id,
                                  child: Text(
                                    Stocks['sub'],
                                  ),
                                ),
                              );
                            }
                          }
                          //   dataset1 = {
                          //   selected.toString(): stockItems1,
                          // };
                          //print('uhbubuh ${dataset1}');
                          return DropdownButtonFormField(
                            dropdownColor: Colors.grey.shade100,
                            decoration: InputDecoration(
                              helperText: 'Sub Location 1',
                              suffixIcon: PopupMenuButton<int>(
                                color: Colors.black,
                                position: PopupMenuPosition.under,
                                constraints:
                                    BoxConstraints.tight(const Size(70, 160)),
                                onSelected: (index) async {
                                  if (selectedMake != null) {
                                    if (index == 1) {
                                      _showDialog(
                                          out: FirebaseFirestore.instance
                                              .collection('location')
                                              .doc(selectedStock)
                                              .collection('sublocation')
                                              .doc(selectedMake)
                                              .collection('sublocation'));
                                    }
                                    if (index == 3) {
                                      setState(() {
                                        loading = true;
                                      });

                                      var collection2 = FirebaseFirestore
                                          .instance
                                          .collection('location')
                                          .doc(selectedStock)
                                          .collection('sublocation')
                                          .doc(selectedMake)
                                          .collection('sublocation');
                                      var snapshots2 = await collection2.get();
                                      for (var doc2 in snapshots2.docs) {
                                        var collection2 = FirebaseFirestore
                                            .instance
                                            .collection('location')
                                            .doc(selectedStock)
                                            .collection('sublocation')
                                            .doc(selectedMake)
                                            .collection('sublocation')
                                            .doc(doc2.id)
                                            .collection('sublocation');
                                        var snapshots2 =
                                            await collection2.get();
                                        for (var doc in snapshots2.docs) {
                                          doc.reference.delete();
                                          print(
                                              'sdfafasfas  ${doc.get('sub')}');
                                        }
                                        doc2.reference.delete();
                                        print('fasfdasf  ${doc2.get('sub')}');
                                      }
                                      //doc1.reference.delete();
                                      print('dasdfads  ${selectedMake}');

                                      FirebaseFirestore.instance
                                          .collection('location')
                                          .doc(selectedStock)
                                          .collection('sublocation')
                                          .doc(selectedMake)
                                          .delete();

                                      setState(() {
                                        selectedMake = null;
                                        loading = false;
                                      });
                                    }
                                    if (index == 2) {
                                      _edit(
                                          out: FirebaseFirestore.instance
                                              .collection('location')
                                              .doc(selectedStock)
                                              .collection('sublocation')
                                              .doc(selectedMake));
                                    }
                                  } else {
                                    dialogbox();
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem<int>(
                                      value: 1,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 2,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 3,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ];
                                },
                              ),
                              prefixIcon: const Icon(
                                Icons.location_on_sharp,
                                color: Colors.orange,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            disabledHint: const Text(
                              'No location',
                              style: TextStyle(color: Colors.red),
                            ),
                            //dropdownColor: Colors.lightBlueAccent,
                            hint: const Text('Select location'),
                            items: stockItems1,
                            onChanged: (val) async {
                              await ref1
                                  .doc(selectedStock)
                                  .collection('sublocation')
                                  .doc(val)
                                  .get()
                                  .then((doc) {
                                setState(() {
                                  value = double.parse(doc['size'].toString());
                                });
                              });
                              setState(() {
                                selectedMake1 = null;
                                selectedMake = val!;
                              });
                            },
                            value: selectedMake,
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       if (selectedMake != null) {
                    //         _showDialog(
                    //             out: FirebaseFirestore.instance
                    //                 .collection('location')
                    //                 .doc(selectedStock)
                    //                 .collection('sublocation')
                    //                 .doc(selectedMake)
                    //                 .collection('sublocation'));
                    //       } else {
                    //         dialogbox();
                    //       }
                    //     },
                    //     icon: const Icon(Icons.add)),
                    // IconButton(
                    //     onPressed: () {}, icon: const Icon(Icons.edit)),
                    // IconButton(
                    //     onPressed: () async {
                    //       if (selectedMake != null) {
                    //         setState(() {
                    //           loading = true;
                    //         });

                    //         var collection2 = FirebaseFirestore.instance
                    //             .collection('location')
                    //             .doc(selectedStock)
                    //             .collection('sublocation')
                    //             .doc(selectedMake)
                    //             .collection('sublocation');
                    //         var snapshots2 = await collection2.get();
                    //         for (var doc2 in snapshots2.docs) {
                    //           var collection2 = FirebaseFirestore.instance
                    //               .collection('location')
                    //               .doc(selectedStock)
                    //               .collection('sublocation')
                    //               .doc(selectedMake)
                    //               .collection('sublocation')
                    //               .doc(doc2.id)
                    //               .collection('sublocation');
                    //           var snapshots2 = await collection2.get();
                    //           for (var doc in snapshots2.docs) {
                    //             doc.reference.delete();
                    //             print('sdfafasfas  ${doc.get('sub')}');
                    //           }
                    //           doc2.reference.delete();
                    //           print('fasfdasf  ${doc2.get('sub')}');
                    //         }
                    //         //doc1.reference.delete();
                    //         print('dasdfads  ${selectedMake}');

                    //         FirebaseFirestore.instance
                    //             .collection('location')
                    //             .doc(selectedStock)
                    //             .collection('sublocation')
                    //             .doc(selectedMake)
                    //             .delete();

                    //         setState(() {
                    //           selectedMake = null;
                    //           loading = false;
                    //         });
                    //       } else {
                    //         dialogbox();
                    //       }
                    //     },
                    //     icon: const Icon(Icons.delete)),
                    StreamBuilder<QuerySnapshot>(
                        stream: ref1
                            .doc(selectedStock)
                            .collection('sublocation')
                            .doc(selectedMake)
                            .collection('sublocation')
                            .snapshots(),
                        builder: (context, snapshots) {
                          List<DropdownMenuItem> stockItems2 = [];
                          //List<String> stockItems1 = [];
                          final Stock = snapshots.data?.docs.toList();
                          if (Stock != null) {
                            for (var Stocks in Stock) {
                              // stockItems1.add(Stocks['sub']);
                              stockItems2.add(
                                DropdownMenuItem(
                                  value: Stocks.id,
                                  child: Center(
                                    child: Text(
                                      Stocks['sub'],
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          //   dataset1 = {
                          //   selected.toString(): stockItems1,
                          // };
                          //print('uhbubuh ${dataset1}');
                          return DropdownButtonFormField(
                            dropdownColor: Colors.grey.shade100,
                            decoration: InputDecoration(
                              helperText: 'Sub Location 2',
                              suffixIcon: PopupMenuButton<int>(
                                color: Colors.black,
                                position: PopupMenuPosition.under,
                                constraints:
                                    BoxConstraints.tight(const Size(70, 160)),
                                onSelected: (index) async {
                                  if (selectedMake1 != null) {
                                    if (index == 1) {
                                      _showDialog(
                                          out: FirebaseFirestore.instance
                                              .collection('location')
                                              .doc(selectedStock)
                                              .collection('sublocation')
                                              .doc(selectedMake)
                                              .collection('sublocation')
                                              .doc(selectedMake1)
                                              .collection('sublocation'));
                                    }
                                    if (index == 3) {
                                      setState(() {
                                        loading = true;
                                      });

                                      var collection2 = FirebaseFirestore
                                          .instance
                                          .collection('location')
                                          .doc(selectedStock)
                                          .collection('sublocation')
                                          .doc(selectedMake)
                                          .collection('sublocation')
                                          .doc(selectedMake1)
                                          .collection('sublocation');
                                      var snapshots2 = await collection2.get();
                                      for (var doc in snapshots2.docs) {
                                        doc.reference.delete();
                                        print('fsas  ${doc.get('sub')}');
                                      }

                                      FirebaseFirestore.instance
                                          .collection('location')
                                          .doc(selectedStock)
                                          .collection('sublocation')
                                          .doc(selectedMake)
                                          .collection('sublocation')
                                          .doc(selectedMake1)
                                          .delete();

                                      setState(() {
                                        selectedMake1 = null;

                                        loading = false;
                                      });
                                    }
                                    if (index == 2) {
                                      _edit(
                                          out: ref1
                                              .doc(selectedStock)
                                              .collection('sublocation')
                                              .doc(selectedMake)
                                              .collection('sublocation')
                                              .doc(selectedMake1));
                                    }
                                  } else {
                                    dialogbox();
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem<int>(
                                      value: 1,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 2,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 3,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ];
                                },
                              ),
                              prefixIcon: const Icon(
                                Icons.location_on_sharp,
                                color: Colors.purpleAccent,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            disabledHint: const Text(
                              'No location',
                              style: TextStyle(color: Colors.red),
                            ),
                            //dropdownColor: Colors.lightBlueAccent,
                            hint: const Text('Select location'),
                            items: stockItems2,
                            onChanged: (val) async {
                              await ref1
                                  .doc(selectedStock)
                                  .collection('sublocation')
                                  .doc(selectedMake)
                                  .collection('sublocation')
                                  .doc(val)
                                  .get()
                                  .then((doc) {
                                setState(() {
                                  value = double.parse(doc['size'].toString());
                                });
                              });
                              setState(() {
                                selectedMake2 = null;
                                selectedMake1 = val!;
                              });
                            },
                            value: selectedMake1,
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),

                    /*     IconButton(
                        onPressed: () {
                          if (selectedMake1 != null) {
                            _showDialog(
                                out: FirebaseFirestore.instance
                                    .collection('location')
                                    .doc(selectedStock)
                                    .collection('sublocation')
                                    .doc(selectedMake)
                                    .collection('sublocation')
                                    .doc(selectedMake1)
                                    .collection('sublocation'));
                          } else {
                            dialogbox();
                          }
                        },
                        icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: () async {
                          if (selectedMake1 != null) {
                            setState(() {
                              loading = true;
                            });
            
                            var collection2 = FirebaseFirestore.instance
                                .collection('location')
                                .doc(selectedStock)
                                .collection('sublocation')
                                .doc(selectedMake)
                                .collection('sublocation')
                                .doc(selectedMake1)
                                .collection('sublocation');
                            var snapshots2 = await collection2.get();
                            for (var doc in snapshots2.docs) {
                              doc.reference.delete();
                              print('fsas  ${doc.get('sub')}');
                            }
            
                            FirebaseFirestore.instance
                                .collection('location')
                                .doc(selectedStock)
                                .collection('sublocation')
                                .doc(selectedMake)
                                .collection('sublocation')
                                .doc(selectedMake1)
                                .delete();
            
                            setState(() {
                              selectedMake1 = null;
            
                              loading = false;
                            });
                          } else {
                            dialogbox();
                          }
                        },
                        icon: const Icon(Icons.delete)),*/
                    StreamBuilder<QuerySnapshot>(
                        stream: ref1
                            .doc(selectedStock)
                            .collection('sublocation')
                            .doc(selectedMake)
                            .collection('sublocation')
                            .doc(selectedMake1)
                            .collection('sublocation')
                            .orderBy('sub', descending: false)
                            .snapshots(),
                        builder: (context, snapshots) {
                          List<DropdownMenuItem> stockItems2 = [];
                          //List<String> stockItems1 = [];
                          final Stock = snapshots.data?.docs.toList();
                          if (Stock != null) {
                            for (var Stocks in Stock) {
                              // stockItems1.add(Stocks['sub']);
                              stockItems2.add(
                                DropdownMenuItem(
                                  value: Stocks.id,
                                  child: Text(
                                    Stocks['sub'],
                                  ),
                                ),
                              );
                            }
                          }

                          return DropdownButtonFormField(
                            dropdownColor: Colors.grey.shade100,
                            decoration: InputDecoration(
                              helperText: 'Sub Location 3',
                              suffixIcon: PopupMenuButton<int>(
                                color: Colors.black,
                                position: PopupMenuPosition.under,
                                constraints:
                                    BoxConstraints.tight(const Size(70, 120)),
                                onSelected: (index) async {
                                  if (selectedMake2 != null) {
                                    if (index == 1) {
                                      _showDialog(
                                          out: FirebaseFirestore.instance
                                              .collection('location')
                                              .doc(selectedStock)
                                              .collection('sublocation')
                                              .doc(selectedMake)
                                              .collection('sublocation')
                                              .doc(selectedMake1)
                                              .collection('sublocation'));
                                    }
                                    if (index == 3) {
                                      setState(() {
                                        loading = true;
                                      });
                                      FirebaseFirestore.instance
                                          .collection('location')
                                          .doc(selectedStock)
                                          .collection('sublocation')
                                          .doc(selectedMake)
                                          .collection('sublocation')
                                          .doc(selectedMake1)
                                          .collection('sublocation')
                                          .doc(selectedMake2)
                                          .delete();
                                      // var snapshots1 = await collection1.get();
                                      // for (var doc in snapshots1.docs) {
                                      //   await doc.reference.delete();
                                      // }
                                      setState(() {
                                        selectedMake2 = null;
                                        loading = false;
                                      });
                                    }
                                    if (index == 2) {
                                      _edit(
                                          out: ref1
                                              .doc(selectedStock)
                                              .collection('sublocation')
                                              .doc(selectedMake)
                                              .collection('sublocation')
                                              .doc(selectedMake1)
                                              .collection('sublocation')
                                              .doc(selectedMake2));
                                    }
                                  } else {
                                    dialogbox();
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem<int>(
                                      value: 2,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 3,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ];
                                },
                              ),
                              prefixIcon: const Icon(
                                Icons.location_on_sharp,
                                color: Colors.lightBlueAccent,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            disabledHint: const Text(
                              'No location',
                              style: TextStyle(color: Colors.red),
                            ),
                            //dropdownColor: Colors.lightBlueAccent,
                            hint: const Text('Select location'),
                            items: stockItems2,
                            onChanged: (val) async {
                              await ref1
                                  .doc(selectedStock)
                                  .collection('sublocation')
                                  .doc(selectedMake)
                                  .collection('sublocation')
                                  .doc(selectedMake1)
                                  .collection('sublocation')
                                  .doc(val)
                                  .get()
                                  .then((doc) {
                                setState(() {
                                  value = double.parse(doc['size'].toString());
                                });
                              });
                              setState(() {
                                selectedMake2 = val!;
                              });
                            },
                            value: selectedMake2,
                          );
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(
                          value.round().toString(),
                          style: stabletextstyle(),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: SliderThemeData(
                                overlappingShapeStrokeColor: colorrr(value),
                                overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 20),
                                activeTrackColor: colorrr(value),
                                inactiveTrackColor: Colors.grey,
                                thumbColor: colorrr(value),
                                overlayColor: colorrr(value),
                                valueIndicatorColor: colorrr(value)),
                            child: Slider(
                              min: min,
                              max: max,
                              value: value,
                              divisions: divisions,
                              label: value.round().toString(),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        Text(
                          max.round().toString(),
                          style: stabletextstyle(),
                        ),
                      ],
                    ),
                    // IconButton(
                    //     onPressed: () async {
                    //       if (selectedMake1 != null) {
                    //         setState(() {
                    //           loading = true;
                    //         });
                    //         FirebaseFirestore.instance
                    //             .collection('location')
                    //             .doc(selectedStock)
                    //             .collection('sublocation')
                    //             .doc(selectedMake)
                    //             .collection('sublocation')
                    //             .doc(selectedMake1)
                    //             .collection('sublocation')
                    //             .doc(selectedMake2)
                    //             .delete();
                    //         // var snapshots1 = await collection1.get();
                    //         // for (var doc in snapshots1.docs) {
                    //         //   await doc.reference.delete();
                    //         // }
                    //         setState(() {
                    //           selectedMake2 = null;
                    //           loading = false;
                    //         });
                    //       } else {
                    //         dialogbox();
                    //       }
                    //     },
                    //     icon: const Icon(Icons.delete)),

                    // Text(
                    //     '$selected / $selectedMake/$selectedMake1 /$selectedMake2'),
                    // TextButton(
                    //   onPressed: () async {
                    //     // _showDialog();
                    //     // await FirebaseFirestore.instance
                    //     //     .collection('Stocks')
                    //     //     .doc('test')
                    //     //     .collection('productss')
                    //     //     .add({
                    //     //   "category": 'laptop',
                    //     //   "name": 'Name',
                    //     //   "date": DateTime.now().toString(),
                    //     //   "location": 'location',
                    //     //   "quantity": '100',
                    //     //   "mqty": '10',
                    //     //   "vendorname": 'Vendorname',
                    //     //   "address": 'address',
                    //     //   "phoneno": '8976976486',
                    //     //   "price": '120',
                    //     //   'dp':
                    //     //       'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
                    //     //   'qrname': DateTime.now().toString(),
                    //     // });
                    //   },
                    //   child: const Icon(Icons.add),
                    // )
                  ]),
                ),
              ));
  }
}



/*// import 'package:flutter/material.dart';

// class locationadd extends StatefulWidget {
//   const locationadd({super.key});

//   @override
//   State<locationadd> createState() => _locationaddState();
// }

// class _locationaddState extends State<locationadd> {
//   final List<TextEditingController> _items = [];
//   List<TextEditingController> listController = [TextEditingController()];
//   // final List<TextEditingController> _quantity = [];
//   final TextEditingController _quantity = TextEditingController();
//   // final List<TextEditingController> _price = [];

//   double textFieldBottomPadding = 15,
//       textFieldRounded = 10,
//       inputFieldPadding = 2;

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _addField();
//     });
//   }

//   _addField() {
//     setState(() {
//       _items.add(TextEditingController());
//       // _quantity.add(TextEditingController());
//       //_price.add(TextEditingController());
//     });
//   }

//   _removeField(i) {
//     setState(() {
//       _items.removeAt(i);
//       //_quantity.removeAt(i);
//       //_price.removeAt(i);
//     });
//   }

//   void _submit() {
//     final _isValid = _formKey.currentState!.validate();
//     if (!_isValid) {
//       return;
//     }
//     _formKey.currentState!.save();

//     //FormData formData = FormData.fromMap({});

//     for (int i = 0; i < _items.length; i++) {
//       print("fjnsjbknn ${_items[i].text}");
//       /* formData.fields.add(MapEntry("_items[]", _items[i].text));
//       formData.fields.add(MapEntry("_quantity[]", _quantity[i].text));
//       formData.fields.add(MapEntry("_price[]", _price[i].text));*/
//     }

//     /* networkRequest(
//         context: context,
//         requestType: 'post',
//         url: "${Urls.billAdd}${widget.taskId}?jhhihu",
//         data: formData,
//         action: (r) {
//           Navigator.pop(context, true);
//         });*/
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         elevation: 10,
//         shadowColor: Colors.orangeAccent,
//         backgroundColor: Colors.black,
//         title: const Text("Location Add"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8),
//         child: ListView(
//           children: [
//             /*Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 InkWell(
//                   onTap: () => _addField(),
//                   child: const Icon(Icons.add),
//                 ),
//               ],
//             ),*/
//             const SizedBox(
//               height: 10,
//               // height: 10.sp,
//             ),
//             Form(
//                 key: _formKey,
//                 child: Column(children: [
//                   for (int i = 0; i < _items.length; i++)
//                     Column(children: [
//                       /*Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           InkWell(
//                             child: const Icon(Icons.remove_circle_outline),
//                             onTap: () => _removeField(i),
//                           )
//                         ],
//                       ),*/
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Expanded(
//                                 flex: 3,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(inputFieldPadding),
//                                   child: TextFormField(
//                                     controller: _items[i],
//                                     validator: (value) {
//                                       if (value == "") {
//                                         return "Please Enter Item Name";
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                     decoration: InputDecoration(
//                                         border: OutlineInputBorder(
//                                             borderRadius: BorderRadius.circular(
//                                                 textFieldRounded)),
//                                         label: const Text("Title")),
//                                   ),
//                                 )),
//                             if (i == 0)
//                               Expanded(
//                                   flex: 1,
//                                   child: Padding(
//                                     padding: EdgeInsets.all(inputFieldPadding),
//                                     child: TextFormField(
//                                       keyboardType: TextInputType.number,
//                                       controller: _quantity,
//                                       validator: (value) {
//                                         if (value == "" || value == "0") {
//                                           return "Required";
//                                         } else {
//                                           return null;
//                                         }
//                                       },
//                                       decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       textFieldRounded)),
//                                           label: const Text("Quantity")),
//                                     ),
//                                   )),
//                             /* Expanded(
//                                 flex: 1,
//                                 child: Padding(
//                                     padding: EdgeInsets.all(inputFieldPadding),
//                                     child: TextFormField(
//                                         keyboardType: TextInputType.number,
//                                         controller: _price[i],
//                                         validator: (value) {
//                                           if (value == "" || value == "0") {
//                                             return "Required";
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         decoration: InputDecoration(
//                                             border: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         textFieldRounded)),
//                                             label: const Text("Price")))))*/
//                             InkWell(
//                               onTap: () => _addField(),
//                               child: const Icon(Icons.add),
//                             ),
//                             InkWell(
//                               child: const Icon(Icons.remove_circle_outline),
//                               onTap: () => _removeField(i),
//                             ),
//                           ]),
//                       const Divider(
//                         thickness: 1,
//                       )
//                     ])
//                 ])),
//             MaterialButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular((10))),
//                 // borderRadius: BorderRadius.circular(Adaptive.px(10))),
//                 color: Color.fromARGB(255, 255, 48, 33),
//                 onPressed: () {
//                   _submit();
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all((10)),
//                   // padding: EdgeInsets.all(Adaptive.px(10)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [Text("SAVE")],
//                   ),
//                 ))
//           ],
//         ),
//       ), /*
//        SafeArea(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
//                 child: Text(
//                   "Dynamic Text Field",
//                   style: GoogleFonts.nunito(
//                     fontWeight: FontWeight.bold,
//                     color: const Color(0xFF2E384E),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 shrinkWrap: true,
//                 itemCount: listController.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 15),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             height: 60,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF2E384E),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: TextFormField(
//                               controller: listController[index],
//                               autofocus: false,
//                               style: const TextStyle(color: Color(0xFFF8F8FF)),
//                               decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Input Text Here",
//                                 hintStyle: TextStyle(
//                                     color: Color.fromARGB(255, 132, 140, 155)),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         index != 0
//                             ? GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     listController[index].clear();
//                                     listController[index].dispose();
//                                     listController.removeAt(index);
//                                   });
//                                 },
//                                 child: const Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                   size: 35,
//                                 ),
//                               )
//                             : const SizedBox()
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     listController.add(TextEditingController());
//                   });
//                 },
//                 child: Center(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 15),
//                     decoration: BoxDecoration(
//                         color: const Color(0xFF2E384E),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Text("Add More",
//                         style: GoogleFonts.nunito(
//                             color: Color.fromARGB(255, 132, 140, 155))),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               )
//             ],
//           ),
//         ),
//       ),*/
//     );
//   }
// }
*/