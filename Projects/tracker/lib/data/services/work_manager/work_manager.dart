import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';
import 'package:tracker/core/helper/permission_helper.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp();
    Location location = Location();
    bool serviceEnabled = await PermissionHelper().checkLocationPermissions();
    if (!serviceEnabled) return false;
    location.onLocationChanged.listen((LocationData currentLocation) {
      FirebaseFirestore.instance.collection('locations').add({
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });

    return Future.value(true);
  });
}

class BackgroundServices {
  BackgroundServices._();
  BackgroundServices get instance => _instance;
  static final BackgroundServices _instance = BackgroundServices._();

  factory BackgroundServices() => _instance;

  void init() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager().registerPeriodicTask(
      '1',
      'location_background_task',
      frequency: const Duration(minutes: 1),
    );
  }
}


