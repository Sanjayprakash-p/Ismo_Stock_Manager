import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Read/Info_Page.dart';
import 'package:image_picker/image_picker.dart';

import '../Constants/colors.dart';

import '../Create/Add_Page.dart';
import '../Image/Image_Picker.dart';
import '../authentication/Authentication.dart';
import '../constants/Decorations.dart';


final User? user = Auth().currentUser;
final _log = FirebaseFirestore.instance.collection('All Users Data');

class categoryedit extends StatefulWidget {
  final DocumentSnapshot snapshot;
  const categoryedit({
    Key? key,
    required this.snapshot,
  }) : super(key: key);
  @override
  State<categoryedit> createState() => _categoryeditState();
}

class _categoryeditState extends State<categoryedit> {
  Future selectImage() async {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            shape:               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
,
              backgroundColor: dialogbackcolor,
              title:   Text(
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
                          Uint8List file =
                              await pickimage(ImageSource.gallery);
                          setState(() {
                            _file = file;
                          });
                        } catch (er) {
                          setState(() {
                            _file = null;
                          });
                        }
                      },
                      child:const Icon(Icons.image,color: Colors.white,),
                    ),
                    TextButton(
                        style: buttonstyle(),
                        onPressed: () async {
                          Navigator.pop(context);
                          try {
                            Uint8List file =
                                await pickimage(ImageSource.camera);
                            setState(() {
                              _file = file;
                            });
                          } catch (e) {
                            setState(() {
                              _file = null;
                            });
                          }
                        },
                        child:const Icon(Icons.camera_alt,color: Colors.white,)
                        ),
                        //  TextButton(
                        // style: buttonstyle(),
                        // onPressed: () async {
                        //   setState(() {
                        //     loading=true;
                        //   });
                        //   await  widget.snapshot.reference.update({'image':null}).then((value) {    
                        // setState(() {
                        //   _file=null;
                        //  loading=false;
                        // });Navigator.pop(context);
                        // });
                        
                       
                        // },
                        // child:const Icon(Icons.remove_circle,color: Colors.white,)
                        // )
                  ]));
        }));
  }

  final _formkey2 = GlobalKey<FormState>();
  bool loading = false;
  Uint8List? _file;
  bool visible = false;
  var datee = DateTime.now();
  final TextEditingController _categoryController = TextEditingController();
  final _cato = FirebaseFirestore.instance.collection('Stocks');

  @override
  void initState() {
    _categoryController.text = widget.snapshot['Category'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        // backgroundColor: screenbackgroundcolor,
        /* appBar: AppBar(
          shape: appbarshape(),
          backgroundColor: appbarcolor,
          title: Text(
            "Add Category",
          ),
          centerTitle: true,
        ),*/
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      onChanged: () => setState(() {
                        visible=true;
                      }),
                        key: _formkey2,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      alignment: Alignment.topLeft,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back)),
                                  SizedBox(
                                    width: 43,
                                  ),
                                  Text("EDIT CATEGORY", style: headingstyle()),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Stack(children: [
                                Center(
                                    child: _file == null&&widget.snapshot['image']!=null 
                                        ? CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                                widget.snapshot['image']),
                                          )
                                        : _file==null? CircleAvatar(
                                            radius: 50,
                                            backgroundColor:
                                                defaultcircleavatarcolor,
                                          ):CircleAvatar(
                                            radius: 50,
                                            backgroundImage:
                                                MemoryImage(_file!),
                                          )
                                          ),
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
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  cursorColor: cursorcolor,
                                  style: textt(),
                                  controller: _categoryController,
                                  decoration: InputDecoration(
                                    enabledBorder: enabledadd(),
                                    focusedBorder: focussadd(),
                                    errorBorder: errorborderadd(),
                                    focusedErrorBorder: errorfocusadd(),
                                    hintText: 'Category',
                                    hintStyle: labell(),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                  ),
                                  validator: (_categoryController) {
                                    if (_categoryController!.isEmpty) {
                                      return "Enter Category Name";
                                    }
                                    if (_categoryController.length < 3) {
                                      return 'Length should min 3';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: ElevatedButton(
                                  style: buttonstyle(),
                                  onPressed: () async {
                                    if(visible ||_file!=null){
                                    if (_formkey2.currentState!.validate()
                                       ) {
                                  
                                      setState(() => loading = true);
                                      if(_file!=null){
                                      Uint8List sample = _file!;
                                      await StoreData().saveData(
                                        pick: sample,
                                        sa: "$datee" + "category",
                                      );}
                                      final Category = _categoryController.text;
                                      if(_file!=null){
                                      
                                        await widget.snapshot.reference.update({
                                          "Category": Category,
                                          "image": samm[0],
                                        });}
                                        else if(_file==null && widget.snapshot['image']!=null){
                                           await widget.snapshot.reference.update({
                                          "Category": Category,
                                          "image": widget.snapshot['image'],
                                        });

                                        }else{
                                           await widget.snapshot.reference.update({
                                          "Category": Category,
                                          "image": null,
                                        });
                                        }
                                        await _log
                                            .doc(user!.uid)
                                            .collection('operations')
                                            .add({
                                          'email': user!.email,
                                          'uid': user!.uid,
                                          'time': datee,
                                          "category": Category,
                                          "operation": 'edit C',
                                          "pic":_file!=null? samm[0]:widget.snapshot['image']??widget.snapshot['image']
                                        }).then((value) =>
                                                Navigator.pop(context));

                                       
                                      
                                    }}else{
                                     
                                      ScaffoldMessenger.of(context).showSnackBar(
                                      snacks('No changes made'));
                                    }
                                    //  else if (_formkey2.currentState!
                                    //         .validate() &&
                                    //     _file == null && widget.snapshot['image']==null) {
                                    //   if (loading) return;
                                    //   setState(() => loading = true);
                                    //   final Category = _categoryController.text;
                                    //   {
                                    //     await widget.snapshot.reference.update(
                                    //         {
                                    //       "Category": Category,
                                    //       "image": null,
                                    //     });
                                    //     await _log
                                    //         .doc(user!.uid)
                                    //         .collection('operations')
                                    //         .add({
                                    //       'email': user!.email,
                                    //       'uid': user!.uid,
                                    //       'time': datee,
                                    //       "category": Category,
                                    //       "operation": 'edit C',
                                    //       "pic": null,
                                    //     });
                                    //     setState(() {
                                    //       visible = true;
                                    //     });
                                       
                                    //     ScaffoldMessenger.of(context)
                                    //         .showSnackBar(snacks(
                                    //             "${widget.snapshot['Category']} Has Been Created Successfully"));
                                    //     /*Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const navigation(),
                                    //       ),
                                    //     );*/
                                    //   }
                                    // }
                                  },
                                  child: Text(
                                    'Update Category',
                                    style: buttontextstyle(),
                                  ),
                                ),
                              )
                            ])))));
  }
}
