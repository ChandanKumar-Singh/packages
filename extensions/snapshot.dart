import 'package:flutter/material.dart';

extension WhenAsyncSnapshot<T> on AsyncSnapshot<T> {
  /// A utility extension on AsyncSnapshot to handle different states
  /// (data, loading, error, empty) in a concise and readable manner.
  ///
  /// ```dart
  /// StreamBuilder<int>(
  ///   stream: counterStream,
  ///   builder: (context, snapshot) {
  ///     return snapshot.when(
  ///       data: (value) => Text('Value: $value'),
  ///       loading: () => CircularProgressIndicator(),
  ///       error: (error, stackTrace) => Text('Error: $error'),
  ///       empty: () => Text('Empty'),
  ///     );
  ///   },
  /// );
  /// ```
  ///
  /// - [empty] Function to call when the snapshot has no data and is not loading.
  /// - [error] Function to call when the snapshot contains an error.
  /// - [loading] Function to call when the snapshot is waiting for data.
  /// - [data] Function to call when the snapshot contains data.
  ///
  /// Throws [UnsupportedError] if none of the provided functions match the current state.

  R when<R>({
    R Function()? empty,
    R Function(dynamic error, StackTrace? stackTrace)? error,
    R Function()? loading,
    R Function(T value)? data,
  }) {
    if (hasData) {
      if (data != null) {
        return data(requireData);
      }
    } else if (connectionState == ConnectionState.waiting) {
      if (loading != null) {
        return loading();
      }
    } else if (hasError) {
      if (error != null) {
        return error(this.error, stackTrace);
      }
    } else {
      if (empty != null) {
        return empty();
      }
    }

    throw UnsupportedError('Missing parameters to when()');
  }
}
