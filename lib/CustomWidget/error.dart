import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Errorpop extends StatelessWidget {
  const Errorpop({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   body:
        Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(300, 0, 0, 0),
                    child: SizedBox(
                      child: Transform.rotate(
                        angle: 0.75,
                        alignment: Alignment.topRight,
                        child:
                            //  IconButton(icon:
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 50,
                                )),
                        // onPressed: (){},
                        // ),
                      ),
                    ),
                  ),
                  Center(
                      child: Lottie.network(
                          'https://lottie.host/01037359-4fa7-46ab-ad08-360998c41b97/KWIzYH29gP.json',
                          height: 60,
                          width: 60)),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                  style: TextStyle(color: Colors.red, fontSize: 10),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Error!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
