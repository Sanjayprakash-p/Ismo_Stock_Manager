import 'package:flutter/material.dart';
import 'package:flutter_application_2/CustomWidget/imagecache.dart';

class PinchZoomImage extends StatefulWidget {
  final String sanj;
  PinchZoomImage({
    Key? key,
    required this.sanj,
  }) : super(key: key);

  @override
  State<PinchZoomImage> createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage>
    with SingleTickerProviderStateMixin {
  late TransformationController _controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  final double minScale = 1;
  final double maxScale = 2;
  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() => _controller.value = animation!.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      title: Column(
        children: [
          Center(
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              transformationController: _controller,
              panEnabled: false,
              minScale: minScale,
              maxScale: maxScale,
              onInteractionEnd: (details) {
                resetAnimation();
              },
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // child: catchimage(widget.sanj)
                  child: Image.network(
                    widget.sanj,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: _controller.value,
      end: Matrix4.identity(),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn));
    animationController.forward(from: 0);
  }
}
