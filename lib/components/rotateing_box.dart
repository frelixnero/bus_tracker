import 'dart:math';
import 'package:flutter/material.dart';

class AnimBoxWidget extends StatefulWidget {
  final double redBoxHeight;
  final double blueBoxHeight;
  final double redBoxWidth;
  final double blueBoxWidth;
  const AnimBoxWidget({
    super.key,
    required this.redBoxHeight,
    required this.blueBoxHeight,
    required this.redBoxWidth,
    required this.blueBoxWidth,
  });

  @override
  State<AnimBoxWidget> createState() => AnimBoxWidgetState();
}

class AnimBoxWidgetState extends State<AnimBoxWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _redBoxAnimation;
  late final Animation<double> _blueBoxAnimation;
  Color myFlutterColor = Color(0xFF7df6dd);
  Color myFlutterColor2 = Color(0xFFe9665a);

  @override
  void initState() {
    super.initState();

    // The total duration of one animation cycle (rotation + pause).
    const rotationDuration = Duration(milliseconds: 700);
    const pauseDuration = Duration(milliseconds: 500);
    final totalDuration = rotationDuration + pauseDuration;

    _controller = AnimationController(vsync: this, duration: totalDuration);

    // Create the animation sequence for the red box (counter-clockwise).
    _redBoxAnimation = TweenSequence<double>([
      // First, the rotation part.
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -pi / 2),
        weight: rotationDuration.inMilliseconds.toDouble(),
      ),
      // Second, the pause part.
      TweenSequenceItem(
        tween: ConstantTween<double>(
          -pi / 2,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: pauseDuration.inMilliseconds.toDouble(),
      ),
    ]).animate(_controller);

    // Create the animation sequence for the blue box (clockwise).
    _blueBoxAnimation = TweenSequence<double>([
      // First, the rotation part.
      TweenSequenceItem(
        tween: Tween<double>(begin: -pi / 4, end: pi / 4),
        weight: rotationDuration.inMilliseconds.toDouble(),
      ),
      // Second, the pause part.
      TweenSequenceItem(
        tween: ConstantTween<double>(
          pi / 4,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: pauseDuration.inMilliseconds.toDouble(),
      ),
    ]).animate(_controller);

    // Start the animation and make it repeat.
    // Use a status listener to handle the reversal and restart.
    // Use a status listener to handle the reversal and restart.
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Add a 700ms delay before reversing the animation.
        Future.delayed(const Duration(milliseconds: 0), () {
          _controller.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _controller.forward();
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  //  Color(0xFF1f262f),

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _redBoxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _redBoxAnimation.value,
              child: child,
            );
          },
          child: Container(
            width: widget.redBoxWidth,
            height: widget.redBoxHeight,
            decoration: BoxDecoration(
              border: Border.all(color: myFlutterColor2, width: 2.5),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        // fromRGBO()  #7df6dd
        const SizedBox(width: 20),
        AnimatedBuilder(
          animation: _blueBoxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _blueBoxAnimation.value,
              child: child,
            );
          },
          child: Container(
            width: widget.blueBoxWidth,
            height: widget.blueBoxHeight,
            decoration: BoxDecoration(
              border: Border.all(color: myFlutterColor, width: 2.5),
              color: Color(0xFF1f262f),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}
