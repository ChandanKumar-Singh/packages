import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    super.key,
    required this.child,
    this.glow = true,
    this.elevation = 2.0,
    this.glowColor,
    this.upperBound = 0.1,
    this.radius = 10,
  }) : assert(upperBound >= 0.0 && upperBound <= 1.0,
            'upperBound must be between 0.0 and 1.0');

  final Widget child;
  final bool glow;
  final double elevation;
  final Color? glowColor;
  final double upperBound;
  final double radius;

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  late Color _glowColor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _glowColor =
          widget.glowColor ?? Theme.of(context).shadowColor.withOpacity(0.3);
      setState(() {});
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: widget.upperBound,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => _controller.reverse(),
      child: Transform.scale(
        scale: _scale,
        alignment: Alignment.center,
        child: _animatedButtonUI,
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: widget.glow && _controller.value > 0.0
              ? [
                  BoxShadow(
                    color: _glowColor,
                    blurRadius: 20.0,
                    spreadRadius: 2.0,
                  ),
                ]
              : null,
          // gradient: widget.glow && _controller.value > 0.0
          //     ? LinearGradient(
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //         colors: [
          //           _glowColor.withOpacity(0.8),
          //           _glowColor.withOpacity(0.6),
          //         ],
          //       )
          //     : null,
        ),
        child: widget.child,
      );
}
