import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/business_logics/blocs/auth/auth_bloc.dart';
import '/data/repositories/auth/index.dart';

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
      appBar: AppBar(
        title: const Text('DashBoardPage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutSubmitted(GoogleAuth()));
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
