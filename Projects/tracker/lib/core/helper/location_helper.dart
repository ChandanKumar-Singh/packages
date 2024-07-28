import 'package:ext_plus/ext_plus.dart';
import 'package:location/location.dart';

import 'index.dart';

class LocationHelper {
  static const tag = 'LocationHelper';
  static Future<bool?> checkLocationPermission(Location location) async {
    bool serviceEnabled = await PermissionHelper().checkLocationPermissions();
    logg('getLocations serviceEnabled $serviceEnabled', name: tag);
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw UnKnonwException('Location service is disabled');
      }
    }
    return null;
  }
}
