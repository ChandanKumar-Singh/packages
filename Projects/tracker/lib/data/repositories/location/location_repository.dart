import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:ext_plus/ext_plus.dart' hide Debouncer;
import 'package:location/location.dart';
import 'package:tracker/data/models/index.dart';
import 'package:tracker/data/repositories/auth/index.dart';

import '../../../core/index.dart';

class LocationRepository {
  /// add location of the user to the server
  Future<void> addLocation() async {
    printF('addLocation', name: runtimeType);
    LocationData? locationData = await getCurrentLocation();
    printF('addLocation locationData $locationData', name: runtimeType);
    if (locationData != null) await _uploadLocation(locationData);
  }

  /// [addLocationChange] location stream to the server
  Future<void> addLocationChange() async {
    printF('addLocationChange called', name: runtimeType);
    Location location = Location();
    var status = await LocationHelper.checkLocationPermission(location);
    if (status ?? false) return;
    location.onLocationChanged
        .asBroadcastStream()
        .listen((LocationData locationData) {
      EasyDebounce.debounce(
          'addLocationChange', const Duration(milliseconds: 5000), () async {
        printF('addLocationChange onLocationChanged locationData $locationData',
            name: runtimeType);
        await _uploadLocation(locationData);
      });
    });
  }

  /// upload location data to the server
  Future<void> _uploadLocation(LocationData locationData) async {
    var data = {
      'userId': UserRepository.instance.currentUser!.uid,
      'latitude': locationData.latitude,
      'longitude': locationData.longitude,
      'accuracy': locationData.accuracy,
      'altitude': locationData.altitude,
      'speed': locationData.speed,
      'speed_accuracy': locationData.speedAccuracy,
      'heading': locationData.heading,
      'time': locationData.time,
      'isMock': locationData.isMock,
      'verticalAccuracy': locationData.verticalAccuracy,
      'headingAccuracy': locationData.headingAccuracy,
      'elapsedRealtimeNanos': locationData.elapsedRealtimeNanos,
      'elapsedRealtimeUncertaintyNanos':
          locationData.elapsedRealtimeUncertaintyNanos,
      'satelliteNumber': locationData.satelliteNumber,
      'provider': locationData.provider,
    };
    printF('_uploadLocation got location data $data', name: runtimeType);
    SocketManager.instance.emit('addLocation', data);
  }

  /// get current location of the user on the device
  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    var status = await LocationHelper.checkLocationPermission(location);
    if (status ?? false) return null;
    LocationData locationData = await location.getLocation();
    return locationData;
  }

  /// listen to locations from the server
  Stream<List<LocationModel>> listenLocations(
      StreamController<List<LocationModel>> controller) async* {
    SocketManager.instance.on('listenLocation', (data) {
      if (data.runtimeType != List) return;
      logg('on listenLocation ${data.runtimeType} ${data.length}',
          name: runtimeType);
      List<LocationModel> locations = [];
      for (var item in data) {
        tryCatch(() => locations.add(LocationModel.fromJson(item)));
      }
      controller.add(locations);
    });
    SocketManager.instance.emit('listenLocation', {
      'userId': UserRepository.instance.currentUser!.uid,
    });
    yield* controller.stream.asBroadcastStream();
  }

  /// stop listening to locations from the server
  Future<void> stopListenLocations() async {
    SocketManager.instance.off('listenLocation');
  }
}
