import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tracker/core/helper/notification/notification_helper.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

const simpleTaskKey = "be.tramckrijte.workmanagerExample.simpleTask";
const rescheduledTaskKey = "be.tramckrijte.workmanagerExample.rescheduledTask";
const failedTaskKey = "be.tramckrijte.workmanagerExample.failedTask";
const simpleDelayedTask = "be.tramckrijte.workmanagerExample.simpleDelayedTask";
const simplePeriodicTask =
    "be.tramckrijte.workmanagerExample.simplePeriodicTask";
const simplePeriodic1HourTask =
    "be.tramckrijte.workmanagerExample.simplePeriodic1HourTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await getSharedPref();
    await NotificationHelper().initializeNotifications();
    switch (task) {
      case simpleTaskKey:
        printF("$simpleTaskKey was executed. inputData = $inputData");
        prefs.setBool("test", true);
        printF("Bool from prefs: ${prefs.getBool("test")}");
        break;
      case rescheduledTaskKey:
        final key = inputData!['key']!;
        if (prefs.containsKey('unique-$key')) {
          printF('has been running before, task is successful');
          return true;
        } else {
          await prefs.setBool('unique-$key', true);
          printF('reschedule task');
          return false;
        }
      case failedTaskKey:
        printF('failed task');
        return Future.error('failed to execute task');
      case simpleDelayedTask:
        printF("$simpleDelayedTask was executed");

        NotificationHelper().showHighImportanceNotification("Delayed Task",
            body: "This is a delayed task notification");
        break;
      case simplePeriodicTask:
        printF("$simplePeriodicTask was executed");
        NotificationHelper().showHighImportanceNotification("Periodic Task",
            body: "This is a periodic task notification");
        break;
      case simplePeriodic1HourTask:
        printF("$simplePeriodic1HourTask was executed");
        break;
      case Workmanager.iOSBackgroundTask:
        printF("The iOS background fetch was triggered");
        Directory? tempDir = await getTemporaryDirectory();
        String? tempPath = tempDir.path;
        printF(
            "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
        break;
    }

    return Future.value(true);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Flutter WorkManager Example")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Plugin initialization",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ElevatedButton(
                  child: const Text("Start the Flutter background service"),
                  onPressed: () {
                    Workmanager()
                        .initialize(callbackDispatcher, isInDebugMode: true);
                  },
                ),
                const SizedBox(height: 16),

                //This task runs once.
                //Most likely this will trigger immediately
                ElevatedButton(
                  child: const Text("Register OneOff Task"),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      simpleTaskKey,
                      simpleTaskKey,
                      inputData: <String, dynamic>{
                        'int': 1,
                        'bool': true,
                        'double': 1.0,
                        'string': 'string',
                        'array': [1, 2, 3],
                      },
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text("Register rescheduled Task"),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      rescheduledTaskKey,
                      rescheduledTaskKey,
                      inputData: <String, dynamic>{
                        'key': Random().nextInt(64000),
                      },
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text("Register failed Task"),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      failedTaskKey,
                      failedTaskKey,
                    );
                  },
                ),
                //This task runs once
                //This wait at least 10 seconds before running
                ElevatedButton(
                    child: const Text("Register Delayed OneOff Task"),
                    onPressed: () {
                      NotificationHelper().showHighImportanceNotification(
                          "Delayed Task",
                          body: "This is a delayed task notification");
                      Workmanager().registerOneOffTask(
                        simpleDelayedTask,
                        simpleDelayedTask,
                        initialDelay: const Duration(seconds: 10),
                      );
                    }),
                const SizedBox(height: 8),
                //This task runs periodically
                //It will wait at least 10 seconds before its first launch
                //Since we have not provided a frequency it will be the default 15 minutes
                ElevatedButton(
                    onPressed: Platform.isAndroid
                        ? () {
                            Workmanager().registerPeriodicTask(
                              simplePeriodicTask,
                              simplePeriodicTask,
                              initialDelay: const Duration(seconds: 5),
                            );
                          }
                        : null,
                    child: const Text("Register Periodic Task new (Android)")),
                //This task runs periodically
                //It will run about every hour
                ElevatedButton(
                    onPressed: Platform.isAndroid
                        ? () {
                            Workmanager().registerPeriodicTask(
                              simplePeriodicTask,
                              simplePeriodic1HourTask,
                              frequency: const Duration(minutes: 1),
                            );
                          }
                        : null,
                    child: const Text(
                        "Register 1 min Periodic Task new (Android)")),
                const SizedBox(height: 16),
                Text(
                  "Task cancellation",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ElevatedButton(
                  child: const Text("Cancel All"),
                  onPressed: () async {
                    await Workmanager().cancelAll();
                    printF('Cancel all tasks completed');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
