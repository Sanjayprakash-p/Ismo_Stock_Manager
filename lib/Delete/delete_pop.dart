import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../Authentication/Authentication.dart';
import '../constants/Decorations.dart';

class deletepop extends StatefulWidget {
  DocumentSnapshot snap;
  //CollectionReference col;
  deletepop({
    Key? key,
    required this.snap,
    // required this.col,
  }) : super(key: key);

  @override
  State<deletepop> createState() => _deletepopState();
}

class _deletepopState extends State<deletepop> {
  final _log = FirebaseFirestore.instance.collection('All Users Data');
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return
        //  Dialog(
        //   child:
        Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.white),
      height: height * 0.25,
      width: width * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Lottie.network(
                  'https://lottie.host/ae1f47fd-3c68-4e46-85eb-88253269a63c/WIUNUZJBfG.json',
                  width: 60,
                  height: 60),
            ),
            Container(
              child: Text(
                'Do you want to delete this',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              // ),
            ),
            Container(
              child: Text(
                ' product ?',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Colors.red
                  ),
                  child: TextButton(
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 245, 2, 2),
                      ),
                    ),
                    onPressed: () async {
                      await widget.snap.reference.delete();
                      // await FirebaseStorage.instance.refFromURL(widget.snap['dp']).delete();
                      // await widget.col.doc(widget.snap.id).delete();
                      await _log.doc(user!.uid).collection('operations').add({
                        'product': widget.snap.get('name'),
                        'uid': user!.uid,
                        'email': user!.email,
                        'time': DateTime.now(),
                        "category": widget.snap.get('category'),
                        "operation": 'Delete',
                        "pic": widget.snap.get('dp'),
                      }).then((value) { Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(snacks(
                          "${widget.snap.get('name')} Has Been Deleted"));});
                     
                    },
                  ),
                ),
                Container(
                  width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.transparent,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // );
  }
}
