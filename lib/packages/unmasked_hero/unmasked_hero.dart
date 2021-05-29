import 'package:flutter/material.dart';

class UnmaskedHero extends StatefulWidget {
  final String tag;
  final Widget child;

  UnmaskedHero({required this.tag, required this.child});

  @override
  UnmaskedHeroState createState() => UnmaskedHeroState();
}

class UnmaskedHeroState extends State<UnmaskedHero> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
