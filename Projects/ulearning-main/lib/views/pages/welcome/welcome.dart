import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/constants/asset_const.dart';
import '/utils/extentions/index.dart';
import '/views/pages/index.dart';

import '../../../routes/index.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});
  static const String routeName = '/welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  void onPressed(List e, List i) {
    int index = e.indexOf(i);
    if (index == e.length - 1) {
      pushTo(LoginPage.routeName);
    } else {
      _pageController.animateToPage(index + 1,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List> list = [
      [
        MyPng.onboard0,
        'Welcome to Ulearning',
        'Welcome to Ulearning, the best place to learn',
        'Next'
      ],
      [
        MyPng.onboard1,
        'Learn anytime, anywhere',
        'Following a good environment and accessories for learning',
        'Next'
      ],
      [
        MyPng.onboard2,
        'Discover new knowledge',
        'Discover new knowledge and improve your skills with us',
        'Get started'
      ],
    ];
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: SizedBox(
          width: 375.w,
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...list
                      .map((e) => _PageViewItem(e, () => onPressed(list, e))),
                ],
              ),
              Positioned(
                bottom: 20.h,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: list.length,
                    axisDirection: Axis.horizontal,
                    effect: JumpingDotEffect(
                      activeDotColor: context.colorScheme.primary,
                      jumpScale: 1.4,
                      verticalOffset: 10.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageViewItem extends StatelessWidget {
  const _PageViewItem(this.e, this.onPressed);

  final List e;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
            child: Image.asset(
              e[0],
              width: 200.w,
              height: 200.h,
            ).fitted(height: context.screenSize.height / 2),
          ),
          Container(
            // color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                const SizedBox(height: 20),
                Text(e[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(e[2],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
                const SizedBox(height: 20),
                const Spacer(),
                ElevatedButton(
                  onPressed: onPressed,
                  style:
                      ElevatedButton.styleFrom(minimumSize: Size(200.w, 50.h)),
                  child: Text(e[3]),
                ).paddingSymmetric(vertical: 50.h).expand().row(),
              ],
            ),
          ).expand(),
        ],
      ),
    );
  }
}

class ClampingScrollPhysics extends ScrollPhysics {
  const ClampingScrollPhysics({super.parent});

  @override
  ClampingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ClampingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    } else if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      return value - position.pixels;
    }
    return 0.0;
  }
}
