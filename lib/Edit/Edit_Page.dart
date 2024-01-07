import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../Constants/colors.dart';
import '../Create/Add_Page.dart';
import '../Home/Employee_Home.dart';
import '../Image/Image_Picker.dart';
import '../constants/Decorations.dart';

final _formkey3 = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _categoryController = TextEditingController();
final TextEditingController _dateController = TextEditingController();
final TextEditingController _locationController = TextEditingController();
final TextEditingController _qtyController = TextEditingController();
final TextEditingController _mqtyController = TextEditingController();
final TextEditingController _vendornameController = TextEditingController();
final TextEditingController _vendoradressController = TextEditingController();
final TextEditingController _vendorphnoController = TextEditingController();
final TextEditingController _priceController = TextEditingController();
final TextEditingController _qr = TextEditingController();
final TextEditingController dp = TextEditingController();
final TextEditingController _discrptionController = TextEditingController();
final _cato = FirebaseFirestore.instance.collection('Stocks');
Uint8List? _imagee;
DocumentSnapshot? sanjay;
final _log = FirebaseFirestore.instance.collection('All Users Data');
final FirebaseStorage _storage = FirebaseStorage.instance;
late List samm;
double min = 0;

class StoreData {
  Future<List> uploadImageToStorage(
    Uint8List sam,
  ) async {
    Reference ref = _storage.refFromURL(dp.text);
    UploadTask uploadTask = ref.putData(sam);
    // Reference ref1 = _storage.ref().child(sa);
    //UploadTask uploadTask2 = ref1.putData(sam);
    //TaskSnapshot snapshot1 = await uploadTask2;
    TaskSnapshot snapshot2 = await uploadTask;
    //String down = await snapshot1.ref.getDownloadURL();
    String downloadUrl = await snapshot2.ref.getDownloadURL();
    return [downloadUrl];
  }

  Future<String> saveData({
    required Uint8List file,
  }) async {
    String resp = " some error Occured";

    try {
      {
        List san = await uploadImageToStorage(file);
        samm = san;

        /*await _firestore.collection('productk').add({
          'imageLink': imageUrl[0],
          'image': imageUrl[1],
        });*/
        resp = 'sucess';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}

// Future<void> raja(DocumentSnapshot? documentSnapshot) async {
//   sanjay = documentSnapshot;
//   if (sanjay != null) {
//     _nameController.text = sanjay!.get('name');
//     _categoryController.text = sanjay!.get('category');
//     _dateController.text = DateTime.now().toString();
//     _locationController.text = sanjay!.get('location');
//     _qtyController.text = sanjay!.get('quantity');
//     _mqtyController.text = sanjay!.get('mqty');
//     _vendornameController.text = sanjay!.get("vendorname");
//     _vendoradressController.text = sanjay!.get("address");
//     _vendorphnoController.text = sanjay!.get("phoneno");
//     _priceController.text = sanjay!.get("price");
//     _qr.text = sanjay!.get("qrname");
//     dp.text = sanjay!.get("dp");
//   }
// }

class Edit extends StatefulWidget {
  final DocumentSnapshot snapshot;
  const Edit({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  /* selectImage() async {
    try {
      Uint8List img = await pickimage(ImageSource.camera);
      setState(() {
        _imagee = img;
      });
    } catch (e) {
      //print('Error$e');
    }
  }
*/
  bool visible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future selectImage() async {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
              backgroundColor: dialogbackcolor,
              title: Text(
                'Select Image',
                style: stabletextstyle(),
              ),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      style: buttonstyle(),
                      onPressed: () async {
                        Navigator.pop(context);
                        try {
                          Uint8List img = await pickimage(ImageSource.gallery);
                          setState(() {
                            _imagee = img;
                          });
                        } catch (er) {}
                      },
                      child: const Icon(
                        Icons.photo_size_select_actual_rounded,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                        style: buttonstyle(),
                        onPressed: () async {
                          Navigator.pop(context);
                          try {
                            Uint8List img = await pickimage(ImageSource.camera);
                            setState(() {
                              _imagee = img;
                            });
                          } catch (e) {}
                        },
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ))
                  ]));
        }));
  }

  double value = 0.0;
  double value1 = 0.0;
  dynamic select;
  dynamic selectedMake;
  dynamic selectedMake1;
  dynamic selectedMake2;
  dynamic _location;
  dynamic _location1;
  dynamic _location2;
  dynamic _location3;
  dynamic _loc;
  double min = 0;
  final double max = 100;
  final divisions = 1000;
  dynamic selectt;
  dynamic selectt1;
  dynamic selectt2;
  dynamic selectt3;
  dynamic addupdate;
  bool loc=false;
  CollectionReference ref1 = FirebaseFirestore.instance.collection('location');
  Future<double?> location() => showDialog<double>(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, StateSetter sta) => AlertDialog(
                title: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('location')
                            .snapshots(),
                        builder: (context, snapshots) {
                          List<DropdownMenuItem<DocumentReference>> stockItems =
                              [];

                          final Stock = snapshots.data?.docs.toList();
                          if (Stock != null) {
                            for (var Stocks in Stock) {
                              stockItems.add(
                                DropdownMenuItem(
                                  value: Stocks.reference,
                                  child: Text(
                                    Stocks['main'],
                                  ),
                                ),
                              );
                            }
                          }
                          return DropdownButton<DocumentReference>(
                            alignment: AlignmentDirectional.center,
                            disabledHint: const Text(
                              'No location',
                              style: TextStyle(color: Colors.red),
                            ),
                            //dropdownColor: Colors.lightBlueAccent,
                            hint: const Text('Select location'),
                            items: stockItems,
                            onChanged: (stockValue) async {
                              sta(() {

                                selectt1 = null;
                                selectt2 = null;
                                selectt3 = null;
                                selectt = stockValue;
                                select = stockValue!.id;
                              });
                              // var ss = await FirebaseFirestore.instance
                              //     .collection('sample')
                              //     .doc('e5wTI0cMTIkOdxwLcurr')
                              //     .get();
                              // DocumentReference<Map<String, dynamic>> kk =
                              //     ss.get('name');
                              // kk.update({'size': 69});
                              // sta(() {
                              //   var ss = snapshots.data!.docs.where((elementt) {
                              //     if (elementt.id == stockValue.toString()) {
                              //       print('dsfc${elementt.get('main')}');

                              //       sta(() {
                              //         selected = elementt.get('main');
                              //         value1 = double.parse(
                              //             elementt.get('size').toString());
                              //         addupdate = elementt;
                              //         one = elementt.reference;
                              //       });
                              //       print('ref==$one');
                              //     }

                              //     return true;
                              //   });
                              //   print('fadsfsaf${stockItems}');
                              //   // var kk = ss.where(
                              //   //     (element) => element.get('main'));
                              //   //  print('smdfmsdk ${StockValue} ${ss}');
                              stockValue!.get().then((value) {
                                sta(() {
                                  addupdate = stockValue;
                                  _location = value.get('main');
                                  _loc = _location;
                                  value1 = double.parse(
                                      value.get('size').toString());
                                });
                              });
                            },

                            value: selectt,
                          );
                        }),
                    StreamBuilder<QuerySnapshot>(
                        stream: ref1
                            .doc(select)
                            .collection('sublocation')
                            .snapshots(),
                        builder: (context, snapshots) {
                          List<DropdownMenuItem<DocumentReference>>
                              stockItems1 = [];

                          final Stock = snapshots.data?.docs.toList();
                          if (Stock != null) {
                            for (var Stocks in Stock) {
                              stockItems1.add(
                                DropdownMenuItem(
                                  value: Stocks.reference,
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
                          return DropdownButton<DocumentReference>(
                            alignment: AlignmentDirectional.center,
                            disabledHint: const Text(
                              'No location',
                              style: TextStyle(color: Colors.red),
                            ),
                            hint: const Text('Select location'),
                            items: stockItems1,
                            onChanged: (val) {
                              sta(() {
                                selectt2 = null;
                                selectt3 = null;
                                selectedMake = val!.id;
                                selectt1 = val;
                                addupdate = val;
                              });
                              val!.get().then((value) => {
                                    sta(() {
                                      _location1 = value.get('sub');
                                      _loc = _location + ' / ' + _location1;
                                      value1 = double.parse(
                                          value.get('size').toString());
                                    })
                                  });
                              // sta(() {
                              //   var ss = snapshots.data!.docs.where((element) {
                              //     if (element.id == val.toString()) {
                              //       //print('dsfc${element.get('sub')}');
                              //       select1 = element.get('sub');
                              //       value1 = double.parse(
                              //           element.get('size').toString());
                              //       addupdate = element;
                              //       two = element;
                              //     }
                              //     return true;
                              //   });

                              //   selectedMake1 = null;
                              //   selectedMake = val;
                              // });
                            },
                            value: selectt1,
                          );
                        }),
                    StreamBuilder<QuerySnapshot>(
                        stream: ref1
                            .doc(select)
                            .collection('sublocation')
                            .doc(selectedMake)
                            .collection('sublocation')
                            .snapshots(),
                        builder: (context, snapshots) {
                          List<DropdownMenuItem<DocumentReference>>
                              stockItems2 = [];
                          //List<String> stockItems1 = [];
                          final Stock = snapshots.data?.docs.toList();
                          if (Stock != null) {
                            for (var Stocks in Stock) {
                              // stockItems1.add(Stocks['sub']);
                              stockItems2.add(
                                DropdownMenuItem(
                                  value: Stocks.reference,
                                  child: Center(
                                    child: Text(
                                      Stocks['sub'],
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          return DropdownButton<DocumentReference>(
                            alignment: AlignmentDirectional.center,
                            disabledHint: const Text(
                              'No location',
                              style: TextStyle(color: Colors.red),
                            ),
                            hint: const Text('Select location'),
                            items: stockItems2,
                            onChanged: (val) {
                              sta(() {
                                selectt3 = null;
                                selectedMake1 = val!.id;
                                selectt2 = val;
                                addupdate = val;
                              });
                              val!.get().then((value) => {
                                    sta(() {
                                      _location2 = value.get('sub');
                                      _loc = _location +
                                          ' / ' +
                                          _location1 +
                                          ' / ' +
                                          _location2;
                                      value1 = double.parse(
                                          value.get('size').toString());
                                    })
                                  });
                              // sta(() {
                              //   var ss = snapshots.data!.docs.where((element) {
                              //     if (element.id == val.toString()) {
                              //       print('dsfc${element.get('sub')}');
                              //       select2 = element.get('sub');
                              //       value1 = double.parse(
                              //           element.get('size').toString());
                              //       addupdate = element;
                              //       three = element;
                              //     }

                              //     return true;
                              //   });

                              //   selectedMake2 = null;
                              //   selectedMake1 = val;
                              // });
                            },
                            value: selectt2,
                          );
                        }),
                    StreamBuilder<QuerySnapshot>(
                        stream: ref1
                            .doc(select)
                            .collection('sublocation')
                            .doc(selectedMake)
                            .collection('sublocation')
                            .doc(selectedMake1)
                            .collection('sublocation')
                            .snapshots(),
                        builder: (context, snapshots) {
                          List<DropdownMenuItem<DocumentReference>>
                              stockItems2 = [];
                          //List<String> stockItems1 = [];
                          final Stock = snapshots.data?.docs.toList();
                          if (Stock != null) {
                            for (var Stocks in Stock) {
                              // stockItems1.add(Stocks['sub']);
                              stockItems2.add(
                                DropdownMenuItem(
                                  value: Stocks.reference,
                                  child: Text(
                                    Stocks['sub'],
                                  ),
                                ),
                              );
                            }
                          }
                          return DropdownButton<DocumentReference>(
                            alignment: AlignmentDirectional.center,
                            disabledHint: const Text(
                              'No location',
                              style: TextStyle(color: Colors.red),
                            ),
                            hint: const Text('Select location'),
                            items: stockItems2,
                            onChanged: (val) {
                              val!.get().then((value) => {
                                    sta(() {
                                      _location3 = value.get('sub');
                                      _loc = _location +
                                          ' / ' +
                                          _location1 +
                                          ' / ' +
                                          _location2 +
                                          ' / ' +
                                          _location3;
                                      value1 = double.parse(
                                          value.get('size').toString());

                                      selectedMake2 = val.id;
                                      selectt3 = val;
                                      addupdate = val;
                                    })
                                  });

                              // sta(() {
                              //   var ss = snapshots.data!.docs.where((element) {
                              //     if (element.id == val.toString()) {
                              //       print('dsfc${element.get('sub')}');
                              //       select3 = element.get('sub');
                              //       value1 = double.parse(
                              //           element.get('size').toString());
                              //       addupdate = element;
                              //       four = element;
                              //     }

                              //     return true;
                              //   });
                              //   print('fadsfsaf$ss');
                              //   selectedMake2 = val!;
                              // });
                            },
                            value: selectt3,
                          );
                        }),
                    TextButton(
                        onPressed: () {
                          sta(() {
                            _locationController.value =
                                TextEditingValue(text: '${_loc??_locationController.text}');
                            value = value;
                            if(_loc!=null){loc=false;

                            }
                          });

                          Navigator.of(context).pop(value1);
                        },
                        child: const Text('Done'))
                  ],
                ),
              )));
  String? selectedStock;
  bool load = true;
  void _value_() {
    setState(() {
      _imagee = null;
      sanjay = widget.snapshot;
      selectedStock = sanjay!.get('category');
      _nameController.text = sanjay!.get('name');
      _categoryController.text = sanjay!.get('category');

      _dateController.text = sanjay!.get('date');
      _locationController.text = sanjay!.get('location');
      _qtyController.text = sanjay!.get('quantity');
      _mqtyController.text = sanjay!.get('mqty');
      _vendornameController.text = sanjay!.get("vendorname");
      _vendoradressController.text = sanjay!.get("address");
      _vendorphnoController.text = sanjay!.get("phoneno");
      _priceController.text = sanjay!.get("price");
      _discrptionController.text = sanjay!.get('des');
      _qr.text = sanjay!.get("qrname");
      dp.text = sanjay!.get("dp");
      selectt = sanjay!.get("one");
      selectt1 = sanjay!.get("two");
      selectt2 = sanjay!.get("three");
      selectt3 = sanjay!.get("four");

      if (selectt != null ) {
        select = selectt.id;
        selectt!.get().then((valu) {
          if (valu.exists) {
            setState(() {
              value = double.parse(valu.get('size').toString());
              min = value;
              addupdate = selectt;
              _location = valu.get('main').toString();
            });
          }else{
            setState(() {
              selectt=null;
              loc=true;
            });
          }
        });
      }
      if (selectt1 != null) {
        selectedMake = selectt1.id;
        selectt1!.get().then((valu) {
          if (valu.exists) {
            setState(() {
              value = double.parse(valu.get('size').toString());
              addupdate = selectt1;
              min = value;
              _location1 = valu.get('sub').toString();
            });
          }else{
            setState(() {
              selectt1=null;
              loc=true;
            });
          }
        });
      }
      if (selectt2 != null) {
        selectedMake1 = selectt2.id;
        selectt2!.get().then((valu) {
          if (valu.exists) {
            setState(() {
              value = double.parse(valu.get('size').toString());
              min = value;
              addupdate = selectt2;
              _location2 = valu.get('sub').toString();
            });
          }else{
            setState(() {
              selectt2=null;
              loc=true;
            });
          }
        });
      }
      if (selectt3 != null) {
        select = selectt.id;
        selectt3!.get().then((valu) {
          if (valu.exists) {
            setState(() {
              value = double.parse(valu.get('size').toString());
              min = value;
              addupdate = selectt3;
              _location3 = valu.get('sub').toString();
            });
          }else{
            setState(() {
              selectt3=null;
              loc=true;
            });
          }
        });
      }

      //print('$select+$selectedMake+$selectedMake1');
    });
    // Future.delayed(const Duration(milliseconds: 10)).then((value) {
    //   setState(() {

    //   });
    // });
    setState(() {
        load = false;
      });
  }
  

  @override
  void initState() {
    super.initState();
    _value_();
    // Future.delayed(Duration(seconds: 1)).then((value) {
    //   setState(() {
    //     load = false;
    //   });
    // });
  }

  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";
  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = '$scannedText ${line.text}';
        print('====${scannedText}');
        //  Text('any'+ scannedText,style: TextStyle(color:Colors.blue));
        //  temp[];
      }
    }
    _nameController.value = TextEditingValue(text: scannedText);
    textScanning = false;
    setState(() {});
  }

  bool status = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      // backgroundColor: screenbackgroundcolor,
      appBar: AppBar(
        shape: appbarshape(),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "E D I T",
          style: TextStyle(color: Colors.black87),
        ),
        leading: Tooltip(
          message: 'Exit',
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: Colors.red,
                size: 30,
              )),
        ),
      ),
      body: load
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.grey,
            ))
          : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    onChanged: () => setState(() {
                      status = true;
                    }),
                    key: _formkey3,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Center(
                          //     child: Row(
                          //   children: [
                          //     IconButton(
                          //         alignment: Alignment.topLeft,
                          //         onPressed: () {
                          //           Navigator.pop(context);
                          //         },
                          //         icon: Icon(Icons.arrow_back)),
                          //     SizedBox(
                          //       width: 115,
                          //     ),
                          //     Align(
                          //       alignment: Alignment.center,
                          //       child: Text("E D I T", style: headingstyle()),
                          //     ),
                          //   ],
                          // )),

                          Stack(children: [
                            Center(
                                child: _imagee == null
                                    ?
                                    //child:
                                    CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(dp.text),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        // backgroundColor: Colors.grey,
                                        backgroundImage: MemoryImage(_imagee!),
                                      )),
                            Positioned(
                                bottom: -10,
                                left: 200,
                                child: IconButton(
                                    onPressed: selectImage,
                                    splashColor: iconsplashcolor,
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: stableiconcolor,
                                    ))),
                          ]),
                          SizedBox(
                            height: height * 0.008,
                          ),
                          TextFormField(
                              cursorColor: cursorcolor,
                              style: textt(),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      try {
                                        await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 99)
                                            .then((valu) => valu!
                                                .readAsBytes()
                                                .then((value) => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                cropping(
                                                                    image:
                                                                        value))).then(
                                                        (imagee) async {
                                                      final tempDir =
                                                          await getTemporaryDirectory();
                                                      final tempFilePath =
                                                          "${tempDir.path}/temp_image.jpg"; // Adjust the extension as needed

                                                      final file = await File(
                                                              tempFilePath)
                                                          .writeAsBytes(imagee);
                                                      textScanning = true;
                                                      setState(() {
                                                        imageFile =
                                                            XFile(file.path);
                                                      });

                                                      setState(() {});
                                                      getRecognisedText(
                                                          imageFile!);
                                                    })));
                                        // final pickedImage =
                                        //     await ImagePicker().pickImage(source: source, imageQuality: 99);
                                        // if (pickedImage != null) {
                                        //   textScanning = true;
                                        //   imageFile = pickedImage;
                                        //   setState(() {});
                                        //   getRecognisedText(pickedImage);
                                        // }
                                      } catch (e) {
                                        textScanning = false;
                                        imageFile = null;
                                        scannedText =
                                            "$e Error occured while scanning";
                                        setState(() {});
                                      }
                                    },
                                    icon: const Icon(Icons.camera_alt)),
                                prefixIcon: const Icon(
                                  Icons.production_quantity_limits_outlined,
                                ),
                                enabledBorder: enabledadd(),
                                focusedBorder: focussadd(),
                                errorBorder: errorborderadd(),
                                focusedErrorBorder: errorfocusadd(),
                                hintStyle: labell(),
                                hintText: 'Product Name :',
                                fillColor: Colors.grey.shade100,
                                filled: true,
                              ),
                              controller: _nameController,
                              validator: (nameController) {
                                if (nameController!.isEmpty) {
                                  return "Enter Product Name";
                                }
                                return null;
                              }),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextFormField(
                            cursorColor: cursorcolor,
                            style: textt(),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.description),
                              enabledBorder: enabledadd(),
                              focusedBorder: focussadd(),
                              errorBorder: errorborderadd(),
                              focusedErrorBorder: errorfocusadd(),
                              hintStyle: labell(),
                              hintText: 'Product Description',
                              fillColor: Colors.grey.shade100,
                              filled: true,
                            ),
                            controller: _discrptionController,
                            // maxLines: 3,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          // TextFormField(
                          //     cursorColor: cursorcolor,
                          //     style: textt(),
                          //     decoration: InputDecoration(
                          //       enabledBorder: enabled(),
                          //       focusedBorder: focuss(),
                          //       labelStyle: labell(),
                          //       labelText: 'Name',
                          //     ),
                          //     controller: _nameController,
                          //     validator: (nameController) {
                          //       if (nameController!.isEmpty) {
                          //         return "Enter Product Name";
                          //       }
                          //       return null;
                          //     }),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Stocks')
                                  .snapshots(),
                              builder: (context, snapshots) {
                                List<DropdownMenuItem> stockItems = [];
                                // List<DropdownMenuItem> subItems = [];
                                if (!snapshots.hasData) {
                                  const CircularProgressIndicator();
                                } else {
                                  final Stock = snapshots.data?.docs.toList();
                                  //final sub = snapshots.data?.docs.toList();
                                  //print(Stock);
                                  // stockItems.add(DropdownMenuItem(
                                  //     value: "0",
                                  //     child: Text(
                                  //       'Select Category',
                                  //       style: TextStyle(color: dropdowntextcolor),
                                  //     )));
                                  Stock != null;
                                  for (var Stocks in Stock!) {
                                    stockItems.add(
                                      DropdownMenuItem(
                                        value: Stocks.id,
                                        child: Text(
                                          Stocks['Category'],
                                        ),
                                      ),
                                    );
                                  }
                                  // stockItems.add(DropdownMenuItem(
                                  //     //value: "0",
                                  //     child: TextField(
                                  //         cursorColor: Colors.orangeAccent,
                                  //         style:
                                  //             TextStyle(color: Colors.orangeAccent),
                                  //         decoration: InputDecoration(
                                  //           enabledBorder: UnderlineInputBorder(
                                  //             borderSide: BorderSide(
                                  //                 color: Colors.orangeAccent),
                                  //           ),
                                  //           focusedBorder: UnderlineInputBorder(
                                  //             borderSide: BorderSide(
                                  //                 color: Colors.orangeAccent),
                                  //           ),
                                  //           labelStyle:
                                  //               TextStyle(color: Colors.orangeAccent),
                                  //           labelText: 'Name',
                                  //         ))));
                                }
                                return DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.category_outlined,
                                      color: Colors.deepOrange,
                                    ),
                                    enabledBorder: enabledadd(),
                                    focusedBorder: focussadd(),
                                    errorBorder: errorborderadd(),
                                    focusedErrorBorder: errorfocusadd(),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                  ),
                                  elevation: 0,
                                  iconEnabledColor: dropdowniconenabledcolor,
                                  iconDisabledColor: dropdownicondisabledcolor,
                                  focusColor: dropdownfocuscolor,
                                  borderRadius: dropdownborder(),
                                  dropdownColor: Colors.grey.shade100,
                                  hint: Text(
                                    'Select Category',
                                    style: TextStyle(color: dropdowntextcolor),
                                  ),
                                  items: stockItems,
                                  onChanged: (StockValue) {
                                    setState(
                                      () {
                                        selectedStock = StockValue;
                                        // san();
                                      },
                                    );
                                    // print(StockValue);
                                    // print('result:$stockItems');

                                    // FirebaseFirestore.instance
                                    //     .collection('Stocks')
                                    //     .doc(selectedStock)
                                    //     .get()
                                    //     .then((DocumentSnapshot documentSnapshot) {
                                    //   print(documentSnapshot['email']);
                                    // });
                                    // print(selectedStock);
                                    //raja.doc('MLwAJxrPT6QXgsUwmFHD').get();
                                    //print(raja);
                                  },
                                  value: selectedStock,
                                  isExpanded: true,
                                  // validator: (selectedStock) {
                                  //   if (selectedStock == null &&
                                  //       selectedStock == 'Select Category') {
                                  //     return "Please Select Category";
                                  //   }
                                  //   return null;
                                  // },
                                );
                              }),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          /*TextField(
                      controller: _categoryController,
                      cursorColor: Colors.orangeAccent,
                      style: TextStyle(color: Colors.orangeAccent),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent),
                        ),
                        labelStyle: TextStyle(color: Colors.orangeAccent),
                        labelText: 'Category',
                      ),
                    ),*/
                          // TextField(
                          //   readOnly: true,
                          //   cursorColor: cursorcolor,
                          //   style: textt(),
                          //   controller: _dateController,
                          //   decoration: InputDecoration(
                          //     enabledBorder: enabled(),
                          //     focusedBorder: focuss(),
                          //     labelText: 'Date',
                          //     labelStyle: labell(),
                          //   ),
                          // ),
                          // TextFormField(
                          //     cursorColor: cursorcolor,
                          //     style: textt(),
                          //     controller: _locationController,
                          //     decoration: InputDecoration(
                          //         enabledBorder: enabled(),
                          //         focusedBorder: focuss(),
                          //         labelText: 'Location',
                          //         hintText: 'eg: A(01)',
                          //         hintStyle: hintt(),
                          //         labelStyle: labell()),
                          //     validator: (locationController) {
                          //       if (locationController!.isEmpty) {
                          //         return "Enter Correct Location";
                          //       }
                          //       return null;
                          //     }),
                          InkWell(
                            child: IgnorePointer(
                              child: TextFormField(
                                  readOnly: true,
                                  cursorColor: cursorcolor,
                                  style: textt(),
                                  controller: _locationController,
                                  decoration: InputDecoration(
                                    suffixIcon:loc? IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.question_mark_sharp,
                                        color: Colors.red,
                                      ),
                                    ):null,
                                    prefixIcon: const Icon(
                                      Icons.location_on,
                                      color: Colors.green,
                                    ),
                                    enabledBorder: enabledadd(),
                                    focusedBorder: focussadd(),
                                    errorBorder: errorborderadd(),
                                    focusedErrorBorder: errorfocusadd(),
                                    hintText: 'Location of product',
                                    hintStyle: labell(),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                  ),
                                  validator: (locationController) {
                                    if (locationController!.isEmpty) {
                                      return "Please select location";
                                    }
                                    if(loc){
                                      return 'Location not exits';
                                    }
                                    return null;
                                  }),
                            ),
                            onTap: () async {
                              double? valuec = await location();
                              if (valuec != null) {
                                setState(() {
                                  value = valuec;
                                  min = valuec;
                                });
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              // decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(30),
                              //     color: Colors.grey.shade100
                              //     ),
                              child: Row(
                                children: [
                                  Text(
                                    value.round().toString(),
                                    style: stabletextstyle(),
                                  ),
                                  Expanded(
                                    child: SliderTheme(
                                      data: SliderThemeData(
                                          overlappingShapeStrokeColor:
                                              colorrr(value),
                                          overlayShape:
                                              const RoundSliderOverlayShape(
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
                                          onChanged: (value) => setState(() {
                                                this.value = value;
                                                status = true;
                                              })),
                                    ),
                                  ),
                                  Text(
                                    max.round().toString(),
                                    style: stabletextstyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: TextFormField(
                                    cursorColor: cursorcolor,
                                    style: textt(),
                                    keyboardType: numberkeyboardtype(),
                                    controller: _qtyController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.numbers,
                                        color: Colors.deepOrange,
                                      ),
                                      enabledBorder: enabledadd(),
                                      focusedBorder: focussadd(),
                                      errorBorder: errorborderadd(),
                                      focusedErrorBorder: errorfocusadd(),
                                      hintText: 'Quantity',
                                      hintStyle: labell(),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                    ),
                                    validator: (qtyController) {
                                      if (qtyController!.isEmpty) {
                                        return "Enter Proper Number Of Quantity";
                                      }
                                      return null;
                                    }),
                              ),
                              SizedBox(
                                width: width * 0.4,
                                child: TextFormField(
                                    cursorColor: cursorcolor,
                                    style: textt(),
                                    keyboardType: numberkeyboardtype(),
                                    controller: _mqtyController,
                                    decoration: InputDecoration(
                                      enabledBorder: enabledadd(),
                                      focusedBorder: focussadd(),
                                      errorBorder: errorborderadd(),
                                      focusedErrorBorder: errorfocusadd(),
                                      hintText: 'Min.Quantity',
                                      hintStyle: labell(),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                    ),
                                    validator: (mqtyController) {
                                      if (mqtyController!.isEmpty) {
                                        return "Minimum Quantity Must Be Lesser Than Quantity";
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                          // TextFormField(
                          //     cursorColor: cursorcolor,
                          //     style: textt(),
                          //     keyboardType: numberkeyboardtype(),
                          //     controller: _qtyController,
                          //     decoration: InputDecoration(
                          //         enabledBorder: enabled(),
                          //         focusedBorder: focuss(),
                          //         labelText: 'Quantity',
                          //         hintText: 'In nos',
                          //         hintStyle: hintt(),
                          //         labelStyle: labell()),
                          //     validator: (qtyController) {
                          //       if (qtyController!.isEmpty) {
                          //         return "Enter Proper Number Of Quantity";
                          //       }
                          //       return null;
                          //     }),
                          // TextFormField(
                          //     cursorColor: cursorcolor,
                          //     style: textt(),
                          //     keyboardType: numberkeyboardtype(),
                          //     controller: _mqtyController,
                          //     decoration: InputDecoration(
                          //         enabledBorder: enabled(),
                          //         focusedBorder: focuss(),
                          //         labelText: 'mqty',
                          //         hintText: 'eg: 2 nos',
                          //         hintStyle: hintt(),
                          //         labelStyle: labell()),
                          //     validator: (mqtyController) {
                          //       if (mqtyController!.isEmpty) {
                          //         return "Minimum Quantity Must Be Lesser Than Quantity";
                          //       }
                          //       return null;
                          //     }),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Text('V E N D O R  D E T A I L S',
                                  style: stabletextstyle())),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: Colors.white,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                      cursorColor: cursorcolor,
                                      style: textt(),
                                      controller: _vendornameController,
                                      decoration: InputDecoration(
                                        enabledBorder: enabledadd(),
                                        focusedBorder: focussadd(),
                                        errorBorder: errorborderadd(),
                                        focusedErrorBorder: errorfocusadd(),
                                        hintText: 'Vendor Name',
                                        hintStyle: labelladd(),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                      ),
                                      validator: (vendornameController) {
                                        if (vendornameController!.isEmpty) {
                                          return "Vendor Name Is Must";
                                        }
                                        return null;
                                      }),
                                  SizedBox(height: height * 0.02),
                                  //
                                  TextFormField(
                                      cursorColor: cursorcolor,
                                      style: textt(),
                                      controller: _vendoradressController,
                                      decoration: InputDecoration(
                                        enabledBorder: enabledadd(),
                                        focusedBorder: focussadd(),
                                        errorBorder: errorborderadd(),
                                        focusedErrorBorder: errorfocusadd(),
                                        hintText: 'Address : ',
                                        hintStyle: labelladd(),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                      ),
                                      maxLines: 2,
                                      validator: (vendoradressController) {
                                        if (vendoradressController!.isEmpty) {
                                          return "Enter Proper Address Of Vendor";
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          child: TextFormField(
                                              cursorColor: cursorcolor,
                                              style: textt(),
                                              keyboardType:
                                                  numberkeyboardtype(),
                                              controller: _vendorphnoController,
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.phone,
                                                  color: Colors.green,
                                                ),
                                                enabledBorder: enabledadd(),
                                                focusedBorder: focussadd(),
                                                errorBorder: errorborderadd(),
                                                focusedErrorBorder:
                                                    errorfocusadd(),
                                                hintText: 'Phone no :',
                                                hintStyle: labelladd(),
                                                filled: true,
                                                fillColor: Colors.grey.shade100,
                                              ),
                                              maxLength: 10,
                                              validator:
                                                  (vendorphnoController) {
                                                if (vendorphnoController!
                                                    .isEmpty) {
                                                  return "Enter Proper Number";
                                                }
                                                return null;
                                              }),
                                        ),
                                        Container(
                                          width: width * 0.4,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                  cursorColor: cursorcolor,
                                                  style: textt(),
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                      Icons
                                                          .currency_rupee_rounded,
                                                      color: Colors.orange,
                                                    ),
                                                    enabledBorder: enabledadd(),
                                                    focusedBorder: focussadd(),
                                                    hintText: 'Price',
                                                    hintStyle: labelladd(),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.grey.shade100,
                                                    focusedErrorBorder:
                                                        errorfocusadd(),
                                                    errorBorder:
                                                        errorborderadd(),
                                                  ),
                                                  keyboardType:
                                                      numberkeyboardtype(),
                                                  controller: _priceController,
                                                  validator: (priceController) {
                                                    if (priceController!
                                                        .isEmpty) {
                                                      return "Enter The Correct Price";
                                                    }
                                                    return null;
                                                  }),
                                              SizedBox(
                                                height: height * 0.03,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 0.2,
                                  // )
                                ],
                              ),
                            ),
                          ),
                          // TextFormField(
                          //     cursorColor: cursorcolor,
                          //     style: textt(),
                          //     controller: _vendornameController,
                          //     decoration: InputDecoration(
                          //         enabledBorder: enabled(),
                          //         focusedBorder: focuss(),
                          //         labelText: 'Vendor Name',
                          //         labelStyle: labell()),
                          //     validator: (vendornameController) {
                          //       if (vendornameController!.isEmpty) {
                          //         return "Vendor Name Is Must";
                          //       }
                          //       return null;
                          //     }),
                          // TextFormField(
                          //     cursorColor: cursorcolor,
                          //     style: textt(),
                          //     controller: _vendoradressController,
                          //     decoration: InputDecoration(
                          //         enabledBorder: enabled(),
                          //         focusedBorder: focuss(),
                          //         labelText: 'Address',
                          //         labelStyle: labell()),
                          //     validator: (vendoradressController) {
                          //       if (vendoradressController!.isEmpty) {
                          //         return "Enter Proper Address Of Vendor";
                          //       }
                          //       return null;
                          //     }),
                          // TextFormField(
                          //     cursorColor: cursorcolor,
                          //     style: textt(),
                          //     keyboardType: numberkeyboardtype(),
                          //     controller: _vendorphnoController,
                          //     decoration: InputDecoration(
                          //         enabledBorder: enabled(),
                          //         focusedBorder: focuss(),
                          //         labelText: 'Phone no:',
                          //         hintText: '9551882448',
                          //         hintStyle: hintt(),
                          //         labelStyle: labell()),
                          //     maxLength: 10,
                          //     validator: (vendorphnoController) {
                          //       if (vendorphnoController!.isEmpty) {
                          //         return "Enter Proper Number";
                          //       }
                          //       return null;
                          //     }),
                          // TextFormField(
                          //     cursorColor: cursorcolor,
                          //     style: textt(),
                          //     decoration: InputDecoration(
                          //         enabledBorder: enabled(),
                          //         focusedBorder: focuss(),
                          //         labelText: 'Price',
                          //         labelStyle: labell()),
                          //     keyboardType: numberkeyboardtype(),
                          //     controller: _priceController,
                          //     validator: (priceController) {
                          //       if (priceController!.isEmpty) {
                          //         return "Enter The Correct Price";
                          //       }
                          //       return null;
                          //     }),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          // Center(
                          //     child:
                          //         Text('Q R  C O D E', style: stabletextstyle())),
                          // Center(
                          //   child: Card(
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(20)),
                          //     color: Colors.grey[100],
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(
                          //           left: 25, top: 15, bottom: 15),
                          //       child: Container(
                          //         height: MediaQuery.of(context).size.height * 0.2,
                          //         width: MediaQuery.of(context).size.width * 0.5,
                          //         child: QrImageView(
                          //           data: _nameController.text,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          /*Center(
                      child: Container(
                          color: barcodebackcolor,
                          child: QrImageView(
                              size: 200, data: _nameController.text)),
                    ),*/
                          Center(
                            child: ElevatedButton(
                              child: Text('Update', style: buttontextstyle()),
                              style: buttonstyle(),
                              onPressed: () async {
                                if (status || _imagee != null) {
                                  if (_formkey3.currentState!.validate()) {
                                    //final Category = _categoryController.text;
                                    final date = _dateController.text;
                                    final location = _locationController.text;
                                    // int quantity = int.parse(_qtyController.text);
                                    // int mqty = int.parse(_mqtyController.text);
                                    final quantity = _qtyController.text;
                                    final mqty = _mqtyController.text;
                                    final Vendorname =
                                        _vendornameController.text;
                                    final address =
                                        _vendoradressController.text;
                                    final phno = _vendorphnoController.text;
                                    final price = _priceController.text;
                                    final qr = _qr.text;
                                    bool img = false;
                                    final name = _nameController.text;
                                    try {
                                      Uint8List sample =
                                          _imagee!.buffer.asUint8List();
                                      await StoreData().saveData(file: sample);
                                    } catch (ee) {
                                      //print('$ee');
                                    }
                                    if (_imagee != null) {
                                      setState(() {
                                        img = true;
                                      });
                                    }
                                    if (selectedStock !=
                                        sanjay!.get('category')) {
                                      await _cato
                                          .doc(sanjay!.get('category'))
                                          .collection('productss')
                                          .doc(sanjay!.id)
                                          .delete();
                                    }
                                    await addupdate.update(
                                        {'size': value.round().toString()});
                                    await _cato
                                        .doc(selectedStock)
                                        .collection('productss')
                                        .doc(sanjay!.id)
                                        .set({
                                      "category": selectedStock,
                                      "des": _discrptionController.text,
                                      "name": name,
                                      "location": location,
                                      "quantity": quantity,
                                      "mqty": mqty,
                                      "vendorname": Vendorname,
                                      "address": address,
                                      "phoneno": phno,
                                      "price": price,
                                      "qrname": qr,
                                      "dp": img ? samm[0].toString() : dp.text,
                                      'print': sanjay!.get('print'),
                                      "date": date,
                                      'one': selectt,
                                      'two': selectt1,
                                      'three': selectt2,
                                      'four': selectt3,
                                    });

                                    await _log
                                        .doc(user!.uid)
                                        .collection('operations')
                                        .add({
                                      "category": selectedStock,
                                      "product": name,
                                      "date": date,
                                      'uid': user!.uid,
                                      "location": location,
                                      "quantity": quantity,
                                      "mqty": mqty,
                                      "vendorname": Vendorname,
                                      "address": address,
                                      "phoneno": phno,
                                      "price": price,
                                      'email': user!.email,
                                      'time': DateTime.now(),
                                      "operation": 'Edit',
                                      "pic": img ? samm[0].toString() : dp.text,
                                    }).then((value) {
                                         setState(() {
                                      _imagee = null;
                                    });
                                      Navigator.pop(context);
                                      
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        snacks(
                                            "The Product Has Been Edited Successfully"));} 
);

                                    // _nameController.text = '';
                                    // _categoryController.text = '';
                                    // _dateController.text = '';
                                    // _locationController.text = '';
                                    // _qtyController.text = '';
                                    // _mqtyController.text = '';
                                    // _vendornameController.text = '';
                                    // _vendoradressController.text = '';
                                    // _vendorphnoController.text = '';
                                    // _priceController.text = '';

                                 

                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     snacks("Please Select Category"));
                                    
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snacks("No changes made"));
                                }
                              },
                            ),
                          ),
                        ]),
                  ))),
    );
  }

//   void route() {
//     User? user = FirebaseAuth.instance.currentUser;
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.uid)
//         .get()
//         .then((DocumentSnapshot documentSnapshot) {
//       if (documentSnapshot.exists) {
//         if (documentSnapshot.get('role') == "Admin") {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const Admin(),
//             ),
//           );
//         }
//         if (documentSnapshot.get('role') == "Employee") {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const Employee(raja: false,),
//             ),
//           );
//         } else if (documentSnapshot.get('role') == "Manager") {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const Employee(raja: false,),
//             ),
//           );
//         }
//       } else {
//         print('Document does not exist on the database');
//       }
//     });
//   }
// }
}
