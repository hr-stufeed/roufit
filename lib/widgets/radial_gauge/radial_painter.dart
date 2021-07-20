import 'dart:math' as math;

import 'package:flutter/material.dart';

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
      this.backgroundGradient})
      : super(repaint: animation);

  final Animation<double> animation;
  final Color fillColor, ringColor, backgroundColor;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final Gradient fillGradient, ringGradient, backgroundGradient;

  double split;

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

    if (ringGradient != null) {
      final rect = Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2);
      paint..shader = ringGradient.createShader(rect);
    } else {
      paint..shader = null;
    }

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

    canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);

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
