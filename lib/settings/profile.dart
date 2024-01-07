import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return  SafeArea(
      child: Scaffold(
        
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:const Icon(Icons.arrow_back_ios,size: 40,)),
                  SizedBox(width: width*0.2,),
               const  Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            
              ],),
            ),
            
            SizedBox(height: height*0.07,),
    
            Center(child: CircleAvatar(radius: 100,backgroundImage: NetworkImage(docsnap.get('profile')),
          // backgroundImage:
          ))
          ],),
        ),
      ),
    );
  }
}