import 'package:flutter/material.dart';
import 'package:hero_animation_unmasked/data/heroes_data.dart';
import 'package:hero_animation_unmasked/widgets/hero_tile.dart';

class HeroListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heroes"),
        backgroundColor: Colors.black,
      ),
      body: ListView(children: [
        ...heroesData.map(
          (hero) => HeroTile(key: Key(hero.id), hero: hero),
        ),
      ]),
    );
  }
}
