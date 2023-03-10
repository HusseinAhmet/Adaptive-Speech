import 'package:adaptive_speech/OnBoarding/onBoard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'Screens/routes.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp();

      }

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Speech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplashScreen(
        backgroundColor: const Color.fromRGBO(36, 36, 62, 1),
        splashIconSize: 250,
        splashTransition: SplashTransition.scaleTransition,
        duration: 4000,
        splash: Image.asset('assets/splash.png'),
        nextScreen: OnBoardScreen(),
      ),
      routes: routes,
    );
  }
}
