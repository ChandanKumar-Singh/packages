import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';

class DynamicButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double radius;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final Color? focusColor;
  final double elevation;
  final EdgeInsets padding;
  final BorderSide? border;
  final Color? backgroundColor;
  final bool shrinkOnTap;
  final bool vibrateOnTap;
  final bool showHaptic;
  final bool showHover;
  final bool showFocus;
  final bool soundOnTap;
  final String? soundAsset;
  final bool enabled;

  const DynamicButton({
    super.key,
    required this.child,
    this.onTap,
    this.radius = 16.0,
    this.splashColor,
    this.highlightColor,
    this.hoverColor,
    this.focusColor,
    this.elevation = 0.0,
    this.padding = const EdgeInsets.all(0.0),
    this.border,
    this.backgroundColor,
    this.shrinkOnTap = true,
    this.vibrateOnTap = true,
    this.showHaptic = false,
    this.showHover = false,
    this.showFocus = false,
    this.soundOnTap = true,
    this.soundAsset,
    this.enabled = true,
  });

  @override
  _DynamicButtonState createState() => _DynamicButtonState();
}

class _DynamicButtonState extends State<DynamicButton> {
  double? _width;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _shrinkButton() async {
    setState(() {
      if (widget.shrinkOnTap) {
        _width = 0.8;
      }
    });
    if (widget.vibrateOnTap) {
      Vibration.vibrate(duration: 50);
    }

    if (widget.soundOnTap) {
      AudioPlayer player = AudioPlayer();
      player
          .setAsset('assets/sounds/button-press-sound.mp3')
          .then((_) => player.play());
    }
  }

  void _resetButton() {
    setState(() {
      _width = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !widget.enabled
          ? null
          : () {
              HapticFeedback.lightImpact();
              Vibration.vibrate(duration: 50);
              // _shrinkButton();
              AudioPlayer player = AudioPlayer();
              player
                  .setAsset('assets/sounds/button-press-sound.mp3')
                  .then((_) => player.play());
              widget.onTap?.call();
            },
      onTapDown: !widget.enabled
          ? null
          : (details) {
              _shrinkButton();
            },
      onTapUp: !widget.enabled ? null : (details) => _resetButton(),
      onTapCancel: !widget.enabled ? null : () => _resetButton(),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _width ?? 1.0,
        child: Material(
          elevation: widget.elevation,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(widget.radius),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(widget.radius),
            splashColor: widget.splashColor ?? Theme.of(context).splashColor,
            highlightColor: widget.highlightColor,
            hoverColor: widget.showHover ? widget.hoverColor : null,
            focusColor: widget.showFocus ? widget.focusColor : null,
            child: Padding(
              padding: widget.padding,
              child: Center(
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
