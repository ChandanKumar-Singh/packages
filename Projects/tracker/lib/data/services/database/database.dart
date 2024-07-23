import 'package:ext_plus/ext_plus.dart';
import '/data/models/index.dart';

/// `Database` is an abstract class that is used to define the structure of the database service.
abstract class Database {
  Future<AuthUser?> getUserData(String id);
  Future<void> setUserData(String id, MapType data, {bool merge = true});
}
