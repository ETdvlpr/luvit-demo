import 'package:flutter/material.dart';

class SlideInFromRight extends StatefulWidget {
  final Widget child;
  final GlobalKey<SlideInFromRightState> slideInKey;

  SlideInFromRight({required this.child, required this.slideInKey})
      : super(key: slideInKey);

  @override
  SlideInFromRightState createState() => SlideInFromRightState();
}

class SlideInFromRightState extends State<SlideInFromRight>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    slideIn();
  }

  void slideIn() {
    _controller.forward();
  }

  void slideOut() {
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
