import 'package:flutter/widgets.dart';

class UnmaskedHeroController extends NavigatorObserver {
  /// Checks whether the hero's flight has a valid origin & destination routes
  bool _isFlightValid(PageRoute? fromRoute, PageRoute toRoute) {
    if (fromRoute == null) {
      return false;
    }
    BuildContext? fromRouteContext = fromRoute.subtreeContext;
    BuildContext? toRouteContext = toRoute.subtreeContext;
    if (fromRouteContext == null || toRouteContext == null) {
      return false;
    }
    return true;
  }

  @override
  void didPush(Route<dynamic> toRoute, Route<dynamic>? fromRoute) {
    WidgetsBinding.instance?.addPostFrameCallback((Duration value) {
      /// If the flight is not valid, let's just ignore the case
      if (!_isFlightValid(fromRoute as PageRoute?, toRoute as PageRoute)) {
        return;
      }
    });
    super.didPush(toRoute, fromRoute);
  }
}
