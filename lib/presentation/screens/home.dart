import 'package:flutter/material.dart';

const double _kBulletSize = 20 * 4 * 1.4;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color.fromRGBO(240, 20, 15, 1),
            Color.fromRGBO(142, 6, 6, 1),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            const Positioned(left: 100, top: 0, child: BulletinRow()),
            const Positioned(
                left: 0, top: _kBulletSize + 100, child: BulletinRow()),
            const Positioned(
                left: 100, top: 2 * _kBulletSize + 200, child: BulletinRow()),
            const Positioned(
                left: 0, top: 3 * _kBulletSize + 300, child: BulletinRow()),
            const Positioned(
                left: 100, top: 4 * _kBulletSize + 400, child: BulletinRow()),
            Center(
              child: CustomPaint(
                painter: Painel(),
                child: const Placeholder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletinRow extends StatelessWidget {
  final AlignmentGeometry alignment;

  const BulletinRow({
    this.alignment = Alignment.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kBulletSize,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(
          20,
          (index) => const Padding(
            padding: EdgeInsets.only(right: 150),
            child: Text(
              'Bulletin \nof the \nPseudo \nDevelopers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Painel extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final clockQuarter = Path()
      ..moveTo(532, 0)
      ..relativeArcToPoint(
        const Offset(-532, 532),
        radius: const Radius.circular(532),
        clockwise: false,
      )
      ..lineTo(84, 532)
      ..relativeArcToPoint(
        const Offset(532 - 84, -1 * (532 - 84)),
        radius: const Radius.circular(532 - 84),
        clockwise: true,
      )
      ..close();

    final circle45 = Path()
      ..moveTo(84 + 24 + 45, 532 - 45)
      ..addOval(Rect.fromCircle(
        center: const Offset(84 + 24 + 45, 532 - 45),
        radius: 45,
      ));

    final circle50 = Path()
      ..moveTo(210, 332)
      ..addOval(Rect.fromCircle(
        center: const Offset(210, 332),
        radius: 45,
      ));

    final circle55 = Path()
      ..moveTo(317, 220)
      ..addOval(Rect.fromCircle(
        center: const Offset(317, 220),
        radius: 45,
      ));

    final circle60 = Path()
      ..moveTo(532 - 45, 84 + 24 + 45)
      ..addOval(Rect.fromCircle(
        center: const Offset(532 - 45, 84 + 24 + 45),
        radius: 45,
      ));

    canvas.drawPath(clockQuarter, paint);
    canvas.drawPath(circle45, paint);
    canvas.drawPath(circle50, paint);
    canvas.drawPath(circle55, paint);
    canvas.drawPath(circle60, paint);

    final hourPointer = Path()
      ..moveTo(488, 533)
      ..lineTo(488, 265);

    final paintStroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawPath(hourPointer, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
