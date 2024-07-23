import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconic/iconic.dart';
import '/blocs/auth/providers/providers.dart';
import '/blocs/index.dart';
import '/constants/index.dart';
import '/utils/extentions/index.dart';
import '/views/widgets/index.dart';

part 'components/home_card_swiper.dart';
part 'components/home_search_bar.dart';
part 'components/home_choose_course.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(context),
          searchBar(),
          ListView(
            padding: const EdgeInsetsDirectional.all(paddingDefault),
            children: const [
              HomeCardSwiper(),
              _HomeChooseCourseSection(),
            ],
          ).expand(),
        ],
      ),
    );
  }

  Container header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hello,',
              style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.textTertiary, fontWeight: FontWeight.bold)),
          const SizedBox(height: heightSmall),
          Text(
            'John Doe',
            style: context.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return HomeSearchBar(onFilter: () {});
  }

  PreferredSize _buildAppbar(BuildContext context) {
    return buildAppbar(
      context,
      transparent: true,
      leading: IconButton(onPressed: () {}, icon: const Icon(Iconic.apps)),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconic.user_solid, color: Colors.grey),
        ),
        TextButton(
          onPressed: () =>
              context.read<AuthBloc>().add(AuthLogoutSubmitted(GoogleAuth())),
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
