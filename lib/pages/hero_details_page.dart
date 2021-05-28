import 'package:flutter/material.dart';
import 'package:hero_animation_unmasked/entities/hero_entity.dart';

class HeroDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HeroEntity hero = (ModalRoute.of(context)?.settings.arguments
        as Map<String, dynamic>)['hero'];
    return Scaffold(
      appBar: AppBar(
        title: Text(hero.name),
        backgroundColor: Colors.black,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Hero(
              tag: hero.id,
              child: Image.network(
                hero.avatar,
              ),
            ),
            Text(
              hero.name,
              style: TextStyle(fontSize: 36),
            ),
            Text(
              hero.description,
            ),
          ],
        ),
      ),
    );
  }
}
