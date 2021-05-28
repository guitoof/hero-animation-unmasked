import 'package:flutter/material.dart';
import 'package:hero_animation_unmasked/entities/hero_entity.dart';

class HeroTile extends StatelessWidget {
  final HeroEntity hero;

  const HeroTile({required Key key, required this.hero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          'hero_details_page',
          arguments: {'hero': hero},
        );
      },
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.network(
              hero.avatar,
            ),
          ),
          Expanded(
            flex: 3,
            child: ListTile(
              title: Text(
                hero.name,
              ),
              subtitle: Text(hero.description),
            ),
          ),
        ],
      ),
    );
  }
}
