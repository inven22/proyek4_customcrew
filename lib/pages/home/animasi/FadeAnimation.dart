import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _translateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(widget.delay, 1.0, curve: Curves.easeOut),
      ),
    );

    _translateAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(widget.delay, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _translateAnimation,
            child: widget.child,
          ),
        );
      },
    );
  }
}
