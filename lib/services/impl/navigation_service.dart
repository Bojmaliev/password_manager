import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName, {Object? args}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: args);
  }

  Future<dynamic>? navigateToAndRemove(String routeName,
      {Object? args}) {
    return navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: args);
  }

  Future<dynamic>? navigateToAndRemoveLast(String routeName,
      {Object? args}) {
    return navigatorKey.currentState
        ?.popAndPushNamed(routeName, arguments: args);
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}
