import 'package:flutter/material.dart';

class UnmaskedHero extends StatefulWidget {
  final String tag;
  final Widget child;

  UnmaskedHero({required this.tag, required this.child});

  @override
  UnmaskedHeroState createState() => UnmaskedHeroState();
}

class UnmaskedHeroState extends State<UnmaskedHero> {
  bool hidden = false;

  void hide() {
    setState(() {
      hidden = true;
    });
  }

  void show() {
    setState(() {
      hidden = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: hidden ? 0.0 : 1.0, child: widget.child);
  }
}
