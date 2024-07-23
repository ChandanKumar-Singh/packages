extension StringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  String get capitalize =>
      this!.isNotEmpty ? '${this![0].toUpperCase()}${this!.substring(1)}' : '';

  String get capitalizeFirstOfEach => this!.isNotEmpty
      ? this!
          .split(' ')
          .map((str) => str.isNotEmpty
              ? '${str[0].toUpperCase()}${str.substring(1)}'
              : '')
          .join(' ')
      : '';

  String get capitalizeFirstOfEachWord => this!.isNotEmpty
      ? this!.split(' ').map((str) => str.capitalize).join(' ')
      : '';

  String get capitalizeFirstOfEachSentence => this!.isNotEmpty

      // Split the string into sentences
      ? this!
          .split(RegExp(r'(?<=[.!?])\s+'))
          .map((str) => str.capitalize)
          .join(' ')
      : '';

  String validate([String defaultValue = '']) =>
      this!.isNullOrEmpty ? defaultValue : this!;

  bool get isEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this!);

  bool toBool() => this == 'true';
}
