import '../utils/log.dart' as lg;

extension ObjectExt on Object? {
  bool isNull() => this == null;
  bool isNotNull() => this != null;
}
