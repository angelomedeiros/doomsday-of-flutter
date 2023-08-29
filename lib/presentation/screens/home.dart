import 'package:flutter/material.dart';

import '../presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double calculateWidth(double screenWidth) {
    if (screenWidth > 1024) {
      return 500;
    } else if (screenWidth > 425) {
      return 400;
    } else if (screenWidth > 320) {
      return 350;
    } else {
      return 200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

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
          fit: StackFit.expand,
          children: [
            ...BulletinBackground.buildBulletinRows(),
            Center(
              child: SizedBox(
                width: calculateWidth(screenWidth),
                height: calculateWidth(screenWidth) * 1.43,
                child: CustomPaint(
                  painter: Painel(textTheme: textTheme),
                  child: Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
