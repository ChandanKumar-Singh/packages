import 'dart:async';
import 'dart:convert';

import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracker/core/helper/index.dart';
import 'package:tracker/data/repositories/auth/index.dart';

import '../screens/index.dart';
import 'index.dart';

export 'name.dart';
export 'paths.dart';

/// Go router route start
///
///

Future<T?> redirectTo<T extends Object?>({
  Map<String, String> queryParameters = const <String, String>{},
}) {
  Uri? uri = Uri.tryParse(SpHelper().getRedirection());
  if (uri == null) return Future.value();
  loggVerbose(uri, name: 'Redirecting after login to ${uri.path}');
  Object? extra =
      tryCatch(() => jsonDecode(uri.queryParameters['extra']!), log: false);
  return routeTo(uri.path, extra: extra, named: false, clearStack: true);
}

Future<T?> routeTo<T extends Object?>(
  String name, {
  bool replace = false,
  bool clearStack = false,
  bool named = true,
  Map<String, String> pathParameters = const <String, String>{},
  Map<String, String> queryParameters = const <String, String>{},
  Object? extra,
}) {
  if (clearStack) {
    if (!named) {
      goRouter.go(name, extra: extra);
      return Future.value();
    }
    goRouter.goNamed(name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
    return Future.value();
  }
  if (replace) {
    if (!named) {
      goRouter.replace(name, extra: extra);
      return Future.value();
    }
    goRouter.replaceNamed(name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
    return Future.value();
  }
  if (!named) {
    goRouter.push(name, extra: extra);
    return Future.value();
  }
  return goRouter.pushNamed<T>(name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra);
}

GoRouter goRouter = GoRouter(
  initialLocation: Paths.splash,
  redirect: _redirect,
  routes: <RouteBase>[
    _route2(
      Paths.splash,
      Routes.splash,
      (c, s) => const Splash(),
    ),

    // Home routes
    _route2(
      Paths.home,
      Routes.home,
      (c, s) => const DashBoardPage(),
      routes: <RouteBase>[
        _route2(
          Routes.location,
          Routes.location,
          (c, s) => const LocationPage(),
        ),
      ],
    ),

    // Auth routes
    _route2(
      Paths.login,
      Routes.login,
      (c, s) => const LoginPage(),
    ),
  ],
);

FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
  logg('Redirecting to ${state.matchedLocation}', name: 'GoRouter');
  if (state.matchedLocation.startsWith(Paths.home)) {
    bool isAuth = UserRepository.instance.isUserLoggedIn();
    logg('User is logged in: $isAuth  ${state.matchedLocation}',
        name: 'GoRouter');
    if (!isAuth) {
      String extra = state.extra != null
          ? tryCatch(() => jsonEncode(state.extra)) ?? ''
          : '';
      Uri uri = state.uri;
      if (extra.isNotEmpty) {
        uri.queryParameters.addEntries([MapEntry('extra', extra)]);
      }
      SpHelper().setRedirection(uri.toString());
      loggVerbose(uri.toString(), count: 0, name: 'After login redirect to');
      return Paths.login;
    }
  }
  return null;
}

RouteBase _route2(
  String path,
  String name,
  Widget Function(BuildContext, GoRouterState)? builder, {
  GlobalKey<NavigatorState>? parentNavigatorKey,
  FutureOr<String?> Function(BuildContext, GoRouterState)? redirect,
  FutureOr<bool> Function(BuildContext, GoRouterState)? onExit,
  List<RouteBase> routes = const <RouteBase>[],
  List<RouteTransition> transitions = const [
    RouteTransition.none,
    // RouteTransition.left,
    // RouteTransition.fade,
  ],
  Duration? duration,
}) {
  return GoRoute(
    path: path,
    name: name,
    pageBuilder: (context, state) => _pageBuilder(state, builder, transitions,
        duration: duration)(context, state),
    parentNavigatorKey: parentNavigatorKey,
    redirect: redirect,
    onExit: onExit,
    routes: routes,
  );
}

Page<dynamic> Function(BuildContext, GoRouterState) _pageBuilder(
    GoRouterState state,
    Widget Function(BuildContext, GoRouterState)? builder,
    List<RouteTransition> transitions,
    {Duration? duration}) {
  return (BuildContext context, GoRouterState state) {
    Map<String, dynamic> arguments = Map.from(state.uri.queryParameters);
    if (state.extra is Map<String, dynamic>) {
      arguments.addAll(state.extra as Map<String, dynamic>);
    }
    arguments['d'] ??= '500';
    duration = duration ??
        tryCatch(() => int.parse(arguments['d']).milliseconds) ??
        const Duration(milliseconds: 300);
    final Widget page =
        builder != null ? builder(context, state) : const SizedBox();

    if (transitions.isNotEmpty &&
        !(transitions.length == 1 &&
            transitions.first == RouteTransition.none)) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: page,
        barrierDismissible: true,
        barrierColor: Colors.black38,
        arguments: arguments,
        transitionDuration: duration ?? const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          for (var transition in transitions) {
            child = transition.buildTransition(
                context, animation, secondaryAnimation, child);
          }
          return child;
        },
      );
    } else {
      return CupertinoPage(child: page, arguments: arguments);
    }
  };
}

enum RouteTransition {
  upward,
  downward,
  left,
  right,
  fade,
  zoomIn,
  zoomOut,
  none,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight;

  /// Method to get the name of a transition
  ///
  String get name {
    switch (this) {
      case RouteTransition.upward:
        return 'upward';
      case RouteTransition.downward:
        return 'downward';
      case RouteTransition.left:
        return 'left';
      case RouteTransition.right:
        return 'right';
      case RouteTransition.fade:
        return 'fade';
      case RouteTransition.zoomIn:
        return 'zoomIn';
      case RouteTransition.zoomOut:
        return 'zoomOut';
      case RouteTransition.topLeft:
        return 'topLeft';
      case RouteTransition.topRight:
        return 'topRight';
      case RouteTransition.bottomLeft:
        return 'bottomLeft';
      case RouteTransition.bottomRight:
        return 'bottomRight';
      default:
        return 'none';
    }
  }

  /// Method to get the reverse of a transition
  RouteTransition get fromString {
    switch (this) {
      case RouteTransition.upward:
        return RouteTransition.downward;
      case RouteTransition.downward:
        return RouteTransition.upward;
      case RouteTransition.left:
        return RouteTransition.right;
      case RouteTransition.right:
        return RouteTransition.left;
      case RouteTransition.fade:
        return RouteTransition.fade;
      case RouteTransition.zoomIn:
        return RouteTransition.zoomOut;
      case RouteTransition.zoomOut:
        return RouteTransition.zoomIn;
      case RouteTransition.topLeft:
        return RouteTransition.bottomRight;
      case RouteTransition.topRight:
        return RouteTransition.bottomLeft;
      case RouteTransition.bottomLeft:
        return RouteTransition.topRight;
      case RouteTransition.bottomRight:
        return RouteTransition.topLeft;
      default:
        return RouteTransition.none;
    }
  }

  /// Method to animate a page transition
  Widget buildTransition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    switch (this) {
      case RouteTransition.upward:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case RouteTransition.downward:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case RouteTransition.left:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case RouteTransition.right:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case RouteTransition.fade:
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case RouteTransition.zoomIn:
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.5,
            end: 1.0,
          ).animate(animation),
          child: child,
        );
      case RouteTransition.zoomOut:
        return ScaleTransition(
          scale: Tween<double>(
            begin: 1.5,
            end: 1.0,
          ).animate(animation),
          child: child,
        );
      case RouteTransition.topLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case RouteTransition.topRight:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case RouteTransition.bottomLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case RouteTransition.bottomRight:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      default:
        return child;
    }
  }
}

///*************************** Go router route end ***************************///

/// normal route start
Future<dynamic> navigateTo(String routeName,
    {Object? arguments, bool replace = false}) {
  if (navigatorKey.currentContext == null) {
    errorToast('Unable to navigate');
    return Future.value();
  }
  if (replace) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }
  return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
}

Route<dynamic>? onGenerateRoute(settings) {
  switch (settings.name) {
    case Splash.routeName:
      return _route(const Splash(), settings: settings);
    case LoginPage.routeName:
      return _route(const LoginPage(), settings: settings);
    case DashBoardPage.routeName:
      return _route(const DashBoardPage(), settings: settings);
    default:
      return _route(const LoginPage(), settings: settings);
  }
}

/// Route generator for the app
PageRoute _route(
  Widget page, {
  RouteSettings? settings,
  bool maintainState = true,
  bool fullscreenDialog = false,
  bool allowSnapshotting = true,
  bool barrierDismissible = false,
  bool iosMode = true,
}) {
  if (iosMode) {
    return CupertinoPageRoute(
      builder: (_) => page,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      allowSnapshotting: allowSnapshotting,
      barrierDismissible: barrierDismissible,
    );
  }
  return MaterialPageRoute(
    builder: (_) => page,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
    allowSnapshotting: allowSnapshotting,
    barrierDismissible: barrierDismissible,
  );
}
