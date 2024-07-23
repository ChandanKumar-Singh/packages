import 'dart:ffi';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconic/iconic.dart';
import '/constants/index.dart';
import '/utils/extentions/index.dart';
import '/views/pages/landing/fragments/chat.dart';
import '/views/pages/landing/fragments/home/home.dart';

import '../../../blocs/index.dart';
import '../../widgets/index.dart';
import 'fragments/course.dart';
import 'fragments/profile/profile.dart';
import 'fragments/search.dart';
part 'bottom_bar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  static const String routeName = '/';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: [
            const HomePage(),
            const SearchPage(),
            const CoursePage(),
            const ChatPage(),
            const ProfilePage(),
          ][state.bottomNavIndex],
          bottomNavigationBar: const LandingBottomBar(),
        );
      },
    ).showDraggableWidget(const ThemeSwitch());
  }
}
