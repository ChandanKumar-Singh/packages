part of 'landing.dart';

class LandingBottomBar extends StatefulWidget {
  const LandingBottomBar({super.key});

  @override
  State<LandingBottomBar> createState() => _LandingBottomBarState();
}

class _LandingBottomBarState extends State<LandingBottomBar> {
  void _onBottomNavTapped(int index) {
    context.read<AppBloc>().add(AppChangeBottomNavEvent(index));
  }

  dynamic getIcon(String icon) {
    String img = '';
    switch (icon) {
      case 'home':
        img = MyPng.home;
      case 'search':
        img = MyPng.search;
      case 'play':
        img = MyPng.play;
      case 'chat':
        img = MyPng.chat;
      case 'profile':
        img = MyPng.profile;
      default:
        img = MyPng.home;
    }
    return Image.asset(
      img,
      width: 35,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TabItem> items = [
      const TabItem(icon: Iconic.home),
      const TabItem(icon: Iconic.search),
      const TabItem(icon: Iconic.comment),
      const TabItem(icon: Iconic.play),
      const TabItem(icon: Iconic.user),
    ];
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Container(
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomBarDefault(
            items: items,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            colorSelected: context.theme.primaryColor,
            color: Colors.grey,
            // colorSelected: Colors.white,
            indexSelected: state.bottomNavIndex,
            onTap: _onBottomNavTapped,
            // top: -25,
            animated: true,
            // itemStyle: ItemStyle.circle,
            // chipStyle: const ChipStyle(drawHexagon: true),
          ),
        );
      },
    );
  }
}
