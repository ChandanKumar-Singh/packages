part of 'main.dart';

class _TrackerApp extends StatefulWidget {
  const _TrackerApp();

  @override
  State<_TrackerApp> createState() => __TrackerAppState();
}

class __TrackerAppState extends State<_TrackerApp> {
  /// The route configuration.
  final GoRouter _router = goRouter;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...Blocs.blocs],
      child: ScreenUtilInit(
        builder: (context, child) {
          return BlocConsumer<ThemeBloc, ThemeState>(
            listener: (context, state) {},
            builder: (context, themeState) {
              return MaterialApp.router(
                routerConfig: _router,
                // routerDelegate: _router.routerDelegate,
                key: navigatorKey,
                title: 'Tracker App',
                debugShowCheckedModeBanner: false,
                themeMode: themeState.themeMode,
                theme: _theme(),
                darkTheme: ThemeData.dark(),
                // initialRoute: Splash.routeName,
                // navigatorObservers: [FlutterSmartDialog.observer],
                builder: FlutterSmartDialog.init(),
                // onGenerateRoute: onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }

  ThemeData _theme() {
    return ThemeData(
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      useMaterial3: true,
    );
  }
}
