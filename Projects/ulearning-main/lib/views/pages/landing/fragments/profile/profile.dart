import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconic/iconic.dart';
import '/utils/extentions/index.dart';
import '/views/widgets/index.dart';

import '../../../../../constants/index.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: heightDefault),
            _profile(context),
            const SizedBox(height: heightSmall),
            _courseBuyRatingsTiles(context),
            const SizedBox(height: paddingDefault * 2),
            _actionTiles(context),
            // const SizedBox(height: heightSmall),
            // _profileActions(context),
            // const SizedBox(height: heightSmall),
            // _profileCourses(context),
            const Row(
              children: [],
            )
          ],
        ).paddingSymmetric(horizontal: paddingDefault),
      ),
    );
  }

  Widget _actionTiles(BuildContext context) {
    return Column(
      children: [
        _actionTile(context, Iconic.settings_solid, 'Settings', () {}),
        _actionTile(
            context, Iconic.credit_card_solid, 'Payment Details', () {}),
        _actionTile(context, Iconic.trophy_solid, 'Achievements', () {}),
        _actionTile(context, Iconic.heart_solid, 'Favorites', () {}),
        _actionTile(
            context, Iconic.alarm_clock_solid, 'Learning Reminders', () {}),
      ],
    );
  }

  Widget _actionTile(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Row(
      children: [
        Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: context.theme.primaryColor,
              borderRadius: BorderRadius.circular(borderRadiusDefault),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ).paddingAll(paddingSmall).fitted()),
        const SizedBox(width: paddingDefault),
        Text(
          title,
          style: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ).expand(),
      ],
    ).paddingSymmetric(vertical: paddingSmall).onTap(onTap);
  }

  Widget _courseBuyRatingsTiles(BuildContext context) {
    return Row(
      // shrinkWrap: true,
      // scrollDirection: Axis.horizontal,
      // physics: const NeverScrollableScrollPhysics(),
      // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //     maxCrossAxisExtent: 100, mainAxisSpacing: paddingSmall.w),
      children: [
        Container(
          width: context.screenSize.width / 3,
          decoration: BoxDecoration(
            color: context.theme.primaryColor,
            borderRadius: BorderRadius.circular(borderRadiusDefault),
          ),
          child: Column(
            children: [
              const SizedBox(height: paddingDefault),
              const Icon(Iconic.video_camera_solid, color: Colors.white),
              const SizedBox(height: paddingDefault),
              Text(
                'My Courses',
                style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ).fitted().paddingAll(paddingSmall / 2),
        ).onTap(() {}).expand(),
        paddingSmall.width,
        Container(
          width: context.screenSize.width / 3,
          decoration: BoxDecoration(
            color: context.theme.primaryColor,
            borderRadius: BorderRadius.circular(borderRadiusDefault),
          ),
          child: Column(
            children: [
              const SizedBox(height: paddingDefault),
              const Icon(Iconic.book_solid, color: Colors.white),
              const SizedBox(height: paddingDefault),
              Text(
                'Buy Courses',
                style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ).fitted().paddingSymmetric(vertical: paddingSmall / 2),
        ).onTap(() {}).expand(),
        paddingSmall.width,
        Container(
          width: context.screenSize.width / 3,
          decoration: BoxDecoration(
            color: context.theme.primaryColor,
            borderRadius: BorderRadius.circular(borderRadiusDefault),
          ),
          child: Column(
            children: [
              const SizedBox(height: paddingDefault),
              const Icon(Iconic.star_solid, color: Colors.white),
              const SizedBox(height: paddingDefault),
              Text(
                '4.9',
                style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ).fitted().paddingAll(paddingSmall / 2),
        ).onTap(() {}).expand(),
      ],
    ).size(height: 50.h);
  }

  Widget _profile(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              backgroundColor: context.theme.primaryColor.withOpacity(0.005),
              radius: 30.w,
              backgroundImage: const NetworkImage(
                'https://lh3.googleusercontent.com/a-/AOh14GhCpmeHdwyiGTjusea5wnu1yEQltH5vTADhg1j8Og=s600-k-no-rp-mo',
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(paddingSmall),
                decoration: BoxDecoration(
                  color: context.theme.primaryColor,
                  borderRadius: BorderRadius.circular(borderRadiusDefault),
                ),
                child: Icon(
                  Iconic.pencil_bold,
                  color: Colors.white,
                  size: 10.w,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: paddingDefault),
        Text(
          'John Doe',
          style: context.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  PreferredSize _appbar(BuildContext context) {
    return buildAppbar(
      context,
      title: 'Profile',
      transparent: true,
      leading: IconButton(
          onPressed: () {},
          icon: Image.asset(MyPng.menuBar,
              width: 20,
              height: 20,
              color: context.isDark ? Colors.white : Colors.black)),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconic.menu_dots_vertical_bold),
        ),
      ],
    );
  }
}
