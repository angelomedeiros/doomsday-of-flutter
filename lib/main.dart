import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'infra/infra.dart';
import 'presentation/presentation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('apiKey: ${Env.apiKey}');
  print('appId: ${Env.appId}');
  print('messagingSenderId: ${Env.messagingSenderId}');
  print('projectId: ${Env.projectId}');
  print('authDomain: ${Env.authDomain}');
  print('storageBucket: ${Env.storageBucket}');
  print('measurementId: ${Env.measurementId}');

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: Env.apiKey,
      appId: Env.appId,
      messagingSenderId: Env.messagingSenderId,
      projectId: Env.projectId,
      authDomain: Env.authDomain,
      storageBucket: Env.storageBucket,
      measurementId: Env.measurementId,
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
