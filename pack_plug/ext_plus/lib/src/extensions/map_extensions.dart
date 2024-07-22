extension MapExt<T> on Map<T, dynamic>? {
  String joinWithMap(String separator, {String keyValueSeparator = '='}) {
    return this
            ?.entries
            .map((entry) => "${entry.key}$keyValueSeparator${entry.value}")
            .join(separator) ??
        '';
  }

  Map<T, dynamic> filter(bool Function(T key, dynamic value) predicate) {
    return Map.fromEntries(
        this?.entries.where((entry) => predicate(entry.key, entry.value)) ??
            []);
  }

  Map<T, dynamic> filterKeys(bool Function(T key) predicate) {
    return Map.fromEntries(
        this?.entries.where((entry) => predicate(entry.key)) ?? []);
  }

  Map<T, dynamic> filterValues(bool Function(dynamic value) predicate) {
    return Map.fromEntries(
        this?.entries.where((entry) => predicate(entry.value)) ?? []);
  }

  Map<T, dynamic> mapValues(dynamic Function(dynamic value) f) {
    return Map.fromEntries(
        this?.entries.map((entry) => MapEntry(entry.key, f(entry.value))) ??
            []);
  }

  Map<T, dynamic> mapKeys(T Function(T key) f) {
    return Map.fromEntries(
        this?.entries.map((entry) => MapEntry(f(entry.key), entry.value)) ??
            []);
  }

  Map<T, dynamic> mapEntries(
      MapEntry<T, dynamic> Function(MapEntry<T, dynamic> entry) f) {
    return Map.fromEntries(this?.entries.map(f) ?? []);
  }

  Map<T, dynamic> removeKeys(Iterable<T> keys) {
    return Map.fromEntries(
        this?.entries.where((entry) => !keys.contains(entry.key)) ?? []);
  }

  Map<T, dynamic> removeValues(Iterable<dynamic> values) {
    return Map.fromEntries(
        this?.entries.where((entry) => !values.contains(entry.value)) ?? []);
  }

  Map<T, dynamic> removeWhere(bool Function(T key, dynamic value) f) {
    return Map.fromEntries(
        this?.entries.where((entry) => !f(entry.key, entry.value)) ?? []);
  }

  Map<T, dynamic> validate() => this ?? <T, dynamic>{};
}
