import 'package:flutter/material.dart';

class ExampleAlertBannerChild extends StatelessWidget {
  final String text;
  final Color color;
  ExampleAlertBannerChild({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 600),
      child: Center(
        child: Container(
          width: double.infinity,
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 10),
            child: Material(
              color: Colors.transparent,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 18),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
