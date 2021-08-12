import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

// class RadialPainter extends StatefulWidget {
//   final Animation<double> animation;
//   final Color fillColor, ringColor, backgroundColor;
//   final double strokeWidth;
//   final StrokeCap strokeCap;
//   final Gradient fillGradient, ringGradient, backgroundGradient;
//
//   double split;
//   double fillSplit;
//
//   RadialPainter(
//       {this.animation,
//       this.split = 1,
//       this.fillColor,
//       this.fillGradient,
//       this.ringColor,
//       this.ringGradient,
//       this.strokeWidth,
//       this.strokeCap,
//       this.backgroundColor,
//       this.backgroundGradient,
//       this.fillSplit = 0});
//
//   @override
//   _RadialPainterState createState() => _RadialPainterState();
// }
//
// class _RadialPainterState extends State<RadialPainter> with TickerProviderStateMixin {
//
//   AnimationController _controller;
//   Animation<double> _countDownAnimation;
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );
//     _countDownAnimation =
//         Tween<double>(begin: 1, end: 0).animate(_controller);
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: Painter(
//           split: widget.split,
//           fillSplit: widget.fillSplit,
//           animation: _countDownAnimation,
//           fillColor: widget.fillColor,
//           fillGradient: widget.fillGradient,
//           ringColor: widget.ringColor,
//           ringGradient: widget.ringGradient,
//           strokeWidth: widget.strokeWidth,
//           strokeCap: widget.strokeCap,
//           backgroundColor: widget.backgroundColor,
//           backgroundGradient: widget.backgroundGradient),
//     );
//   }
// }

class RadialPainter extends CustomPainter {
  RadialPainter(
      {this.animation,
      this.split = 1,
      this.fillColor,
      this.fillGradient,
      this.ringColor,
      this.ringGradient,
      this.strokeWidth,
      this.strokeCap,
      this.backgroundColor,
      this.backgroundGradient,
      this.fillSplit = 0})
      : super(repaint: animation);

  final Animation<double> animation;
  final Color fillColor, ringColor, backgroundColor;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final Gradient fillGradient, ringGradient, backgroundGradient;

  double split;
  double fillSplit;

  double get _emptyArcSize =>
      2 * math.pi / ((100 / (split == 1 ? 0 : split)) * split);

  double get _fullArcSize => 2 * math.pi / split - _emptyArcSize;

  double _startAngle(int unit) =>
      -math.pi / 2 + unit * (_emptyArcSize + _fullArcSize) + _emptyArcSize / 2;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ringColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    Paint fillPaint = Paint()
      ..color = ringColor
      ..strokeWidth = strokeWidth
      ..shader = fillGradient.createShader(Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2))
      ..style = PaintingStyle.stroke;

    if (ringGradient != null) {
      final rect = Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2);
      paint..shader = ringGradient.createShader(rect);
    } else {
      paint..shader = null;
    }

    //Split paint
    for (var i = 0; i < split; i++) {
      canvas.drawArc(
          Offset.zero & size, _startAngle(i), _fullArcSize, false, paint);
    }
    double progress = (animation.value) * 2 * math.pi;

    if (fillGradient != null) {
      final rect = Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2);
      paint..shader = fillGradient.createShader(rect);
    } else {
      paint..shader = null;
      paint.color = fillColor;
    }

    //Split Fill
    if (fillSplit != -1) {
      for (var i = 0; i < fillSplit; i++) {
        if (i >= fillSplit - 1) {
          canvas.drawArc(
              Offset.zero & size,
              _startAngle(i),
              animation.value * (((math.pi * 2) / split) - _emptyArcSize),
              false,
              fillPaint);
        } else {
          canvas.drawArc(Offset.zero & size, _startAngle(i),
              1 * (((math.pi * 2) / split) - _emptyArcSize), false, fillPaint);
        }
      }
    } else {
      canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);
    }

    if (backgroundColor != null || backgroundGradient != null) {
      final backgroundPaint = Paint();

      if (backgroundGradient != null) {
        final rect = Rect.fromCircle(
            center: size.center(Offset.zero), radius: size.width / 2.2);
        backgroundPaint..shader = backgroundGradient.createShader(rect);
      } else {
        backgroundPaint.color = backgroundColor;
      }
      canvas.drawCircle(
          size.center(Offset.zero), size.width / 2.2, backgroundPaint);
    }
  }

  @override
  bool shouldRepaint(RadialPainter old) {
    return animation.value != old.animation.value ||
        ringColor != old.ringColor ||
        fillColor != old.fillColor;
  }
}
