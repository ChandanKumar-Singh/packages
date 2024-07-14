import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class SliverPersistentAppBar extends StatelessWidget {
  const SliverPersistentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double expandedHeight = 150.0;
    double imageRadius = 70.0;
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverAppBar(
                expandedHeight: expandedHeight, imageRadius: imageRadius),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: expandedHeight / 2 + imageRadius / 2),
              listCardWidget(text1: 'Full Name:', text2: 'George John Carter'),
              listCardWidget(text1: 'Father\'s Name:', text2: 'John Carter'),
              listCardWidget(text1: 'Gender:', text2: 'Male'),
              listCardWidget(text1: 'Marital Status:', text2: 'Single'),
              listCardWidget(text1: 'Email:', text2: 'jane123@123.com'),
              listCardWidget(text1: 'Username:', text2: 'misty123'),
              listCardWidget(text1: 'Phone:', text2: '0987654321'),
              listCardWidget(text1: 'Country', text2: 'India'),
              listCardWidget(text1: 'City', text2: 'Hyderabad'),
              listCardWidget(text1: 'Pincode:', text2: '500014'),
              listCardWidget(text1: 'Company:', text2: 'All Shakes'),
              listCardWidget(text1: 'Website:', text2: 'allshakes.com'),
              listCardWidget(text1: 'Position', text2: 'Manager'),
              listCardWidget(text1: 'LinkedIn Id:', text2: 'misty123'),
              listCardWidget(text1: 'Interest:', text2: 'Swimming,Cycling'),
            ]),
          )
        ],
      ),
    );
  }

  Widget listCardWidget({required String text1, required text2}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Text(text1, style: const TextStyle(fontSize: 18)),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Text(
                text2,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapsedHeight;
  final double imageRadius;

  MySliverAppBar(
      {required this.expandedHeight,
      this.collapsedHeight = kToolbarHeight * 1.5,
      required this.imageRadius});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double topHeight = kToolbarHeight / 5;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.topLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff8360c3),
                Color(0xff2ebf91),
              ],
            ),
          ),
          child: backButton(context),
        ),
        collapsedTitle(shrinkOffset, context),
        expandedTitle(topHeight, shrinkOffset, context),
      ],
    );
  }

  Positioned expandedTitle(
      double topHeight, double shrinkOffset, BuildContext context) {
    return Positioned(
      top: topHeight - shrinkOffset,
      left: 0,
      right: 0,
      child: Opacity(
        opacity: (1 - shrinkOffset / expandedHeight),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Check out my Profile',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CircularProfileAvatar(
                  'https://imgs.search.brave.com/QH6a7hxHYyMjJpqsJwvB1eTlTgL_lTS4-ZKRmy9qbPA/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAyMS8w/OC8wNC8xMy8wNi9z/b2Z0d2FyZS1kZXZl/bG9wZXItNjUyMTcy/MF82NDAuanBn',
                  // child: Image.asset(
                  //   'assets/images/avatar.png',
                  //   fit: BoxFit.fill,
                  // ),
                  radius: imageRadius,
                  backgroundColor: Colors.transparent,
                  borderColor: const Color.fromARGB(255, 229, 247, 218),
                  borderWidth: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea collapsedTitle(double shrinkOffset, BuildContext context) {
    return SafeArea(
      child: Center(
        child: Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Text(
            'My Profile',
            style: TextStyle(
              color: Theme.of(context).appBarTheme.foregroundColor,
              fontWeight: FontWeight.w700,
              fontSize: 23,
            ),
          ),
        ),
      ),
    );
  }

  SafeArea backButton(BuildContext context) {
    return SafeArea(
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
