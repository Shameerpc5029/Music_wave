import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_wave/View/bottom_nav.dart';

class SplashProvider with ChangeNotifier {
  void gotMainScreen(context) {
    Timer(
      const Duration(seconds: 3),
      (() => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: ((context) => HomeScreen()),
            ),
          )),
    );
  }
}
