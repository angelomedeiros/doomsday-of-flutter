import 'package:flutter/material.dart';

import '../presentation.dart';

const double _kBulletSize = 20 * 4 * 1.4;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          body: SingleChildScrollView(
            child: CustomPaint(
              painter: Painel(),
              child: Container(),
            ),
          )

          // Stack(
          //   children: [
          //     const Positioned(left: 100, top: 0, child: BulletinRow()),
          //     const Positioned(
          //         left: 0, top: _kBulletSize + 100, child: BulletinRow()),
          //     const Positioned(
          //         left: 100, top: 2 * _kBulletSize + 200, child: BulletinRow()),
          //     const Positioned(
          //         left: 0, top: 3 * _kBulletSize + 300, child: BulletinRow()),
          //     const Positioned(
          //         left: 100, top: 4 * _kBulletSize + 400, child: BulletinRow()),
          //     Center(
          //       child: CustomPaint(
          //         painter: Painel(),
          //         child: Container(),
          //       ),
          //     ),
          //   ],
          // ),
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
