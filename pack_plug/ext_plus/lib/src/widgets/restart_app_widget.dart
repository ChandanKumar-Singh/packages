import 'package:flutter/material.dart';

/// RestartAppWidget helps you to restart your Flutter app
class RestartAppWidget extends StatefulWidget {
  final Widget child;

  RestartAppWidget({super.key, required this.child});

  @override
  _RestartAppWidgetState createState() => _RestartAppWidgetState();

  static init(BuildContext context) =>
      context.findAncestorStateOfType<_RestartAppWidgetState>()?.restartApp();
}

class _RestartAppWidgetState extends State<RestartAppWidget> {
  Key _key = UniqueKey();

  void restartApp() {
    _key = UniqueKey();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
      KeyedSubtree(key: _key, child: widget.child);
}
