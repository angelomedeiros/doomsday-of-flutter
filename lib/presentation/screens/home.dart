import 'package:flutter/material.dart';

import '../presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                width: width > 1024 ? 500 : 300,
                height: width > 1024 ? 500 : 300,
                child: CustomPaint(
                  painter: Painel(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
