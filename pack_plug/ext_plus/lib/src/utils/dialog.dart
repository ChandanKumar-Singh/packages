import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'log.dart';

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
successToast(String title) {
  SmartDialog.showToast(
    title,
    displayType: SmartToastType.onlyRefresh,
    builder: (context) => Container(
      margin: const EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          20.width,
          Text(title, style: context.textTheme.bodyMedium?.copyWith()),
        ],
      ),
    ).fitted(),
    displayTime: const Duration(seconds: 3),
    alignment: const Alignment(0, 0.8),
    maskColor: Colors.black.withOpacity(0.5),
    onMask: () {},
  );
}

errorToast(String title) {
  SmartDialog.showToast(
    title,
    displayType: SmartToastType.onlyRefresh,
    builder: (context) => Container(
      margin: const EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(Icons.error, color: Colors.red),
          20.width,
          Text(title, style: context.textTheme.bodyMedium?.copyWith()),
        ],
      ),
    ).fitted(),
    displayTime: const Duration(seconds: 3),
    alignment: const Alignment(0, 0.8),
    maskColor: Colors.black.withOpacity(0.5),
    onMask: () {},
  );
}

warningToast(String title) {
  SmartDialog.showToast(
    title,
    builder: (context) => Container(
      margin: const EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.amber),
          20.width,
          Text(title, style: context.textTheme.bodyMedium?.copyWith()),
        ],
      ),
    ).fitted(),
    displayTime: const Duration(seconds: 3),
    alignment: const Alignment(0, 0.8),
    maskColor: Colors.black.withOpacity(0.5),
    onMask: () {},
  );
}
