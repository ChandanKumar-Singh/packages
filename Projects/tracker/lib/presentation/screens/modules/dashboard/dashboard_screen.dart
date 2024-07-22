import 'package:flutter/material.dart';
import 'package:tracker/data/repositories/auth/index.dart';
import 'package:tracker/presentation/routes/index.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});
  static const String routeName = '/';

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoardPage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthRepo.instance.logOut().then((value) {
                if (value) routeTo(Routes.login);
              });
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
