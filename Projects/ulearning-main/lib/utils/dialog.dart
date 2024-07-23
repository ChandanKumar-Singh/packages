import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '/utils/extentions/index.dart';

enum ToastAlignment { top, topCenter, center, bottomCenter, bottom }

extension on ToastAlignment {
  double getYAlignment() {
    switch (this) {
      case ToastAlignment.top:
        return -0.8;
      case ToastAlignment.topCenter:
        return -0.5;
      case ToastAlignment.center:
        return 0;
      case ToastAlignment.bottomCenter:
        return 0.5;
      case ToastAlignment.bottom:
        return 0.9;
      default:
        return 0;
    }
  }
}

successToast(
  String message, {
  int duration = 2000,
  bool autoDismiss = true,
  ToastAlignment alignment = ToastAlignment.top,
}) {
  _getToast(
    message,
    _ToastType.success,
    duration: duration,
    autoDismiss: autoDismiss,
    alignment: alignment,
  );
}

errorToast(
  String message, {
  int duration = 2000,
  bool autoDismiss = true,
  ToastAlignment alignment = ToastAlignment.top,
}) {
  _getToast(
    message,
    _ToastType.error,
    duration: duration,
    autoDismiss: autoDismiss,
    alignment: alignment,
  );
}

warningToast(
  String message, {
  int duration = 2000,
  bool autoDismiss = true,
  ToastAlignment alignment = ToastAlignment.top,
}) {
  _getToast(
    message,
    _ToastType.warning,
    duration: duration,
    autoDismiss: autoDismiss,
    alignment: alignment,
  );
}

infoToast(
  String message, {
  int duration = 2000,
  bool autoDismiss = true,
  ToastAlignment alignment = ToastAlignment.top,
}) {
  _getToast(
    message,
    _ToastType.info,
    duration: duration,
    autoDismiss: autoDismiss,
    alignment: alignment,
  );
}

Future<void> _getToast(
  String message,
  _ToastType type, {
  int duration = 2000,
  bool autoDismiss = true,
  ToastAlignment alignment = ToastAlignment.top,
}) async {
  if (message.isEmpty) return;
  message = message.trim().split('.').first;
  return SmartDialog.showToast(
    message,
    usePenetrate: true,
    alignment: Alignment(0, alignment.getYAlignment()),
    displayType: SmartToastType.onlyRefresh,
    displayTime: Duration(milliseconds: duration),
    builder: (context) {
      return _ToastUI(message: message, type: type).fitted();
    },
  );
}

class _ToastUI extends StatelessWidget {
  const _ToastUI({required this.message, required this.type});
  final String message;
  final _ToastType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(20),
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          type == _ToastType.success
              ? const Icon(Icons.check_circle_rounded, color: Colors.green)
              : type == _ToastType.error
                  ? const Icon(Icons.error_rounded, color: Colors.red)
                  : type == _ToastType.warning
                      ? const Icon(Icons.warning_rounded, color: Colors.orange)
                      : const Icon(Icons.info_rounded, color: Colors.blue),
          20.width,
          Text(message, style: context.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

enum _ToastType { success, error, warning, info }

hideLoading() {
  SmartDialog.dismiss();
}

/// loading dialog
showLoading({String msg = 'Loading...'}) {
  SmartDialog.showLoading(msg: msg);
}
