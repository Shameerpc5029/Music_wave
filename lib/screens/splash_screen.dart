import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/screens/home_screen.dart';
import 'package:music_wave/widgets/white_space.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotMainScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                ),
              ),
            ),
            const WhiteSpace(),
            const Text(
              "Music Wave",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.black,
              size: 40,
            )
          ],
        ),
      ),),
    );
  }

  gotMainScreen() {
    Timer(
      const Duration(seconds: 3),
      (() => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: ((context) => const HomeScreen()),
            ),
          )),
    );
  }
}
