import 'package:flutter/material.dart';

class gen_excel extends StatefulWidget {
  const gen_excel({super.key});

  @override
  State<gen_excel> createState() => _gen_excelState();
}

class _gen_excelState extends State<gen_excel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excel Generator'),
      ),
      body:
      Column(children: [
        Text("Generate Excel"),
      ],)
    );
  }
}