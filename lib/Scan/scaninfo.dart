import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Read/Info_Page.dart';
import '../../Home/bottomnavigation.dart';

List stockItems = [];
String? pick;
Future<void> da(String getOutput) async {
  pick = getOutput;
}

class scaninfo extends StatefulWidget {
  const scaninfo({super.key});
  @override
  State<scaninfo> createState() => _scaninfoState();
}

class _scaninfoState extends State<scaninfo> {
  final _products = FirebaseFirestore.instance.collection('Stocks');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
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
                                      if (data['qrname'] == pick) {
                                        raj(data);
                                        Future.delayed(Duration.zero, () {
                                          Navigator.of(context).pushReplacement(
                                              FadeRoute(page: info()));
                                          /*Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => info(),
                                            ),
                                          );*/
                                        });
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    }
                                  }
                                }

                                return Container();
                              }),
                        ],
                      );
                    });
              }
            }));
  }
}
