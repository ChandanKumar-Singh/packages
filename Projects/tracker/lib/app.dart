part of 'main.dart';

class _TrackerApp extends StatefulWidget {
  const _TrackerApp();

  @override
  State<_TrackerApp> createState() => __TrackerAppState();
}

class __TrackerAppState extends State<_TrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...Blocs.blocs],
      child: ScreenUtilInit(
        builder: (context, child) {
          return BlocConsumer<ThemeBloc, ThemeState>(
            listener: (context, state) {},
            builder: (context, themeState) {
              return MaterialApp(
                title: 'Tracker App',
                debugShowCheckedModeBanner: false,
                themeMode: themeState.themeMode,
                theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.deepPurple,
                  primaryColor: Colors.deepPurple,
                  fontFamily: 'RobotoSerif',
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  checkboxTheme: CheckboxThemeData(
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.deepPurple;
                      }
                      return Colors.transparent;
                    }),
                    checkColor: WidgetStateProperty.all(Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData.dark(),
                initialRoute: LoginPage.routeName,
                navigatorObservers: [FlutterSmartDialog.observer],
                builder: FlutterSmartDialog.init(),
                onGenerateRoute: onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }

  Route<dynamic>? onGenerateRoute(settings) {
    switch (settings.name) {
      case Splash.routeName:
        return route(const Splash(), settings: settings);
      case LoginPage.routeName:
        return route(const LoginPage(), settings: settings);
      case DashBoardPage.routeName:
        return route(const DashBoardPage(), settings: settings);
      default:
        return route(const LoginPage(), settings: settings);
    }
  }
}

PageRoute route(
  Widget page, {
  RouteSettings? settings,
  bool maintainState = true,
  bool fullscreenDialog = false,
  bool allowSnapshotting = true,
  bool barrierDismissible = false,
}) {
  return MaterialPageRoute(
    builder: (_) => page,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
    allowSnapshotting: allowSnapshotting,
    barrierDismissible: barrierDismissible,
  );
}
