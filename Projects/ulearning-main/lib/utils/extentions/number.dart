import 'package:flutter/material.dart';

extension IntExt on num {
  Widget get width => SizedBox(width: toDouble());
  Widget get height => SizedBox(height: toDouble());
  Duration get second => Duration(seconds: toInt());
  Duration get milliseconds => Duration(milliseconds: toInt());
}
