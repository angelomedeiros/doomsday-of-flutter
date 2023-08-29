import 'package:flutter/material.dart';

const double _kBulletSize = 20 * 4 * 1.4;

class BulletinBackground extends StatelessWidget {
  final AlignmentGeometry alignment;

  const BulletinBackground({
    this.alignment = Alignment.center,
    super.key,
  });

  static List<Widget> buildBulletinRows() {
    List<Widget> rows = [];
    for (int i = 0; i < 30; i++) {
      bool isOddRow = i % 2 == 1;
      double left = isOddRow ? 0 : 100;
      double top = i * _kBulletSize + i * 100;

      rows.add(
        Positioned(
          left: left,
          top: top,
          child: const BulletinBackground(),
        ),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kBulletSize,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(
          30,
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
