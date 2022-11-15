import 'package:flutter/material.dart';
import 'package:music_wave/View/Search%20Screen/search_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider with ChangeNotifier {
  void allSongLoad() async {
    allSong = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    // setState(() {
    song = allSong;
    // });
    notifyListeners();
  }

  void search(String keybord) {
    List<SongModel> results = [];
    if (keybord.isEmpty) {
      results = allSong;
    } else {
      results = allSong
          .where(
            (element) => element.displayNameWOExt.toLowerCase().contains(
                  keybord.toLowerCase(),
                ),
          )
          .toList();
    }
    // setState(() {
    song = results;
    // });
    notifyListeners();
  }
}
