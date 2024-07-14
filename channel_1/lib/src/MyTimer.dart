import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTimer extends StatefulWidget {
  @override
  _MyTimerState createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  static const MethodChannel _methodChannel = MethodChannel('timer');
  static const EventChannel _eventChannel = EventChannel('events');

  StreamSubscription? _streamSubscription;
  String _timerEvent = 'No Event';

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _startListening() {
    _streamSubscription =
        _eventChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        _timerEvent = 'Timer event received at ${DateTime.now()} ${event.toString()}';
      });
    });
  }

  Future<void> _startTimer() async {
    try {
      await _methodChannel.invokeMethod('startTimer');
    } on PlatformException catch (e) {
      print("Failed to start timer: '${e.message}'.");
    }
  }

  Future<void> _stopTimer() async {
    try {
      await _methodChannel.invokeMethod('stopTimer');
    } on PlatformException catch (e) {
      print("Failed to stop timer: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter MethodChannel Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_timerEvent),
              ElevatedButton(
                onPressed: _startTimer,
                child: const Text('Start Timer'),
              ),
              ElevatedButton(
                onPressed: _stopTimer,
                child: const Text('Stop Timer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
