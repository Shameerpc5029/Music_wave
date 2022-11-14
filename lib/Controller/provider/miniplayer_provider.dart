import 'package:flutter/material.dart';
import 'package:music_wave/View/widgets/music_file.dart';

class MiniPlayerProvider with ChangeNotifier {
  void miniplayer() async {
    MusicFile.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        notifyListeners();
      }
    });
  }
}
