import 'package:flutter/material.dart';

class snackbar extends StatelessWidget {
  final Color color;
  final String text;
  snackbar({
    required this.color,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        // backgroundColor: color,
        content: Text(
      text,
      // style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
    ));
  }
}
