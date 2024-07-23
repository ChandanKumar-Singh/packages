import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  NavigationService._internal();

  factory NavigationService() => _instance;

  static NavigationService get instance => _instance;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}
