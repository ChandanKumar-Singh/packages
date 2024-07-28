import 'package:ext_plus/ext_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/firebase_options.dart';

import 'business_logics/blocs/index.dart';
import 'core/index.dart';
import 'presentation/routes/index.dart';
import 'package:go_router/go_router.dart';
part 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  SocketManager('http://192.168.1.125:3000');
  runApp(const _TrackerApp());
}

Future<void> initServices() async {
  await Future.wait([
    Firebase.initializeApp(options: FirebasePlatformOptions.defaultOption),
    /// Helpers
    SpHelper().init(),
  ]);
}
