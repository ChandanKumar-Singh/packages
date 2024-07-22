import 'package:flutter/material.dart';

import 'theme_change_button.dart';

PreferredSize transparentAppBar(
  BuildContext context, {
  String? title,
  double? elevation,
  double? height,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height ?? 50),
    child: AppBar(
      toolbarHeight: height ?? 0,
      title: title != null
          ? Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black),
            )
          : null,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: const [ThemeChangeButton()],
    ),
  );
}
