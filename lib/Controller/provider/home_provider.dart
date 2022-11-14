import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int selectedIndex = 0;
  void navBottonBar( int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
