import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AlertBanner extends StatelessWidget {
  final String text;
  final Color color;
  AlertBanner({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        height: 70,
        width: double.infinity,
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 10),
          child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Lottie.network(
                      'https://lottie.host/91c79675-66b2-4f56-bb3e-c6a69c908983/AF9knpBOSV.json',
                      width: 100,
                      height: 100),
                  Text(
                    text,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

//  showAlertBanner(
//                         context,
//                         () => print("TAPPED"),
//                         AlertBanner(
//                           text: 'Your not allowed!',color: Colors.red,
//                         ),
//                         alertBannerLocation: AlertBannerLocation.top,
//                         // .. EDIT MORE FIELDS HERE ...
//                       );