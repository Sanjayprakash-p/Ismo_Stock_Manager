// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Constants/Decorations.dart';
import '../Constants/colors.dart';
import '../Image/Image_Picker.dart';

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

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class ChatMessage {
  final String text;
  final String image;

  ChatMessage({
    required this.text,
    required this.image,
  });
}

class _ChatPageState extends State<ChatPage> {
  final DatabaseReference _messageRef =
      FirebaseDatabase.instance.reference().child('messages');
  final CollectionReference = FirebaseFirestore.instance.collection('bugs');
  Uint8List? _file;
  //List<ChatMessage> _messages = []; // Store chat messages
  final message = TextEditingController();

  get builder => null;
  Future<void> _selectImage() async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: dialogbackcolor,
          child: SizedBox(
            height: 80,
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
                    TextButton(
                      style: buttonstyle(),
                      onPressed: () async {
                        Navigator.pop(context);
                        try {
                          Uint8List file = await pickimage(ImageSource.gallery);
                          setState(() {
                            _file = file;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            snacks("Image Selected Successfully"),
                          );
                        } catch (er) {
                          setState(() {
                            // Handle error if needed
                          });
                        }
                      },
                      child: Text(
                        'gallery',
                        style: buttontextstyle(),
                      ),
                    ),
                    TextButton(
                      style: buttonstyle(),
                      onPressed: () async {
                        Navigator.pop(context);
                        try {
                          Uint8List file = await pickimage(ImageSource.camera);
                          setState(() {
                            _file = file;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            snacks(
                                "Image Has Been Chosen From Camera Successfully"),
                          );
                        } catch (e) {
                          setState(() {
                            // Handle error if needed
                          });
                        }
                      },
                      child: Text(
                        'Camera',
                        style: buttontextstyle(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // bottomOpacity: 0.5,
        // elevation: 0,
        title: Text(
          'CHAT',
          // style: headingstyle(),
          // TextStyle(letterSpacing: 5, color: Colors.black87),
        ),
        centerTitle: true,
        // backgroundColor: Colors.white,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   // icon: Icon(
        //   //   Icons.close,
        //   //   color: red,
        //   //   size: 35,
        //   // ),
        // ),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: CollectionReference.orderBy('time').snapshots(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      //reverse: true,
                      itemCount: snap.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot messages = snap.data!.docs[index];
                        Timestamp dat = messages['time'];
                        var format = DateFormat('dd-MM-yyyy (hh:mm:ss) a');
                        var date1 = format.format(dat.toDate()).toString();
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: ListTile(
                              tileColor: grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Text(
                                messages['text'],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black87),
                              ),
                              subtitle: Text(
                                date1,
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.black38),
                                textAlign: TextAlign.start,
                              ),
                              // Display the image if available
                              trailing: messages['pic'] != null
                                  ? InkWell(
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: SizedBox.square(
                                            child: Image.network(
                                                '${messages['pic']}'),
                                          ),
                                        ),
                                      ),
                                      child:
                                          Image.network('${messages['pic']}'),
                                    )
                                  : null),
                        );
                      },
                    ),
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _file != null
                    ? SizedBox.square(
                        child: Image.memory(_file!),
                      )
                    : SizedBox.shrink(),
                TextField(
                  controller: message,
                  // cursorColor: cursorcolor,
                  style: textt(),
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {
                        _selectImage();
                      },
                      icon: Icon(
                        Icons.attach_file,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (message.text.isNotEmpty) {
                          _controller.animateTo(
                            _controller.position.maxScrollExtent,
                            duration: const Duration(
                                milliseconds:
                                    500), // Adjust the duration as needed
                            curve: Curves.easeOut, // Adjust the curve as needed
                          );
                          var img;
                          if (_file != null) {
                            img = await uploadImageToStorage(
                                _file!, '${DateTime.now()}bug');
                            CollectionReference.add({
                              'text': message.text,
                              'time': DateTime.now(),
                              'pic': img[0].toString()
                            }).then((value) {
                              setState(() {
                                _file = null;
                              });
                              message.clear();
                              _controller.animateTo(
                                _controller.position.maxScrollExtent,
                                duration: const Duration(
                                    milliseconds:
                                        500), // Adjust the duration as needed
                                curve: Curves
                                    .easeOut, // Adjust the curve as needed
                              );
                            });
                          } else {
                            CollectionReference.add({
                              'text': message.text,
                              'pic': null,
                              'time': DateTime.now()
                            }).then((value) {
                              _file = null;
                              message.clear();
                              _controller.animateTo(
                                _controller.position.maxScrollExtent,
                                duration: const Duration(
                                    milliseconds:
                                        500), // Adjust the duration as needed
                                curve: Curves
                                    .easeOut, // Adjust the curve as needed
                              );
                            });
                          }
                        }
                      },
                      icon: Icon(Icons.send),
                      color: black,
                    ),
                    enabledBorder: reportborder(),
                    focusedBorder: reportborder(),
                    errorBorder: reportborder(),
                    focusedErrorBorder: reportborder(),
                    hintStyle: labell(),
                    hintText: 'Message',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Map<String, List<DocumentSnapshot>> groupMessagesByDate(
    List<DocumentSnapshot> messages) {
  Map<String, List<DocumentSnapshot>> groupedMessages = {};
  for (var message in messages) {
    DateTime messageDate = (message['time'] as Timestamp).toDate();
    String formattedDate =
        "${messageDate.year}-${messageDate.month}-${messageDate.day}";
    if (!groupedMessages.containsKey(formattedDate)) {
      groupedMessages[formattedDate] = [];
    }
    groupedMessages[formattedDate]!.add(message);
  }
  return groupedMessages;
}

class Message {
  final String text;
  String? image;

  Message({required this.text, required this.image});

  factory Message.fromMap(Map<dynamic, dynamic> map) {
    return Message(
      image: map['pic'] as String,
      text: map['text'] as String,
    );
  }
}
