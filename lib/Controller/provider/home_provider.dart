import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  // int selectedIndex = 0;

  // void navBottonBar( int index) {
  //   selectedIndex = index;
  //   notifyListeners();
  // }
  int _currentIndex = 0;
  get currentIndex => _currentIndex;
  set currentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }
}
