import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:music_wave/View/widgets/music_file.dart';

class PlayerProvider with ChangeNotifier {
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isFav = false;
  int currentIndex = 0;
  void player() {
    MusicFile.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        // setState(() {
        currentIndex = index;
        // });

        MusicFile.currentIndes = index;
        // setState(() {
        // cheakFav();
        // });
      }
    });
    MusicFile.audioPlayer.durationStream.listen(
      (d) {
        duration = d!;
      },
    );
    MusicFile.audioPlayer.positionStream.listen(
      (p) {
        position = p;
      },
    );
    // cheakFav(songModel);
    notifyListeners();
  }

  // void cheakFav(songModel) async {
  //   isFav = await FavDb().isFav(
  //     songModel[currentIndex].id,
  //   );
  //   notifyListeners();
  // }
}
