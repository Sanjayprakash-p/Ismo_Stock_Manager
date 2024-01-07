import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Admin/permission.dart';
import 'package:flutter_application_2/CustomWidget/CircleProgressIndicator%202.dart';
import 'package:flutter_application_2/authentication/Sign_Up_Page.dart';
import '../Constants/Decorations.dart';
import '../Home/bottomnavigation.dart';
import '../Zoomer/pinch_zoom.dart';
import '../constants/colors.dart';

class Userdata extends StatefulWidget {
  const Userdata({super.key});

  @override
  State<Userdata> createState() => _UserdataState();
}

class _UserdataState extends State<Userdata> {
  // final CollectionReference _products =
  //     FirebaseFirestore.instance.collection('users');

  // final CollectionReference update = FirebaseFirestore.instance
  //     .collection('permissions')
  //     .doc('waiting')
  //     .collection('permission');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screenbackgroundcolor,
        appBar: AppBar(
            title: const Text('U S E R  D E T A I L S'),
            centerTitle: true,
            backgroundColor: appbarcolor),
        body: StreamBuilder(
            stream: ref1.orderBy('time', descending: true).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      if (documentSnapshot.get('login') == true &&
                          documentSnapshot.get('role') != 'Admin' &&
                          documentSnapshot.exists) {
                        /* return Slidable(
                          closeOnScroll: true,
                          endActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              backgroundColor: editcolor,
                              onPressed: (context) {},
                              icon: Icons.mode_edit_outlined,
                            )
                          ]),
                          startActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              backgroundColor: deletecolor,
                              onPressed: (context) {},
                              icon: Icons.delete_forever_outlined,
                            )
                          ]),
                          child: ListTile(
                            onTap: () {},
                            leading: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PinchZoomImage(
                                          sanj:
                                              documentSnapshot.get('profile'));
                                    });
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    documentSnapshot.get('profile')),
                              ),
                            ),
                            title: Text(
                              documentSnapshot['username'],
                              style: listtiletextstyle(),
                            ),
                            subtitle: Text(
                              documentSnapshot['role'],
                              style: listtiletextstyle(),
                            ),
                          ),
                        );*/
                        return Card(
                            shape: listtileshape(),
                            color: listtilecolor,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                                leading: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return PinchZoomImage(
                                              sanj: documentSnapshot
                                                  .get('profile'));
                                        });
                                  },
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        documentSnapshot.get('profile')),
                                  ),
                                ),
                                title: Text(
                                  documentSnapshot['username'],
                                  style: TextStyle(
                                      color: listtiletextcolor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  documentSnapshot['role'],
                                  style: TextStyle(
                                      color: listtiletextcolor, fontSize: 16),
                                ),
                                trailing: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: listtileiconcolor,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(FadeRoute(
                                          page: MyHomePage(
                                        raja: documentSnapshot,
                                      )));
                                    })));
                      }
                      return Container();
                    });
              }

              return const Center(
                child: CircleIndicator(),
              );
            }));
  }
}
