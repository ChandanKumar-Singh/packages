import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/material.dart';

/// to use this class, you can call it like this:
class CustomDialog extends StatefulWidget {
  CustomDialog._() {
    logg('This is custom dialog instance');
  }
  factory CustomDialog() => CustomDialog._();

  CustomDialog.alert({
    super.key,
    required BuildContext context,
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
      },
    );
  }

  CustomDialog.confirm({
    super.key,
    required BuildContext context,
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
      },
    );
  }

  CustomDialog.loading({
    super.key,
    required BuildContext context,
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: LoadingDialog(),
        );
      },
    );
  }

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, this.height = 150, this.width = 150});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// to use this class, you can call it like this:
///
/// FlutterSmartDialog.init() in [MaterialApp] builder
// successToast(String title) {
//   SmartDialog.showToast(
//     title,
//     displayType: SmartToastType.onlyRefresh,
//     builder: (context) => Container(
//       margin: const EdgeInsetsDirectional.all(20),
//       decoration: BoxDecoration(
//         color: context.theme.scaffoldBackgroundColor,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 1,
//             offset: const Offset(0, 1),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         children: [
//           const Icon(Icons.check_circle, color: Colors.green),
//           20.width,
//           Text(title, style: context.textTheme.bodyMedium?.copyWith()),
//         ],
//       ),
//     ).fitted(),
//     displayTime: const Duration(seconds: 3),
//     alignment: const Alignment(0, 0.8),
//     maskColor: Colors.black.withOpacity(0.5),
//     onMask: () {},
//   );
// }

// errorToast(String title) {
//   SmartDialog.showToast(
//     title,
//     displayType: SmartToastType.onlyRefresh,
//     builder: (context) => Container(
//       margin: const EdgeInsetsDirectional.all(20),
//       decoration: BoxDecoration(
//         color: context.theme.scaffoldBackgroundColor,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 1,
//             offset: const Offset(0, 1),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         children: [
//           const Icon(Icons.error, color: Colors.red),
//           20.width,
//           Text(title, style: context.textTheme.bodyMedium?.copyWith()),
//         ],
//       ),
//     ).fitted(),
//     displayTime: const Duration(seconds: 3),
//     alignment: const Alignment(0, 0.8),
//     maskColor: Colors.black.withOpacity(0.5),
//     onMask: () {},
//   );
// }

// warningToast(String title) {
//   SmartDialog.showToast(
//     title,
//     builder: (context) => Container(
//       margin: const EdgeInsetsDirectional.all(20),
//       decoration: BoxDecoration(
//         color: context.theme.scaffoldBackgroundColor,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 1,
//             offset: const Offset(0, 1),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         children: [
//           const Icon(Icons.warning, color: Colors.amber),
//           20.width,
//           Text(title, style: context.textTheme.bodyMedium?.copyWith()),
//         ],
//       ),
//     ).fitted(),
//     displayTime: const Duration(seconds: 3),
//     alignment: const Alignment(0, 0.8),
//     maskColor: Colors.black.withOpacity(0.5),
//     onMask: () {},
//   );
// }

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
