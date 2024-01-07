import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CircleIndicator extends StatelessWidget {
  const CircleIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SpinKitCircle(
            size: 70,
            itemBuilder: (context, index) {
              final colors = [Colors.grey];
              final color = colors[index % colors.length];
              return DecoratedBox(
                  decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ));
            }),
      ),
    );
  }
}
