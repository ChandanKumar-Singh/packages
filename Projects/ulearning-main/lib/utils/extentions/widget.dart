import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/views/widgets/index.dart';

extension WidgetExt on Widget {
  Widget sized(double s) => SizedBox(width: s, height: s, child: this);
  Widget fitted({
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
    Alignment alignment = Alignment.center,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: fit,
        alignment: alignment,
        clipBehavior: Clip.hardEdge,
        child: this,
      ),
    );
  }

  Widget padding({
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? all,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: top ?? 0,
        bottom: bottom ?? 0,
        start: left ?? 0,
        end: right ?? 0,
      ),
      child: this,
    );
  }

  Widget paddingAll(double padding) {
    return Padding(padding: EdgeInsetsDirectional.all(padding), child: this);
  }

  Widget paddingSymmetric({double? vertical, double? horizontal}) {
    return Padding(
        padding: EdgeInsetsDirectional.symmetric(
            vertical: vertical ?? 0, horizontal: horizontal ?? 0),
        child: this);
  }

  Widget margin({
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? all,
  }) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        top: top ?? 0,
        bottom: bottom ?? 0,
        start: left ?? 0,
        end: right ?? 0,
      ),
      child: this,
    );
  }

  Widget row({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    List<Widget> children = const [],
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [this, ...children],
      );

  Widget size({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  Widget expand({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget centerLeft() => Row(children: [const Spacer(), this]);

  Widget centerRight() => Row(children: [this, const Spacer()]);

  Widget centerTop() => Column(children: [const Spacer(), this]);

  Widget centerBottom() => Column(children: [this, const Spacer()]);

  Widget center() => Center(child: this);

  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);

  Widget background(Color color) => Container(color: color, child: this);

  Widget borderRadius(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  Widget elevation(double elevation) =>
      Material(elevation: elevation, child: this);

  Widget clipRoundRect(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  Widget clipRoundRectOnly(
          {double topLeft = 0,
          double topRight = 0,
          double bottomLeft = 0,
          double bottomRight = 0}) =>
      ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        ),
        child: this,
      );

  Widget clipOval() => ClipOval(child: this);

  Widget shadow(
      {Color color = Colors.black,
      double blurRadius = 10,
      double spreadRadius = 0,
      Offset offset = Offset.zero}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
            offset: offset,
          ),
        ],
      ),
      child: this,
    );
  }

  Widget onTap(
    VoidCallback onTap, {
    double radius = 16.0,
    Color? splashColor,
    Color? highlightColor,
    Color? hoverColor,
    Color? focusColor,
    double elevation = 0.0,
    EdgeInsets padding = const EdgeInsets.all(0.0),
    BorderSide? border,
    Color? backgroundColor,
    bool shrinkOnTap = true,
    bool vibrateOnTap = true,
    bool showHaptic = true,
    bool showHover = true,
    bool showFocus = true,
    bool soundOnTap = true,
  }) {
    return DynamicButton(
      onTap: onTap,
      radius: radius,
      splashColor: splashColor,
      highlightColor: highlightColor,
      hoverColor: hoverColor,
      focusColor: focusColor,
      elevation: elevation,
      padding: padding,
      border: border,
      backgroundColor: backgroundColor,
      shrinkOnTap: shrinkOnTap,
      vibrateOnTap: vibrateOnTap,
      showHaptic: showHaptic,
      showHover: showHover,
      showFocus: showFocus,
      soundOnTap: soundOnTap,
      child: this,
    );
    return Builder(builder: (context) {
      splashColor ??= Theme.of(context).splashColor;

      return GestureDetector(
        onTap: () {
          if (shrinkOnTap) {
            // Trigger shrinking animation
            ScaleTransition(
              scale: const AlwaysStoppedAnimation(0.95),
              child: this,
            );
          }
          if (vibrateOnTap && !kIsWeb) {
            HapticFeedback.vibrate();
          }
          if (showHaptic && !kIsWeb) {
            HapticFeedback.lightImpact();
          }
          if (soundOnTap) {
            // Add sound effect here if required
          }
          onTap();
        },
        child: MouseRegion(
          onEnter: showHover ? (event) => SystemMouseCursors.click : null,
          child: FocusableActionDetector(
            autofocus: showFocus,
            child: Material(
              color: Colors.transparent,
              elevation: elevation,
              borderRadius: BorderRadius.circular(radius),
              child: InkWell(
                onTap: onTap,
                splashColor: splashColor?.withOpacity(0.3),
                highlightColor: highlightColor?.withOpacity(0.2),
                hoverColor: hoverColor,
                focusColor: focusColor,
                borderRadius: BorderRadius.circular(radius),
                child: Container(
                  padding: padding,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(radius),
                    border:
                        border != null ? Border.fromBorderSide(border) : null,
                  ),
                  child: Center(child: this),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget onLongPress(VoidCallback onLongPress) =>
      GestureDetector(onLongPress: onLongPress, child: this);

  Widget onDoubleTap(VoidCallback onDoubleTap) =>
      GestureDetector(onDoubleTap: onDoubleTap, child: this);

  Widget onHorizontalDrag(DragStartBehavior dragStartBehavior,
      GestureDragUpdateCallback onHorizontalDragUpdate) {
    return GestureDetector(
      dragStartBehavior: dragStartBehavior,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      child: this,
    );
  }

  Widget onVerticalDrag(DragStartBehavior dragStartBehavior,
      GestureDragUpdateCallback onVerticalDragUpdate) {
    return GestureDetector(
      dragStartBehavior: dragStartBehavior,
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: this,
    );
  }

  Widget onPan(DragStartBehavior dragStartBehavior,
      GestureDragUpdateCallback onPanUpdate) {
    return GestureDetector(
      dragStartBehavior: dragStartBehavior,
      onPanUpdate: onPanUpdate,
      child: this,
    );
  }

  Widget scrollable({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    EdgeInsetsGeometry? padding,
    bool? primary,
    ScrollPhysics? physics,
    ScrollController? controller,
    Widget? child,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Clip clipBehavior = Clip.hardEdge,
    String? restorationId,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
  }) =>
      SingleChildScrollView(
        key: key,
        scrollDirection: scrollDirection,
        reverse: reverse,
        padding: padding,
        primary: primary,
        physics: physics,
        controller: controller,
        dragStartBehavior: dragStartBehavior,
        clipBehavior: clipBehavior,
        restorationId: restorationId,
        keyboardDismissBehavior: keyboardDismissBehavior,
        child: this,
      );

  Widget showDraggableWidget(Widget child) =>
      DraggableFloatingWidget(floatingWidget: child, child: this);

  Widget rotate(double angle) => Transform.rotate(angle: angle, child: this);

  Widget scale(double scale) => Transform.scale(scale: scale, child: this);

  Widget translate(double x, double y) =>
      Transform.translate(offset: Offset(x, y), child: this);

  Widget mirrorY() => Transform.scale(scale: -1, child: this);

  Widget mirrorX() => Transform.scale(scale: -1, child: this);

  Widget rotate90() => Transform.rotate(angle: 1.5708, child: this);

  Widget rotate45() => Transform.rotate(angle: 0.785398, child: this);

  Widget rotate180() => Transform.rotate(angle: 3.14159, child: this);

  Widget rotate270() => Transform.rotate(angle: 4.71239, child: this);
}
