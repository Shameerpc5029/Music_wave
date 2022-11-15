import 'package:flutter/material.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';

class LibrayProvider with ChangeNotifier {
  int counter = 0;
  void totalcount() async {
    int? count = await FavDb().countFav();
    counter = count!;
    notifyListeners();
  }
}
