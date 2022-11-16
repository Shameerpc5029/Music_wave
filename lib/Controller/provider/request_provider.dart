
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestProvider with ChangeNotifier {
  final audioQuery = OnAudioQuery();

  void requestPermission() async {
    await Permission.storage.request();
    FocusManager.instance.primaryFocus?.unfocus();

    notifyListeners();
  }
}
