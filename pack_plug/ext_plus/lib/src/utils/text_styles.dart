import 'package:flutter/material.dart';
import 'package:ext_pro/ext_pro.dart';

/// Text Styles

/// Returns a TextStyle with bold weight.
TextStyle boldTextStyle({
  int? size,
  Color? color,
  FontWeight? weight,
  String? fontFamily,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textBoldSizeGlobal,
    color: color ?? textPrimaryColorGlobal,
    fontWeight: weight ?? fontWeightBoldGlobal,
    fontFamily: fontFamily ?? fontFamilyBoldGlobal,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

/// Returns a TextStyle with primary color and default settings.
TextStyle primaryTextStyle({
  int? size,
  Color? color,
  FontWeight? weight,
  String? fontFamily,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textPrimarySizeGlobal,
    color: color ?? textPrimaryColorGlobal,
    fontWeight: weight ?? fontWeightPrimaryGlobal,
    fontFamily: fontFamily ?? fontFamilyPrimaryGlobal,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

/// Returns a TextStyle with secondary color and default settings.
TextStyle secondaryTextStyle({
  int? size,
  Color? color,
  FontWeight? weight,
  String? fontFamily,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textSecondarySizeGlobal,
    color: color ?? textSecondaryColorGlobal,
    fontWeight: weight ?? fontWeightSecondaryGlobal,
    fontFamily: fontFamily ?? fontFamilySecondaryGlobal,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

// Create Rich Text
@Deprecated('Use RichTextWidget instead')
RichText createRichText({
  required List<TextSpan> list,
  TextOverflow overflow = TextOverflow.clip,
  int? maxLines,
  TextAlign textAlign = TextAlign.left,
  TextDirection? textDirection,
  StrutStyle? strutStyle,
}) {
  return RichText(
    text: TextSpan(children: list),
    overflow: overflow,
    maxLines: maxLines,
    textAlign: textAlign,
    textDirection: textDirection,
    strutStyle: strutStyle,
  );
}
