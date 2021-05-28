import 'package:flutter/material.dart';
import 'package:hero_animation_unmasked/pages/hero_details_page.dart';
import 'package:hero_animation_unmasked/pages/hero_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'hero_list_page',
      routes: {
        'hero_list_page': (context) => HeroListPage(),
        'hero_details_page': (context) => HeroDetailsPage(),
      },
    );
  }
}
