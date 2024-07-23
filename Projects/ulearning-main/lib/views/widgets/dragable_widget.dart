// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class DraggableFloatingWidget extends StatefulWidget {
  const DraggableFloatingWidget({
    super.key,
    required this.child,
    required this.floatingWidget,
  });

  final Widget child;
  final Widget floatingWidget;

  @override
  _DraggableFloatingWidgetState createState() =>
      _DraggableFloatingWidgetState();
}

class _DraggableFloatingWidgetState extends State<DraggableFloatingWidget> {
  ValueNotifier<Offset> position = ValueNotifier(const Offset(0.0, 100.0));
  final GlobalKey _key = GlobalKey();
  Size? _size;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null && renderBox.attached && renderBox.hasSize) {
        setState(() => _size = renderBox.size);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(key: _key, child: widget.child),
        ValueListenableBuilder<Offset>(
          valueListenable: position,
          builder: (context, value, child) {
            return Positioned(
              left: value.dx,
              top: value.dy,
              child: Draggable(
                feedback: widget.floatingWidget,
                childWhenDragging: Container(),
                onDragUpdate: (details) {
                  final screenSize = MediaQuery.of(context).size;
                  final widgetWidth = _size?.width ?? screenSize.width;
                  final widgetHeight = _size?.height ?? screenSize.height;

                  final newX = details.globalPosition.dx;
                  final newY = details.globalPosition.dy;

                  if (newX >= 0 &&
                      newY >= 0 &&
                      newX <= widgetWidth - 40 &&
                      newY <= widgetHeight - 40) {
                    position.value = Offset(newX, newY);
                  }
                },
                child: widget.floatingWidget,
              ),
            );
          },
        ),
      ],
    );
  }
}
