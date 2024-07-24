import 'dart:ui';

import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/data/models/index.dart';
import '/business_logics/blocs/auth/auth_bloc.dart';
import '/data/repositories/auth/index.dart';

part 'fragments/home_screen.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});
  static const String routeName = '/';

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  void initState() {
    UserRepository.instance.refreshCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: HomeScreen(),
    );
  }
}
