import 'dart:async';

import 'package:flutter/widgets.dart';

class FlyingUnmaskedHero extends StatefulWidget {
  final Rect fromPosition;
  final Rect toPosition;
  final Widget child;
  final VoidCallback? onFlyingEnded;

  FlyingUnmaskedHero({
    required this.fromPosition,
    required this.toPosition,
    required this.child,
    this.onFlyingEnded,
  });

  @override
  FlyingUnmaskedHeroState createState() => FlyingUnmaskedHeroState();
}

class FlyingUnmaskedHeroState extends State<FlyingUnmaskedHero> {
  bool flying = false;

  @override
  void initState() {
    Timer(Duration(milliseconds: 0), () {
      setState(() {
        flying = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Rect fromPosition = widget.fromPosition;
    final Rect toPosition = widget.toPosition;
    return AnimatedPositioned(
      child: widget.child,
      duration: Duration(milliseconds: 200),
      top: flying ? toPosition.top : fromPosition.top,
      left: flying ? toPosition.left : fromPosition.left,
      height: flying ? toPosition.height : fromPosition.height,
      width: flying ? toPosition.width : fromPosition.width,
      onEnd: widget.onFlyingEnded,
    );
  }
}
