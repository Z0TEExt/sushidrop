import 'package:flutter/material.dart';

class FunkyOverlay extends StatefulWidget {
  final String? img;
  final double borderRadius;
  final Widget? showMyAnimationDialog;
  const FunkyOverlay({
    super.key,
    this.img,
    this.showMyAnimationDialog,
    this.borderRadius = 24,
  });
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        animationBehavior: AnimationBehavior.preserve);
    scaleAnimation = CurvedAnimation(
      parent: controller!,
      curve: Curves.ease,
    );

    controller!.addListener(() {});

    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
          scale: scaleAnimation!, child: widget.showMyAnimationDialog),
    );
  }
}
