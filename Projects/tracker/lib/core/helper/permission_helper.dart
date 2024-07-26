import 'package:location/location.dart' as lc;
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  
  Future<void> checkPermissions(Permission permission) async {}
  Future<bool> checkLocationPermissions() async {
    lc.Location location = lc.Location();
    bool serviceEnabled = await location.serviceEnabled();
    lc.PermissionStatus permissionGranted = await location.hasPermission();
    if (!serviceEnabled || permissionGranted != lc.PermissionStatus.granted) {
      return false;
    }
    return true;
  }
}
