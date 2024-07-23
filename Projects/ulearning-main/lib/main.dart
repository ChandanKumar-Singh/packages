// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import '/blocs/index.dart';
import '/firebase_options.dart';
import '/routes/route.dart';
import '/services/auth_service.dart';
import '/services/button_sound_services.dart';
import '/services/storage.dart';

import 'views/pages/auth/login/auth_page.dart';
import 'repository/auth_repository.dart';
import 'views/pages/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  await StorageService.instance.init();
  ButtonSoundServices.init();

  Bloc.observer = MyBlocObserver();

  /// user
  await AuthService.instance.loadAuthSetup();

  /// device
  TextInput.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (_) => AuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: [...Blocs.blocs],
        child: ScreenUtilInit(
          builder: (context, child) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                return MaterialApp(
                  title: 'Ulearning',
                  debugShowCheckedModeBanner: false,
                  themeAnimationCurve: Curves.fastLinearToSlowEaseIn,
                  themeMode: themeState.themeMode,
                  theme: themeState.themeData,
                  navigatorObservers: [FlutterSmartDialog.observer],
                  navigatorKey: NavigationService.navigatorKey,
                  builder: FlutterSmartDialog.init(),
                  initialRoute: Splash.routeName,
                  onGenerateRoute: (settings) {
                    switch (settings.name) {
                      case Splash.routeName:
                        return route(const Splash(), settings: settings);
                      case Welcome.routeName:
                        return route(const Welcome(), settings: settings);
                      case LandingPage.routeName:
                        return route(const LandingPage(), settings: settings);
                      case LoginPage.routeName:
                        return route(const LoginPage(), settings: settings);
                      case SignUpPage.routeName:
                        return route(const SignUpPage(), settings: settings);
                      case AuthPage.routeName:
                        return route(const AuthPage(), settings: settings);
                      default:
                        return route(const LoginPage(), settings: settings);
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
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
