import 'package:devu/loginandsignup/login.dart';
import 'package:devu/loginandsignup/signup.dart';
import 'package:devu/splash.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:arena/splash.dart';
import 'package:flutter/material.dart';

import 'firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      routes: {
        'register': (context) => const MyRegister(),
        'login': (context) => const LoginScreen(),
      },
    );
  }
}
