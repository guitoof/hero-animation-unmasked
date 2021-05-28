import 'package:flutter/widgets.dart';

class UnmaskedHeroController extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Navigating from $previousRoute to $route');
    super.didPush(route, previousRoute);
  }
}
