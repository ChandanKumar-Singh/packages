part of 'main.dart';
class _TrackerApp extends StatefulWidget {
  const _TrackerApp({super.key});

  @override
  State<_TrackerApp> createState() => __TrackerAppState();
}

class __TrackerAppState extends State<_TrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: Center(
          child: Text('Hello, World!'),
        ),
      )
    );
  }
}