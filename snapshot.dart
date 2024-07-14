import 'package:flutter/material.dart';

extension WhenAsyncSnapshot<T> on AsyncSnapshot<T> {
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
