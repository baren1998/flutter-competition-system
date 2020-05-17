import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabBarProvider with ChangeNotifier {
  int _selected = 0;

  int get selected => _selected;

  changeSelected(int index) {
    _selected = index;
    notifyListeners();
  }
}