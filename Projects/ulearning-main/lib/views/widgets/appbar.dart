import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/utils/extentions/index.dart';
import '/utils/index.dart';
import '/views/widgets/theme_switch_button.dart';

PreferredSize transparentAppBar(
  BuildContext context, {
  String? title,
  double? elevation,
  double? height,
  bool theme = false,
  bool centerTile = false,
  bool transparent = true,
  Widget? leading,
}) {
  transparent = transparent && height == 0;
  SystemUiOverlayStyle systemOverlayStyle = transparent
      ? context.isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark
      : SystemUiOverlayStyle.light;
  return PreferredSize(
    preferredSize: Size.fromHeight(height ?? 0),
    child: AppBar(
      toolbarHeight: height ?? 0,
      centerTitle: centerTile,
      title: title != null ? Text(title) : null,
      leading: leading,
      systemOverlayStyle: systemOverlayStyle,
      backgroundColor: transparent
          ? Colors.transparent
          : Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      actions: [
        if (theme) const ThemeSwitch(),
      ],
    ),
  );
}

/// Global appbar
PreferredSize buildAppbar(
  BuildContext context, {
  dynamic title,
  double? elevation,
  double? height,
  bool theme = false,
  bool centerTile = false,
  bool transparent = false,
  Widget? leading,
  List<Widget>? actions,
  Color? textColor,
}) {
  SystemUiOverlayStyle systemOverlayStyle = transparent
      ? context.isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark
      : SystemUiOverlayStyle.light;
  textColor = textColor ??
      (context.isDark || !transparent ? Colors.white : Colors.black);
  return PreferredSize(
    preferredSize: Size.fromHeight(height ?? 56),
    child: AppBar(
      iconTheme: context.theme.appBarTheme.iconTheme?.copyWith(
        color: context.isDark || !transparent ? Colors.white : Colors.black,
      ),
      toolbarHeight: height ?? 56,
      centerTitle: centerTile,
      title: title != null
          ? title is String
              ? Text(
                  title,
                  style:
                      context.textTheme.titleLarge?.copyWith(color: textColor),
                )
              : title is Widget
                  ? title
                  : null
          : null,
      leading: leading,
      systemOverlayStyle: systemOverlayStyle,
      backgroundColor: transparent
          ? Colors.transparent
          : Theme.of(context).appBarTheme.backgroundColor,
      elevation: elevation ?? 0,
      actions: [
        if (actions != null) ...actions,
        if (theme) const ThemeSwitch(),
      ],
    ),
  );
}
