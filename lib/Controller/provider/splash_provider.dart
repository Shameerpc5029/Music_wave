import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_wave/View/Music%20Screen/all_song_screen.dart';
import 'package:music_wave/View/Search%20Screen/search_screen.dart';
import 'package:music_wave/View/home_screen.dart';

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
