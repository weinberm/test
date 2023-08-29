import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  int selectedIndex = 2;
  int counter = 0;

  void changeTabIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
