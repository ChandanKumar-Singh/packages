import '/routes/route.dart';

Future<T?> goTo<T extends Object?>(String name,
    {Object? arg, bool replace = false}) async {
  return !replace
      ? NavigationService.navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(name, (route) => false)
      : NavigationService.navigatorKey.currentState
          ?.pushReplacementNamed(name, arguments: arg);
}

Future<T?> pushTo<T extends Object?>(String name, {Object? arg}) async {
  return NavigationService.navigatorKey.currentState
      ?.pushNamed(name, arguments: arg);
}

// Future<T?> goTo<T extends Object?>(BuildContext context, String name,
//     {RouteSettings? settings, bool replace = true}) async {
//   return !replace
//       ? NavigationService.navigatorKey.currentState?. pushNamedAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => page, settings: settings),
//           (route) => false)
//       : NavigationService.navigatorKey.currentState?. pushReplacement(
//           MaterialPageRoute(builder: (context) => page, settings: settings),
//         );
// }

// Future<T?> goToAndBack<T extends Object?>(BuildContext context, Widget page,
//     {RouteSettings? settings}) async {
//   return NavigationService.navigatorKey.currentState?. pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => page, settings: settings),
//       (route) => true);
// }

// Future<T?> pushTo<T extends Object?>(BuildContext context, Widget page,
//     {RouteSettings? settings}) async {
//   return NavigationService.navigatorKey.currentState?. //       .push(MaterialPageRoute(builder: (context) => page, settings: settings));
// }
