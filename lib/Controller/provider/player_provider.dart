import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:music_wave/View/widgets/music_file.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerProvider with ChangeNotifier {
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isFav = false;
  final List<SongModel> songModel = MusicFile.playingSong;
  int currentIndex = 0;
  void player() {
    MusicFile.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        notifyListeners();

        currentIndex = index;

        MusicFile.currentIndes = index;

        cheakFav();
      }
      notifyListeners();
    });
    MusicFile.audioPlayer.durationStream.listen((Duration? d) {
      try {
        if (d == null) {
          return;
        }
        duration = d;
        notifyListeners();
      } catch (e) {
        log(e.toString());
      }
    });

    MusicFile.audioPlayer.positionStream.listen((p) {
      position = p;
      notifyListeners();
    });
  }

  void cheakFav() async {
    isFav = await FavDb().isFav(
      songModel[currentIndex].id,
    );
    notifyListeners();
  }
}
