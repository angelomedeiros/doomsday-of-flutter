import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentation/presentation.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doomdsday of Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        textTheme: GoogleFonts.epilogueTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}
