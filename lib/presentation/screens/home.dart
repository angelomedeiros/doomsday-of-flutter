import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AudioPlayer? player;
  AnimationController? controller;
  Animation<double>? animation;
  int remainingDays = 549;
  int remainingDaysFinal = 0;

  bool mostrarOverlay = true;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    _initPlayer();
    _initAnimation();
    _initCalculateRemainingDays();
  }

  void _initCalculateRemainingDays() {
    final dateNow = DateTime.now();
    final dateFinal = DateTime(2025, 1, 1);
    remainingDaysFinal = dateFinal.difference(dateNow).inDays;
  }

  void startClock() {
    int remainingDaysInitial = 549;

    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (remainingDaysInitial != remainingDaysFinal) {
          setState(() {
            remainingDays = --remainingDaysInitial;
          });
        }
      },
    );
  }

  void _initPlayer() async {
    try {
      await player?.setAsset(
        'assets/audios/background.mp3',
        initialPosition: const Duration(milliseconds: 23600),
      );
      await player?.setLoopMode(LoopMode.all);
    } catch (e) {
      throw Exception('Erro ao carregar o áudio');
    }
  }

  void _initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller!);
  }

  @override
  void dispose() {
    super.dispose();
    player?.dispose();
    controller?.dispose();
  }

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

  void togglePlay() {
    player?.playing == true ? player?.pause() : player?.play();
    if (player?.playing == true) {
      controller?.forward();
    } else {
      controller?.reverse();
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
                  painter: Painel(
                    textTheme: textTheme,
                    remainingDays: remainingDays,
                    remainingDaysFinal: remainingDaysFinal,
                  ),
                  child: Container(),
                ),
              ),
            ),
            if (!mostrarOverlay)
              Positioned(
                left: 10,
                top: 10,
                child: ElevatedButton(
                  onPressed: togglePlay,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: animation!,
                  ),
                ),
              ),
            if (mostrarOverlay)
              Positioned.fill(
                child: Container(
                  color: Colors.black87,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        mostrarOverlay = false;
                      });
                      togglePlay();
                      startClock();
                    },
                    color: const Color.fromRGBO(142, 6, 6, 1),
                    hoverColor: Colors.transparent,
                    icon: const Icon(
                      Icons.play_circle,
                      size: 150,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
