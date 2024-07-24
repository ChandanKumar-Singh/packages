part of '../dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        bg(),
        NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              AuthUser currentUser = UserRepository.instance.currentUser!;
              return <Widget>[
                SliverAppBar(
                  // expandedHeight: 250.0,
                  collapsedHeight: kToolbarHeight + 100,
                  scrolledUnderElevation: 10,
                  elevation: 0,
                  pinned: true,
                  floating: false,
                  snap: false,
                  titleSpacing: 0,
                  leadingWidth: 0,
                  // backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsetsDirectional.only(
                        start: kToolbarHeight / 2, bottom: kToolbarHeight / 2),
                    title: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    currentUser.photoUrl.validate()),
                              ),
                            ),
                          ).paddingBottom(10),
                          Text(
                            currentUser.name.validate(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // centerTitle: true,
                    stretchModes: const [
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                      StretchMode.zoomBackground,
                    ],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://imgs.search.brave.com/Je1f11WMva-ibYPhFs0gndSfJ4ScomomxrYu-0a9hvg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE0/NDUyNjIxMDIzODct/NWZiYjMwYTVlNTlk/P3E9ODAmdz0xMDAw/JmF1dG89Zm9ybWF0/JmZpdD1jcm9wJml4/bGliPXJiLTQuMC4z/Jml4aWQ9TTN3eE1q/QTNmREI4TUh4elpX/RnlZMmg4Tkh4OGJX/OXlibWx1WnlVeU1H/NWhkSFZ5Wlh4bGJu/d3dmSHd3Zkh4OE1B/PT0.jpeg',
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 20.0,
                          right: 20.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text(
                              'Good Morning',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Today',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      const Text(
                        'Upcoming',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      const Text(
                        'Recent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }

  ImageFiltered bg() {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            image: NetworkImage(
                'https://imgs.search.brave.com/FQ7cPg02JlOuChMcVDPyKgbpASO8vNeWA0eCLg8NPew/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aGluZGlzb2NoLmNv/bS93cC1jb250ZW50/L3VwbG9hZHMvMjAx/OS8wNy9OYXR1cmUt/R29vZC1Nb3JuaW5n/LUJpcmRzLUltYWdl/LVBob3RvLmpwZw'),
          ),
        ),
      ),
    );
  }
}
