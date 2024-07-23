part of '../home.dart';

class HomeCardSwiper extends StatefulWidget {
  const HomeCardSwiper({super.key});

  @override
  State<HomeCardSwiper> createState() => _HomeCardSwiperState();
}

class _HomeCardSwiperState extends State<HomeCardSwiper> {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfyrZ1YeKDbEqNz2gp6IHEbPfxd_fJQI_hrw&s',
      'https://w0.peakpx.com/wallpaper/312/989/HD-wallpaper-data-analytics-certification-course-in-electronic-city-bangalore-education-data-analytics-data-analytics-course-training-course.jpg',
      'https://cdn.analyticsvidhya.com/wp-content/uploads/2024/05/5-Free-University-Courses-to-Learn-Machine-Learning-.png',
    ];
    return Swiper(
      indicatorLayout: PageIndicatorLayout.COLOR,
      itemBuilder: (context, i) => itemBuilder(context, i, images[i]),
      itemCount: images.length,
      autoplay: true,
      outer: true,
      loop: false,
      viewportFraction: 1,
      scale: 0.8,
      pagination: const SwiperPagination(),
    ).size(width: double.infinity, height: 200);
  }

  Widget itemBuilder(BuildContext context, int index, dynamic item) {
    return Image.network(
      item,
      fit: BoxFit.fitWidth,
    ).clipRoundRect(borderRadiusDefault.w);
  }
}
