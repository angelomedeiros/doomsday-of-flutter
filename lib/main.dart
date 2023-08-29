import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'presentation/presentation.dart';

void main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.get('API_KEY'),
      appId: dotenv.get('APP_ID'),
      messagingSenderId: dotenv.get('MESSAGING_SENDER_ID'),
      projectId: dotenv.get('PROJECT_ID'),
      authDomain: dotenv.get('AUTH_DOMAIN'),
      storageBucket: dotenv.get('STORAGE_BUCKET'),
      measurementId: dotenv.get('MEASUREMENT_ID'),
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doomsday of Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        fontFamily: 'Epilogue',
      ),
      home: const HomeScreen(),
    );
  }
}
