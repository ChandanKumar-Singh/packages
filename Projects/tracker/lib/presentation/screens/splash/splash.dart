import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/material.dart';

import '../../../constants/index.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const String routeName = '/splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // delay(2).then((value) => goTo(context, Welcome.routeName, replace: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          MyPng.logo,
          width: context.width() * 0.5,
        ),
      ),
    );
  }
}
