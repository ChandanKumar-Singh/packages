import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ext_plus/ext_plus.dart';

// Widget Extensions
extension WidgetExtension on Widget? {
  /// Returns a [SizedBox] with specified width and height
  SizedBox withSize({double width = 0.0, double height = 0.0}) {
    return SizedBox(height: height, width: width, child: this);
  }

  /// Returns a [SizedBox] with specified width
  SizedBox withWidth(double width) => SizedBox(width: width, child: this);

  /// Returns a [SizedBox] with specified height
  SizedBox withHeight(double height) => SizedBox(height: height, child: this);

  /// Adds padding to the top
  Padding paddingTop(double top) {
    return Padding(padding: EdgeInsetsDirectional.only(top: top), child: this);
  }

  /// Adds padding to the left
  Padding paddingLeft(double left) {
    return Padding(
        padding: EdgeInsetsDirectional.only(start: left), child: this);
  }

  /// Adds padding to the right
  Padding paddingRight(double right) {
    return Padding(
        padding: EdgeInsetsDirectional.only(end: right), child: this);
  }

  /// Adds padding to the bottom
  Padding paddingBottom(double bottom) {
    return Padding(
        padding: EdgeInsetsDirectional.only(bottom: bottom), child: this);
  }

  /// Adds padding to all sides
  Padding paddingAll(double padding) {
    return Padding(padding: EdgeInsetsDirectional.all(padding), child: this);
  }

  /// Adds padding to specified sides
  Padding paddingOnly({
    double top = 0.0,
    double left = 0.0,
    double bottom = 0.0,
    double right = 0.0,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(left, top, right, bottom),
      child: this,
    );
  }

  /// Adds symmetric padding
  Padding paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
          vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  /// Sets widget visibility
  Widget visible(bool visible, {Widget? defaultWidget}) {
    return visible ? this! : (defaultWidget ?? SizedBox());
  }

  /// Adds custom corner radius to each side
  ClipRRect cornerRadiusWithClipRRectOnly({
    int bottomLeft = 0,
    int bottomRight = 0,
    int topLeft = 0,
    int topRight = 0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(bottomLeft.toDouble()),
        bottomRight: Radius.circular(bottomRight.toDouble()),
        topLeft: Radius.circular(topLeft.toDouble()),
        topRight: Radius.circular(topRight.toDouble()),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  /// Adds a uniform corner radius
  ClipRRect cornerRadiusWithClipRRect(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  /// Sets widget visibility with additional options
  Visibility withVisibility(
    bool visible, {
    Widget? replacement,
    bool maintainAnimation = false,
    bool maintainState = false,
    bool maintainSize = false,
    bool maintainSemantics = false,
    bool maintainInteractivity = false,
  }) {
    return Visibility(
      visible: visible,
      maintainAnimation: maintainAnimation,
      maintainInteractivity: maintainInteractivity,
      maintainSemantics: maintainSemantics,
      maintainSize: maintainSize,
      maintainState: maintainState,
      replacement: replacement ?? SizedBox(),
      child: this!,
    );
  }

  /// Adds opacity to the widget
  Widget opacity({
    required double opacity,
    int durationInSecond = 1,
    Duration? duration,
  }) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration ?? Duration(milliseconds: 500),
      child: this,
    );
  }

  /// Rotates the widget
  Widget rotate({
    required double angle,
    bool transformHitTests = true,
    Offset? origin,
  }) {
    return Transform.rotate(
      origin: origin,
      angle: angle,
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  /// Scales the widget
  Widget scale({
    required double scale,
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
  }) {
    return Transform.scale(
      scale: scale,
      origin: origin,
      alignment: alignment,
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  /// Translates the widget
  Widget translate({
    required Offset offset,
    bool transformHitTests = true,
    Key? key,
  }) {
    return Transform.translate(
      offset: offset,
      transformHitTests: transformHitTests,
      key: key,
      child: this,
    );
  }

  /// Centers the widget
  Widget center({double? heightFactor, double? widthFactor}) {
    return Center(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: this,
    );
  }

  /// Adds rounded corners
  Container withRoundedCorners({
    Color backgroundColor = Colors.white,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    LinearGradient? gradient,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    DecorationImage? decorationImage,
    BoxShape boxShape = BoxShape.rectangle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        gradient: gradient,
        border: border,
        boxShadow: boxShadow,
        image: decorationImage,
        shape: boxShape,
      ),
      child: this,
    );
  }

  /// Adds a shadow to the widget
  Container withShadow({
    Color bgColor = Colors.white,
    Color shadowColor = Colors.black12,
    double blurRadius = 10.0,
    double spreadRadius = 0.0,
    Offset offset = const Offset(0.0, 0.0),
    LinearGradient? gradient,
    BoxBorder? border,
    DecorationImage? decorationImage,
    BoxShape boxShape = BoxShape.rectangle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: border,
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
            offset: offset,
          ),
        ],
        image: decorationImage,
        shape: boxShape,
      ),
      child: this,
    );
  }

  /// Adds a tap handler to the widget
  Widget onTap(
    Function? function, {
    double? radius,
    Color? splashColor,
    Color? hoverColor,
    Color? highlightColor,
  }) {
    return InkWell(
      onTap: function as void Function()?,
      borderRadius: BorderRadius.circular(radius ?? 0.0),
      splashColor: splashColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      child: this,
    );
  }

  /// Launches a new screen
  Future<T?> launch<T>(BuildContext context,
      {bool isNewTask = false,
      PageRouteAnimation? pageRouteAnimation,
      Duration? duration}) async {
    if (isNewTask) {
      return await Navigator.of(context).pushAndRemoveUntil(
        buildPageRoute(
            this!, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
        (route) => false,
      );
    } else {
      return await Navigator.of(context).push(
        buildPageRoute(
            this!, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
      );
    }
  }

  /// Wraps the widget with a [ShaderMask]
  Widget withShaderMask(
    List<Color> colors, {
    BlendMode blendMode = BlendMode.srcATop,
  }) {
    return withShaderMaskGradient(
      LinearGradient(colors: colors),
      blendMode: blendMode,
    );
  }

  /// Wraps the widget with a [ShaderMask] with gradient
  Widget withShaderMaskGradient(
    Gradient gradient, {
    BlendMode blendMode = BlendMode.srcATop,
  }) {
    return ShaderMask(
      shaderCallback: (rect) => gradient.createShader(rect),
      blendMode: blendMode,
      child: this,
    );
  }

  /// Wraps the widget with a [SingleChildScrollView]
  Widget withScroll({
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    Axis scrollDirection = Axis.vertical,
    ScrollController? controller,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool? primary,
    required bool reverse,
  }) {
    return SingleChildScrollView(
      physics: physics,
      padding: padding,
      scrollDirection: scrollDirection,
      controller: controller,
      dragStartBehavior: dragStartBehavior,
      primary: primary,
      reverse: reverse,
      child: this,
    );
  }

  /// Adds an [Expanded] widget to the parent
  Widget expand({int flex = 1}) => Expanded(flex: flex, child: this!);

  /// Adds a [Flexible] widget to the parent
  Widget flexible({int flex = 1, FlexFit? fit}) {
    return Flexible(flex: flex, fit: fit ?? FlexFit.loose, child: this!);
  }

  /// Adds a [FittedBox] to the parent
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

  /// Validates the widget and returns a given value if null
  Widget validate({Widget value = const SizedBox()}) => this ?? value;

  /// Wraps the widget with a [Tooltip]
  Widget withTooltip({required String msg}) {
    return Tooltip(message: msg, child: this);
  }

  /// Makes the widget refreshable with [RefreshIndicator]
  Widget get makeRefreshable {
    return Stack(children: [ListView(), this!]);
  }

  /// Adds padding to the widget
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

  /// Adds margin to the widget
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

  /// Wraps the widget in a [Row]
  Widget row({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    List<Widget> children = const [],
  }) =>
      Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [this!, ...children],
      );

  /// Sets size of the widget
  Widget size({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  /// Centers the widget to the left
  Widget centerLeft() => Row(children: [const Spacer(), this!]);

  /// Centers the widget to the right
  Widget centerRight() => Row(children: [this!, const Spacer()]);

  /// Centers the widget at the top
  Widget centerTop() => Column(children: [const Spacer(), this!]);

  /// Centers the widget at the bottom
  Widget centerBottom() => Column(children: [this!, const Spacer()]);

  /// Aligns the widget
  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);

  /// Adds background color to the widget
  Widget background(Color color) => Container(color: color, child: this);

  /// Adds border radius to the widget
  Widget borderRadius(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  /// Adds elevation to the widget
  Widget elevation(double elevation) =>
      Material(elevation: elevation, child: this);

  /// Adds shadow to the widget
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

  /// Adds a long press handler to the widget
  Widget onLongPress(VoidCallback onLongPress) =>
      GestureDetector(onLongPress: onLongPress, child: this);

  /// Adds a double tap handler to the widget
  Widget onDoubleTap(VoidCallback onDoubleTap) =>
      GestureDetector(onDoubleTap: onDoubleTap, child: this);

  /// Adds horizontal drag handler to the widget
  Widget onHorizontalDrag(DragStartBehavior dragStartBehavior,
      GestureDragUpdateCallback onHorizontalDragUpdate) {
    return GestureDetector(
      dragStartBehavior: dragStartBehavior,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      child: this,
    );
  }

  /// Adds vertical drag handler to the widget
  Widget onVerticalDrag(DragStartBehavior dragStartBehavior,
      GestureDragUpdateCallback onVerticalDragUpdate) {
    return GestureDetector(
      dragStartBehavior: dragStartBehavior,
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: this,
    );
  }

  /// Adds pan handler to the widget
  Widget onPan(DragStartBehavior dragStartBehavior,
      GestureDragUpdateCallback onPanUpdate) {
    return GestureDetector(
      dragStartBehavior: dragStartBehavior,
      onPanUpdate: onPanUpdate,
      child: this,
    );
  }

  /// hero animation
  Widget hero({
    Key? key,
    required Object tag,
    Tween<Rect?> Function(Rect?, Rect?)? createRectTween,
    Widget Function(BuildContext, Animation<double>, HeroFlightDirection,
            BuildContext, BuildContext)?
        flightShuttleBuilder,
    Widget Function(BuildContext, Size, Widget)? placeholderBuilder,
    bool transitionOnUserGestures = false,
  }) =>
      Hero(
        key: key,
        tag: tag,
        createRectTween: createRectTween,
        flightShuttleBuilder: flightShuttleBuilder,
        placeholderBuilder: placeholderBuilder,
        transitionOnUserGestures: transitionOnUserGestures,
        child: this!,
      );
}
