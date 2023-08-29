import 'dart:math';

import 'package:flutter/material.dart';

class Painel extends CustomPainter {
  final TextTheme textTheme;

  Painel({
    required this.textTheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dateNow = DateTime.now();
    final dateFinal = DateTime(2025, 1, 1);
    final difference = dateFinal.difference(dateNow).inDays;

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final width = size.width;
    final widthMoreGap = width - width / 8;

    final r = widthMoreGap / 14;
    final s1 = widthMoreGap / 19;
    final s2 = widthMoreGap / 7;
    final s4 = widthMoreGap - r;
    final s5 = s4 - s2 - s1 - r;
    final s6 = s1 + r;

    double degToRad(double deg) => deg * pi / 180;

    canvas.translate(s4, s4);
    canvas.scale(1, -1);

    canvas.save();

    final paintBackground = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;

    final background = Path()
      ..moveTo(r + width / 8, s4)
      ..lineTo(r, s4)
      ..arcToPoint(
        Offset(-s4, -r),
        radius: Radius.circular(-s4),
        clockwise: true,
      )
      ..lineTo(-s4, -width * 1.43 + s4)
      ..lineTo(r + width / 8, -width * 1.43 + s4)
      ..close();

    canvas.drawPath(background, paintBackground);

    for (var i = 0; i < 4; i++) {
      canvas.drawCircle(Offset(-s5, 0), r, paint);
      canvas.rotate(degToRad(-30));
    }

    canvas.restore();

    canvas.save();

    canvas.scale(1, -1);

    final textSpan = TextSpan(
      text: 'IT IS $difference DAYS TO MIDNIGHT',
      style: textTheme.displayLarge?.copyWith(
        fontSize: width / 14.2857142857,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.rtl,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: width / 2.1,
    );

    final position = Offset(-width / 2.3, width / 7);

    textPainter.paint(canvas, position);

    canvas.restore();

    canvas.save();

    final underlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 33.3;

    canvas.drawLine(
      Offset(r * 2, -width / 2.85),
      Offset(-width * 0.76, -width / 2.85),
      underlinePaint,
    );

    canvas.restore();

    canvas.save();

    canvas.scale(1, -1);

    final subtitle = TextSpan(
      text:
          'The last active day for Flutter will be December 31, 2024, according to \'native\' developers',
      style: textTheme.displayLarge?.copyWith(
        fontSize: width / 22.2,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );

    final subtitlePainter = TextPainter(
      text: subtitle,
      textDirection: TextDirection.rtl,
    );

    subtitlePainter.layout(
      minWidth: 0,
      maxWidth: width / 1.2,
    );

    final positionSubtitle = Offset(-width / 1.4, width / 2.4);

    subtitlePainter.paint(canvas, positionSubtitle);

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
      ..strokeWidth = widthMoreGap / 38;

    final hourHand = Path()
      ..moveTo(0, -r)
      ..lineTo(0, s4 * 0.4);

    canvas.drawPath(hourHand, handPaint);

    final minuteHand = Path()
      ..moveTo(0, -r)
      ..lineTo(0, s4 * 0.6);

    const oneDayInDregrees = 180 / 1096;

    double angleMinuteHand = difference * oneDayInDregrees;

    canvas.rotate(degToRad(angleMinuteHand));
    canvas.drawPath(minuteHand, handPaint);
  }

  @override
  bool shouldRepaint(covariant Painel oldDelegate) => false;
}
