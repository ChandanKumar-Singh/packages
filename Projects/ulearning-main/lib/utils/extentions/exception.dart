class UnhandledException implements Exception {
  final String? message;
  final StackTrace? stackTrace;

  UnhandledException([
    this.message = 'Unhandled exception',
    this.stackTrace,
  ]);
}
