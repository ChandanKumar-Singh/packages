import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  static const String routeName = '/signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Signup Page'),
      ),
    );
  }
}
