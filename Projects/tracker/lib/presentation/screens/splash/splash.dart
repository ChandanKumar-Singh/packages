import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/material.dart';
import 'package:tracker/presentation/routes/index.dart';

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
    2000.delay.then((value) =>
        routeTo(Routes.home, clearStack: true, queryParameters: {'age': '10'}));
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
