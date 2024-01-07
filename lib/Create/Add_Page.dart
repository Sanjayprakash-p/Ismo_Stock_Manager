//import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Constants/colors.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
import '../Image/Image_Picker.dart';
import '../authentication/Authentication.dart';
import '../constants/Decorations.dart';

List samm = [];
String error = '';
String result = '';
bool res = false;

class StoreData {
  Future<List> uploadImageToStorage(Uint8List sam, String sa) async {
    // Reference ref = _storage.ref().child(ku);
    //UploadTask uploadTask = ref.putData(file);
    //TaskSnapshot snapshot2 = await uploadTask;
    //String downloadUrl = await snapshot2.ref.getDownloadURL();
    Reference ref1 = FirebaseStorage.instance.ref().child(sa);
    UploadTask uploadTask2 = ref1.putData(sam);
    TaskSnapshot snapshot1 = await uploadTask2;
    String down = await snapshot1.ref.getDownloadURL();
    return [down];
  }

  Future<String> saveData({
    required Uint8List pick,
    required String sa,
  }) async {
    String resp = " some error Occured";
    try {
      {
        List san = await uploadImageToStorage(pick, sa);
        samm = san;
        resp = 'sucess';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}

class crtprd extends StatefulWidget {
  crtprd({super.key});
  @override
  State<crtprd> createState() => _crtprdState();
}

class _crtprdState extends State<crtprd> {
  bool visible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  // final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _mqtyController = TextEditingController();
  final TextEditingController _vendornameController = TextEditingController();
  final TextEditingController _vendoradressController = TextEditingController();
  final TextEditingController _vendorphnoController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discrptionController = TextEditingController();

  final _formkey2 = GlobalKey<FormState>();
  Uint8List? _file;
  var datee = DateTime.now();
  Future selectImage() async {
    return showDialog(
      context: context,
      builder: ((context) {
        return Dialog(
          backgroundColor: dialogbackcolor,
          child: SizedBox(
            height: 100,
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Select Image',
                  style: stabletextstyle(),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          try {
                            Uint8List file =
                                await pickimage(ImageSource.gallery);
                            setState(() {
                              _file = file;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                snacks("Image Selected Successfully"));
                          } catch (er) {
                            setState(() {
                              error2 = 'Please Select Image';
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.photo_size_select_actual_rounded,
                              size: 40,
                              color: black,
                            ),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: black,
                              ),
                            ),
                            // TextButton(
                            //   style: buttonstyle(),
                            //   onPressed: () async {
                            //     Navigator.pop(context);
                            //     try {
                            //       Uint8List file =
                            //           await pickimage(ImageSource.gallery);
                            //       setState(() {
                            //         _file = file;
                            //       });
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           snacks("Image Selected Successfully"));
                            //     } catch (er) {
                            //       setState(() {
                            //         error2 = 'Please Select Image';
                            //       });
                            //     }
                            //   },
                            //   child: Text(
                            //     'gallery',
                            //     style: buttontextstyle(),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          try {
                            Uint8List file =
                                await pickimage(ImageSource.camera);
                            setState(() {
                              _file = file;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(snacks(
                                "Image Has Been Choosed From Camera Successfully"));
                          } catch (e) {
                            setState(() {
                              error2 = 'Please Select Image';
                            });
                            // print('No camera image selected');
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: black,
                              size: 40,
                            ),
                            Text(
                              'Camera',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: black,
                              ),
                            )
                          ],
                        ),
                      ),
                      // IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt,color: black,)),
                      // TextButton(
                      //   style: buttonstyle(),
                      //   onPressed: () async {
                      //     Navigator.pop(context);
                      //     try {
                      //       Uint8List file =
                      //           await pickimage(ImageSource.camera);
                      //       setState(() {
                      //         _file = file;
                      //       });
                      //       ScaffoldMessenger.of(context).showSnackBar(snacks(
                      //           "Image Has Been Choosed From Camera Successfully"));
                      //     } catch (e) {
                      //       setState(() {
                      //         error2 = 'Please Select Image';
                      //       });
                      //       // print('No camera image selected');
                      //     }
                      //   },
                      //   child: Text(
                      //     'Camera',
                      //     style: buttontextstyle(),
                      //   ),
                      // ),
                    ]),
              ],
            ),
          ),
        );
      }),
    );
  }

  final _products = FirebaseFirestore.instance.collection('Stocks');
  final _analysis = FirebaseFirestore.instance.collection('Analysis');
  final _log = FirebaseFirestore.instance.collection('All Users Data');
  final key = GlobalKey();
  String? selectedStock;

  bool loading = false;
  var error2 = '';
  final User? user = Auth().currentUser;
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
  CollectionReference ref1 = FirebaseFirestore.instance.collection('location');
  List<String> suggestions = [];
  search(query) async {
    setState(() {
      res = true;
    });
    final snap = await FirebaseFirestore.instance.collection('Stocks').get();
    QuerySnapshot? querySnapshot;
    for (QueryDocumentSnapshot doc in snap.docs) {
      querySnapshot = await doc.reference
          .collection('productss')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + 'z')
          .get();
    }
    if (querySnapshot!.docs.isNotEmpty) {
      for (var document in querySnapshot.docs) {
        suggestions.add(document['name'].toString());
      }
    }
    setState(() {
      // Set suggestions after processing all documents
      suggestions = suggestions.toSet().toList();
      // Remove duplicates if necessary
    });

    setState(() {
      res = false;
    });
  }

  Future<void> _cropImage(XFile img) async {
    CroppedFile? _croppedFile;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: img.path,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 520,
            height: 520,
          ),
          viewPort:
              const CroppieViewPort(width: 480, height: 480, type: 'circle'),
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _croppedFile = croppedFile;
      });
      if (_croppedFile != null) {
        _file = await _croppedFile!.readAsBytes();
      }
      setState(() {});
    }
  }

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
                                    }),
                                  });
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
                          final Stock = snapshots.data?.docs.toList();
                          if (Stock != null) {
                            for (var Stocks in Stock) {
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
                                    }),
                                  });
                            },
                            value: selectt3,
                          );
                        }),
                    TextButton(
                        onPressed: () {
                          sta(() {
                            _locationController.value =
                                TextEditingValue(text: '${_loc ?? ''}');
                            value = value;
                          });

                          Navigator.of(context).pop(value1);
                        },
                        child: const Text('Done'))
                  ],
                ),
              )));

  bool hasinternet = false;
  // late StreamSubscription subscription;
  // late StreamSubscription _subscription;
  final TextEditingController _textcontroller = TextEditingController();
  // final text = scannedText;
  bool textScanning = false;

  XFile? imageFile;
  bool change = false;
  String scannedText = "";

  @override
  void initState() {
    setState(() {
      //select = 'TPm7a9CQwRT1ryd4dCRx';
    });
    super.initState();
    // subscription =
    //     Connectivity().onConnectivityChanged.listen(_showconnectionSnackbar);
    // _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
    //   final hasinternet = status == InternetConnectionStatus.connected;
    //   setState(() => this.hasinternet = hasinternet);
    // });
  }
  //  late StreamSubscription<InternetStatus> _subscription;

  // @override
  // void initState() {
  //   super.initState();
  //   _subscription = InternetConnection().onStatusChange.listen((status) {
  //     setState(() {
  //       _connectionStatus = status;
  //     });
  //   });
  // }
  void getRecognisedText(XFile image, TextEditingController control) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = '$scannedText ${line.text}';
        print('====${scannedText}');
      }
    }
    control.value = TextEditingValue(text: scannedText);
    textScanning = false;
    setState(() {});
  }
//  Future selectImage1() async {
//     return showDialog(
//       context: context,
//       builder: ((context) {
//         return Dialog(
//           backgroundColor: dialogbackcolor,
//           child: SizedBox(
//             height: 80,
//             width: 60,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'Select Image',
//                   style: stabletextstyle(),
//                 ),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       TextButton(
//                         style: buttonstyle(),
//                         onPressed: () async {
//                           Navigator.pop(context);
//                                      try {
//                             await ImagePicker()
//           .pickImage(source: ImageSource.camera, imageQuality: 99)
//           .then((img) => ImageCropper().cropImage(
//                 sourcePath: img!.path,
//                 compressFormat: ImageCompressFormat.png,
//                 compressQuality: 100,
//                 uiSettings: [
//                   // android
//                   AndroidUiSettings(
//                       toolbarTitle: 'Cropper',
//                       toolbarColor: Colors.black,
//                       toolbarWidgetColor: Colors.white,
//                       initAspectRatio: CropAspectRatioPreset.original,
//                       lockAspectRatio: false),
//                   // ios
//                   IOSUiSettings(
//                     title: 'Cropper',
//                   ),
//                   // web
//                   WebUiSettings(
//                     context: context,
//                     presentStyle: CropperPresentStyle.dialog,
//                     boundary: const CroppieBoundary(
//                       width: 520,
//                       height: 520,
//                     ),
//                     viewPort: const CroppieViewPort(
//                         width: 480, height: 480, type: 'circle'),
//                     enableExif: true,
//                     enableZoom: true,
//                     showZoomer: true,
//                   ),
//                 ],
//               ).then(
//                   (image) => getRecognisedText(XFile(image!.path), control)));
//                           } catch (e) {
//                               textScanning = false;
//       imageFile = null;
//       scannedText = "$e Error occured while scanning";
//       setState(() {});
//                           }
//                         },
//                         child: Text(
//                           'gallery',
//                           style: buttontextstyle(),
//                         ),
//                       ),
//                       TextButton(
//                         style: buttonstyle(),
//                         onPressed: () async {
//                           Navigator.pop(context);
//                           try {
//                             await ImagePicker()
//           .pickImage(source: ImageSource.camera, imageQuality: 99)
//           .then((img) => ImageCropper().cropImage(
//                 sourcePath: img!.path,
//                 compressFormat: ImageCompressFormat.png,
//                 compressQuality: 100,
//                 uiSettings: [
//                   // android
//                   AndroidUiSettings(
//                       toolbarTitle: 'Cropper',
//                       toolbarColor: Colors.black,
//                       toolbarWidgetColor: Colors.white,
//                       initAspectRatio: CropAspectRatioPreset.original,
//                       lockAspectRatio: false),
//                   // ios
//                   IOSUiSettings(
//                     title: 'Cropper',
//                   ),
//                   // web
//                   WebUiSettings(
//                     context: context,
//                     presentStyle: CropperPresentStyle.dialog,
//                     boundary: const CroppieBoundary(
//                       width: 520,
//                       height: 520,
//                     ),
//                     viewPort: const CroppieViewPort(
//                         width: 480, height: 480, type: 'circle'),
//                     enableExif: true,
//                     enableZoom: true,
//                     showZoomer: true,
//                   ),
//                 ],
//               ).then(
//                   (image) => getRecognisedText(XFile(image!.path), control)));
//                           } catch (e) {
//                               textScanning = false;
//       imageFile = null;
//       scannedText = "$e Error occured while scanning";
//       setState(() {});
//                           }
//                         },
//                         child: Text(
//                           'Camera',
//                           style: buttontextstyle(),
//                         ),
//                       ),
//                     ]),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }

  Future<bool> showExitAlertDialog(BuildContext context) async {
    return await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: AlertDialog(
                    title: const Text('Are You Sure?'),
                    content: const Text('your Progress remains unsaved'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Yes')),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('No')),
                    ],
                  ),
                )) ??
        false;
  }

  Future<void> textrec(TextEditingController control) async {
    try {
      await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 99)
          .then((img) => ImageCropper().cropImage(
                sourcePath: img!.path,
                compressFormat: ImageCompressFormat.png,
                compressQuality: 100,
                uiSettings: [
                  // android
                  AndroidUiSettings(
                      toolbarTitle: 'Cropper',
                      toolbarColor: Colors.black,
                      toolbarWidgetColor: Colors.white,
                      initAspectRatio: CropAspectRatioPreset.original,
                      lockAspectRatio: false),
                  // ios
                  IOSUiSettings(
                    title: 'Cropper',
                  ),
                  // web
                  WebUiSettings(
                    context: context,
                    presentStyle: CropperPresentStyle.dialog,
                    boundary: const CroppieBoundary(
                      width: 520,
                      height: 520,
                    ),
                    viewPort: const CroppieViewPort(
                        width: 480, height: 480, type: 'circle'),
                    enableExif: true,
                    enableZoom: true,
                    showZoomer: true,
                  ),
                ],
              ).then(
                  (image) => getRecognisedText(XFile(image!.path), control)));
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "$e Error occured while scanning";
      setState(() {});
    }
  }

  List<String> filteredSuggestions = [];
  @override
  Widget build(BuildContext context) {
    var format = DateFormat('dd-MM-yyyy (hh:mm:ss)');
    setState(() {
      _dateController.text = format.format(DateTime.now());
      error = '';
    });
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Stream<List<QueryDocumentSnapshot>>? _searchStream;
    bool _isTextFieldVisible = false;
    Stream<List<QueryDocumentSnapshot>> _getSearchStream(String searchText) {
      return FirebaseFirestore.instance
          .collection('Stocks')
          .get()
          .then((mainCollectionSnapshot) async {
        List<QueryDocumentSnapshot> searchResults = [];

        for (QueryDocumentSnapshot mainDocument
            in mainCollectionSnapshot.docs) {
          final subcollectionQuery =
              await mainDocument.reference.collection('productss').get();
          for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
              in subcollectionQuery.docs) {
            if (documentSnapshot['vendorname']
                .toString()
                .toLowerCase()
                .startsWith(searchText.toLowerCase())) {
              print('result==${documentSnapshot['vendorname']}');
              searchResults.add(documentSnapshot);
            }
            setState(() {
              result = 'No result';
            });
          }
        }

        return searchResults;
      }).asStream();
    }

    void _startSearch(String searchText) {
      if (searchText.isEmpty) {
        setState(() {
          result = 'Search';
          _searchStream = null;
        });
      } else {
        setState(() {
          _searchStream = _getSearchStream(searchText);
        });
      }
    }

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
            icon: Icon(
              Icons.close,
              color: red,
              size: 35,
            )),
        title: Text("ADD PRODUCT", style: headingstyle()),
      ),
      extendBody: true,
      // backgroundColor: screenbackgroundcolor,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  onChanged: () => setState(() {
                    change = true;
                  }),
                  onWillPop: () async {
                    if (change) {
                      return showExitAlertDialog(context);
                    } else {
                      return true;
                    }
                  },
                  key: _formkey2,
                  child: Stack(children: [
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     SizedBox(),
                    //     Opacity(
                    //       opacity: 0.5,
                    //       child: Image.asset("assets/logo_transparent.png"),
                    //     ),
                    //   ],
                    // ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          SizedBox(
                            height: height * 0.008,
                          ),
                          Center(
                              child: _file != null
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: MemoryImage(_file!),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundColor: defaultcircleavatarcolor,
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
                        Center(
                            child: Text(
                          error2,
                          style: TextStyle(color: errortextcolor),
                        )),
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
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            textrec(_nameController),
                                        icon: const Icon(Icons.camera_alt),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons
                                            .production_quantity_limits_outlined,
                                      ),
                                      enabledBorder: enabledadd(),
                                      focusedBorder: focussadd(),
                                      errorBorder: errorborderadd(),
                                      focusedErrorBorder: errorfocusadd(),
                                      hintStyle: labell(),
                                      hintText: 'Product Name:',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                    ),
                                    validator: (nameController) {
                                      if (nameController!.isEmpty) {
                                        return "Enter product name";
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
                                    hintText: '\nProduct Description',
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                  ),
                                  controller: _discrptionController,
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: _products.snapshots(),
                                    builder: (context, snapshots) {
                                      List<DropdownMenuItem> stockItems = [];
                                      // List<DropdownMenuItem> subItems = [];
                                      if (!snapshots.hasData) {
                                        const CircularProgressIndicator();
                                      } else {
                                        final Stock =
                                            snapshots.data?.docs.toList();
                                        Stock != null;
                                        for (var Stocks in Stock!) {
                                          stockItems.add(DropdownMenuItem(
                                              value: Stocks.id,
                                              child: Text(
                                                Stocks['Category'],
                                                style: textt(),
                                              )));
                                        }
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
                                        iconEnabledColor:
                                            dropdowniconenabledcolor,
                                        iconDisabledColor:
                                            dropdownicondisabledcolor,
                                        focusColor: dropdownfocuscolor,
                                        borderRadius: dropdownborder(),
                                        dropdownColor: Colors.grey.shade100,
                                        hint: Text(
                                          'Select Category',
                                          style: TextStyle(
                                              color: dropdowntextcolor),
                                        ),
                                        items: stockItems,
                                        onChanged: (StockValue) {
                                          setState(() {
                                            selectedStock = StockValue;
                                            // san();
                                          });
                                        },
                                        value: selectedStock,
                                        isExpanded: true,
                                        validator: (selectedStock) {
                                          if (selectedStock == null) {
                                            return "Please Select Category";
                                          }
                                          return null;
                                        },
                                      );
                                    }),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                InkWell(
                                  child: IgnorePointer(
                                    child: TextFormField(
                                        readOnly: true,
                                        cursorColor: cursorcolor,
                                        style: textt(),
                                        controller: _locationController,
                                        decoration: InputDecoration(
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
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
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
                                              valueIndicatorColor:
                                                  colorrr(value)),
                                          child: Slider(
                                              min: min,
                                              max: max,
                                              value: value,
                                              divisions: divisions,
                                              label: value.round().toString(),
                                              onChanged: (value) => setState(
                                                  () => this.value = value)),
                                        ),
                                      ),
                                      Text(
                                        max.round().toString(),
                                        style: stabletextstyle(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        Center(
                            child: Text('V E N D O R  D E T A I L S',
                                style: stabletextstyle())),
                        SizedBox(height: height * 0.008),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.white,
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                EasyAutocomplete(
                                    controller: _vendornameController,
                                    suggestions: suggestions,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () =>
                                              textrec(_vendornameController),
                                          icon: const Icon(Icons.camera_alt)),
                                      enabledBorder: enabledadd(),
                                      focusedBorder: focussadd(),
                                      errorBorder: errorborderadd(),
                                      focusedErrorBorder: errorfocusadd(),
                                      hintStyle: labell(),
                                      hintText: 'vendor Name',
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                    ),
                                    debounceDuration:
                                        const Duration(milliseconds: 300),
                                    suggestionBuilder: (data) {
                                      return Container(
                                          margin: const EdgeInsets.all(1),
                                          padding: const EdgeInsets.all(15),
                                          child: Text(data,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)));
                                    },
                                    onChanged: (value) async => {
                                          _getSearchStream(value).listen((List<
                                                  QueryDocumentSnapshot<
                                                      Object?>>
                                              searchResults) {
                                            suggestions.clear();
                                            for (QueryDocumentSnapshot<
                                                    dynamic?> documentSnapshot
                                                in searchResults) {
                                              final name = documentSnapshot
                                                      .data()?['vendorname']
                                                  as String?;
                                              if (name != null) {
                                                suggestions.add(name);
                                              }
                                            }
                                            setState(() {
                                              result = suggestions.isEmpty
                                                  ? 'No result'
                                                  : 'Results found';
                                            });
                                          })
                                        }),
                                SizedBox(height: height * 0.02),
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
                                      suffixIcon: IconButton(
                                          onPressed: () =>
                                              textrec(_vendoradressController),
                                          icon: const Icon(Icons.camera_alt)),
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
                                            keyboardType: numberkeyboardtype(),
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
                                            validator: (vendorphnoController) {
                                              if (vendorphnoController!
                                                  .isEmpty) {
                                                return "Enter Proper Number";
                                              }
                                              return null;
                                            }),
                                      ),
                                      SizedBox(
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
                                                  errorBorder: errorborderadd(),
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
                              ],
                            ),
                          ),
                        ),
                        // buildInternetStatus(),
                        Center(
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                                maximumSize: Size(450, height),
                                fixedSize: Size(width, 50)),

                            label: const Text(
                              'Create Product',
                            ),

                            icon: const Icon(Icons.add),
                            // style: buttonstyle(),
                            onPressed: () async {
                              if (_formkey2.currentState!.validate() &&
                                  _file != null) {
                                if (_formkey2.currentState!.validate() &&
                                    selectedStock != null) {
                                  setState(() {
                                    error = '';
                                  });
                                  if (loading) return;
                                  setState(() => loading = true);

                                  Uint8List sample = _file!;

                                  await StoreData().saveData(
                                    pick: sample,
                                    sa: "$datee" + "product",
                                  );
                                  final name = _nameController.text;
                                  final date = _dateController.text;
                                  final location = _locationController.text;
                                  final quantity = _qtyController.text;
                                  final mqty = _mqtyController.text;
                                  final Vendorname = _vendornameController.text;
                                  final address = _vendoradressController.text;
                                  final phno = _vendorphnoController.text;
                                  final price = _priceController.text;
                                  final desc = _discrptionController.text;
                                  {
                                    await _analysis
                                        .doc()
                                        .collection(_nameController.text)
                                        .add({
                                      "quantity": quantity,
                                      "date": date,
                                      "vendorname": Vendorname,
                                      "address": address,
                                      "phoneno": phno,
                                      "price": price,
                                    });
                                    await _products
                                        .doc(selectedStock)
                                        .collection('productss')
                                        .add({
                                      "category": selectedStock,
                                      "name": name,
                                      "des": desc,
                                      "date": date +
                                          Random().nextInt(100).toString(),
                                      "location": location,
                                      "quantity": quantity,
                                      "mqty": mqty,
                                      "vendorname": Vendorname,
                                      "address": address,
                                      "phoneno": phno,
                                      "price": price,
                                      'dp': samm[0],
                                      'print': false,
                                      'qrname': datee.toString(),
                                      'one': selectt,
                                      'two': selectt1,
                                      'three': selectt2,
                                      'four': selectt3,
                                    });

                                    await _log
                                        .doc(user!.uid)
                                        .collection('operations')
                                        .add({
                                      'product': name,
                                      'email': user!.email,
                                      'uid': user!.uid,
                                      'time': datee,
                                      'vendor': Vendorname,
                                      "quantity": quantity,
                                      "category": selectedStock,
                                      "location": location,
                                      "operation": 'Add',
                                      "size": value,
                                      "pic": samm[0]
                                    });
                                    await addupdate.update(
                                        {'size': value.round().toString()});

                                    _nameController.text = '';
                                    _discrptionController.text = '';
                                    _dateController.text = '';
                                    _locationController.text = '';
                                    _qtyController.text = '';
                                    _mqtyController.text = '';
                                    _vendornameController.text = '';
                                    _vendoradressController.text = '';
                                    _vendorphnoController.text = '';
                                    _priceController.text = '';
                                    if (!mounted) return;
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        snacks(
                                            "New Product Has Been Created Successfully"));
                                  }
                                }
                              } else {
                                setState(() {
                                  error2 = "Please Select Image";
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
    );
  }

  Column buildInternetStatus() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasinternet ? Icons.done : Icons.error,
              color: hasinternet ? Colors.green : Colors.red,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(hasinternet ? 'Internet available' : "Internet not available")
          ],
        )
      ],
    );
  }

  Future share() async {
    // File? file;
    // final key = GlobalKey();
    // RepaintBoundary(
    //     key: key,
    //     child: Container(
    //       color: Colors.grey[100],
    //       child: QrImageView(
    //         size: 100,
    //         data: sanjay!.get('qrname').toString(),
    //       ),
    //     ),
    // );
    print('jeajfasiodjfoads');
    try {
      // RenderRepaintBoundary boundary =
      //     key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // var image = await boundary.toImage(pixelRatio: 20.0);
      // ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      // Uint8List pngBytes = byteData!.buffer.asUint8List();
      // final appDir = await getApplicationDocumentsDirectory();
      // var datetime = DateTime.now();
      // file = await File('${appDir.path}/$datetime.png').create();
      // await file?.writeAsBytes(pngBytes);
      // await Share.shareFiles(
      //   [file!.path],
      //   mimeTypes: ["image/png"],
      //   text: 'Product Name:${sanjay!.get("name")}',
      // );
    } catch (e) {
      print(e.toString());
    }
  }
}

// ignore: unused_element
void _showconnectionSnackbar(ConnectivityResult result) {
  final hasinternet = result != ConnectivityResult.none;
  final message = hasinternet
      ? result == ConnectivityResult.mobile
          ? print('You are connected to mobile network')
          : print('You are connected to wifi network')
      : const ScaffoldMessenger(child: SnackBar(content: Text('No internet')));
}

class cropping extends StatefulWidget {
  Uint8List image;
  cropping({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<cropping> createState() => _croppingState();
}

class _croppingState extends State<cropping> {
  final CropController _controller = CropController();
  Uint8List? val;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Crop(
                    interactive: true,
                    initialSize: 1,
                    onStatusChanged: (status) => setState(() {
                          var statusText = <CropStatus, String>{
                                CropStatus.nothing: 'Crop has no image data',
                                CropStatus.loading:
                                    'Crop is now loading given image',
                                CropStatus.ready: 'Crop is now ready!',
                                CropStatus.cropping:
                                    'Crop is now cropping image',
                              }[status] ??
                              '';
                          print(statusText);
                        }),
                    baseColor: Colors.white10,
                    radius: 20,
                    progressIndicator: const CircularProgressIndicator(),
                    image: widget.image,
                    cornerDotBuilder: (size, edgeAlignment) => const DotControl(
                          padding: 10,
                        ),
                    controller: _controller,
                    onCropped: (onCropped) {
                      setState(() {
                        widget.image = onCropped;
                      });
                    }),
              ),
            ),
            TextButton(
              onPressed: () {
                _controller.crop();
              },
              child: const Text('Crop'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(widget.image);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
