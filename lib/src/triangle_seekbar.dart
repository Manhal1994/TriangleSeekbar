library triangle_seekbar;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TriangleSeekbar extends StatefulWidget {
  final double height;

  /// Called during a drag when the user is selecting a new value for the slider by dragging.
  final Function(double value) onChanged;

  /// The minimum value the user can select.
  /// Defaults to 0.0. Must be less than max
  final double min;

  ///  The maximum value the user can select.
  ///  Defaults to 1.0. Must be greater than max.
  final double max;

  /// The background color of seekbar if null the primary color will be used.
  final Color? backgroundColor;

  /// The color of the thumb.
  /// If this color is null the primary color will bes used.
  final Color? thumbColor;

  /// The currently selected value for this seekbar.
  /// The seekbar's thumb is drawn at a position that corresponds to this value
  final double value;

  const TriangleSeekbar(
      {Key? key,
      this.height = 150,
      required this.onChanged,
      this.min = 0,
      this.max = 100,
      this.backgroundColor,
      this.thumbColor,
      required this.value})
      : assert(value >= min && value <= max),
        assert(max > min),
        assert(max > 0 && min >= 0),
        assert(height >= 25),
        super(key: key);

  @override
  TriangleSeekbarState createState() {
    return TriangleSeekbarState();
  }
}

class TriangleSeekbarState extends State<TriangleSeekbar> {
  Offset _touchPoint = Offset.zero;

  late double thumbRadius;
  late double width;
  late double height;
  late double x;
  late double y;
  double? dy;
  late double yPerValue;

  @override
  void initState() {
    height = widget.height;
    width = height / 30;
    thumbRadius = width * 2;
    yPerValue = height / (widget.max - widget.min);
    dy = height - (yPerValue * widget.value) + widget.min * yPerValue;
    y = 0;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant TriangleSeekbar oldWidget) {
    if (oldWidget.value != widget.value) {
      dy = height - (yPerValue * widget.value) + widget.min * yPerValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        _touchPoint = box.globalToLocal(details.globalPosition);
        double currentValue =
            widget.max - ((widget.max * _touchPoint.dy) / height);
        setState(() {
          dy = _touchPoint.dy.clamp(0, height);
          widget.onChanged(currentValue.clamp(widget.min, widget.max));
        });
      },
      onVerticalDragStart: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        _touchPoint = box.globalToLocal(details.globalPosition);
        double currentValue =
            widget.max - ((widget.max * _touchPoint.dy) / height);
        setState(() {
          dy = _touchPoint.dy.clamp(0, height);
          widget.onChanged(currentValue.clamp(widget.min, widget.max));
        });
      },
      child: Container(
        width: thumbRadius * 4,
        height: height,
        color: Colors.transparent,
        child: Center(
          child: CustomPaint(
            size: Size(width, height),
            painter: _SeekBarPainter(
              dy: dy ?? 0,
              thumbRadius: thumbRadius,
              width: width,
              height: height,
              backgroundColor:
                  widget.backgroundColor ?? Theme.of(context).primaryColor,
              thumbColor: widget.thumbColor ??
                  widget.backgroundColor ??
                  Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _SeekBarPainter extends CustomPainter {
  late double y;
  late double x;
  double thumbRadius;
  double width;
  double height;
  double dy;
  Color backgroundColor;
  Color thumbColor;

  _SeekBarPainter({
    required this.height,
    required this.width,
    required this.thumbRadius,
    required this.dy,
    required this.backgroundColor,
    required this.thumbColor,
  });

  @override
  bool shouldRepaint(_SeekBarPainter old) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    x = size.width / 2;
    y = size.height / 2 - height / 2;
    final Paint paint = Paint()
      ..strokeWidth = 4
      ..color = backgroundColor;
    final Path path = Path();
    path.moveTo(x, y + height);
    path.lineTo(x + (width / 2), y + height);
    path.lineTo(x + (width / 2) + (height / 40), y);
    path.lineTo(x - (height / 40), y);
    canvas.drawPath(path, paint);
    paint.color = thumbColor;

    canvas.drawCircle(
        Offset(((x + (width / 2)) + x) / 2, dy), thumbRadius, paint);
  }
}
