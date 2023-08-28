import 'dart:math';

import 'package:flutter/material.dart';

class Painel extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final width = size.width;
    final r = width / 14;
    final s1 = width / 19;
    final s2 = width / 7;
    final s4 = width - r;
    final s5 = s4 - s2 - s1 - r;
    final s6 = s1 + r;

    // funcao que convert degrees to radians
    double degToRad(double deg) => deg * pi / 180;

    canvas.translate(s4, s4);
    canvas.scale(1, -1);

    canvas.save();

    for (var i = 0; i < 4; i++) {
      canvas.drawCircle(Offset(-s5, 0), r, paint);
      canvas.rotate(degToRad(-30));
    }

    canvas.restore();

    final clock = Path()
      ..moveTo(-s5 - s6, -r)
      ..arcToPoint(
        Offset(r, s4 - s2),
        radius: Radius.circular(s4 - s2),
        clockwise: false,
      )
      ..lineTo(r, s4)
      ..arcToPoint(
        Offset(-s4, -r),
        radius: Radius.circular(s4),
        clockwise: true,
      )
      ..close();

    canvas.drawPath(clock, paint);

    final handPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 38;

    final hourHand = Path()
      ..moveTo(0, -r)
      ..lineTo(0, s4 * 0.4);

    canvas.drawPath(hourHand, handPaint);

    final minuteHand = Path()
      ..moveTo(0, -r)
      ..lineTo(0, s4 * 0.6);

    final dateNow = DateTime.now();
    final dateFinal = DateTime(2025, 1, 1);
    final difference = dateFinal.difference(dateNow).inDays;
    const oneDayInDregrees = 180 / 1096;

    double angleMinuteHand = difference * oneDayInDregrees;

    canvas.rotate(degToRad(angleMinuteHand));
    canvas.drawPath(minuteHand, handPaint);
  }

  @override
  bool shouldRepaint(covariant Painel oldDelegate) => false;
}
