import 'dart:ui';

import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/material.dart';
import 'package:tracker/data/models/index.dart';
import 'package:tracker/presentation/routes/index.dart';
import '../../../../business_logics/blocs/index.dart';
import '../../../../data/repositories/index.dart';
import '../../../widgets/index.dart';
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
    return const Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: HomeScreen(),
    );
  }
}
