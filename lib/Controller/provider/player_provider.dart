import 'package:flutter/material.dart';

class PlayerProvider with ChangeNotifier {
  void changeToSecond(audioPlayer, int seconds) {
    Duration duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }
}
