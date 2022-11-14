import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicScreenProvider with ChangeNotifier {
  final audioQuery = OnAudioQuery();

  void requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }
    }
    notifyListeners();
  }



}
