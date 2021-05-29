import 'package:flutter/widgets.dart';
import 'package:hero_animation_unmasked/packages/unmasked_hero/unmasked_hero.dart';

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

  /// Visit & Invite all heroes of given context to the party
  Map<String, UnmaskedHeroState> _inviteHeroes(BuildContext context) {
    Map<String, UnmaskedHeroState> heroes = {};
    void _visitHero(Element element) {
      if (element.widget is UnmaskedHero) {
        final StatefulElement hero = element as StatefulElement;
        final UnmaskedHero heroWidget = hero.widget as UnmaskedHero;
        final dynamic tag = heroWidget.tag;
        heroes[tag] = hero.state as UnmaskedHeroState;
      } else {
        element.visitChildren(_visitHero);
      }
    }

    context.visitChildElements(_visitHero);
    return heroes;
  }

  /// Locate Hero from within a given context
  /// returns a [Rect] that will hold the hero's position & size in the context's frame of reference
  Rect _locateHero({
    required UnmaskedHeroState hero,
    required BuildContext context,
  }) {
    final heroRenderBox = (hero.context.findRenderObject() as RenderBox);
    final RenderBox ancestorRenderBox = context.findRenderObject() as RenderBox;
    assert(heroRenderBox.hasSize && heroRenderBox.size.isFinite);

    return MatrixUtils.transformRect(
      heroRenderBox.getTransformTo(ancestorRenderBox),
      Offset.zero & heroRenderBox.size,
    );
  }

  /// Display Hero on Overlay at the given position
  void _displayFlyingHeroAtPosition({
    required UnmaskedHeroState hero,
    required Rect position,
  }) {
    if (navigator == null) {
      print('Cannot fly without my navigator...');
      return;
    }
    final BuildContext navigatorContext = navigator!.context;
    print(
        "Start flying with Hero with tag = ${hero.widget.tag}, type = ${hero.widget.child.runtimeType}");

    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        child: hero.widget.child,
        top: position.top,
        left: position.left,
        width: position.width,
        height: position.height,
      ),
    );
    Navigator.of(navigatorContext).overlay?.insert(overlayEntry);
  }

  @override
  void didPush(Route<dynamic> toRoute, Route<dynamic>? fromRoute) {
    WidgetsBinding.instance?.addPostFrameCallback((Duration value) {
      /// If the flight is not valid, let's just ignore the case
      if (!_isFlightValid(fromRoute as PageRoute?, toRoute as PageRoute)) {
        return;
      }
      final BuildContext fromContext = fromRoute!.subtreeContext!;
      final BuildContext toContext = toRoute.subtreeContext!;

      Map<String, UnmaskedHeroState> sourceHeroes = _inviteHeroes(fromContext);
      Map<String, UnmaskedHeroState> destinationHeroes =
          _inviteHeroes(toContext);

      for (UnmaskedHeroState hero in destinationHeroes.values) {
        final UnmaskedHeroState? sourceHero = sourceHeroes[hero.widget.tag];
        final UnmaskedHeroState destinationHero = hero;
        if (sourceHero == null) {
          print(
              'No source Hero could be found for destination Hero with tag: ${hero.widget.tag}');
          continue;
        }

        final Rect fromPosition =
            _locateHero(hero: sourceHero, context: fromContext);
        final Rect toPosition =
            _locateHero(hero: destinationHero, context: toContext);

        _displayFlyingHeroAtPosition(hero: hero, position: fromPosition);
      }
    });
    super.didPush(toRoute, fromRoute);
  }
}
