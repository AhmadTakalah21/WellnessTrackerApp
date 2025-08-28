import 'dart:math' as math;

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  WavePainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final amp = size.height * .35;
    final yBase = size.height * .5;

    path.moveTo(0, yBase);
    for (double x = 0; x <= size.width; x++) {
      final t = (x / size.width * 2 * math.pi) + (progress * 2 * math.pi);
      final y = yBase + math.sin(t) * amp;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter old) =>
      old.progress != progress || old.color != color;
}
