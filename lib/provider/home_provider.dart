import 'dart:io';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  bool isAndroid = Platform.isAndroid;
  int _menuIndex = 0;  // Track selected index

  int get menuIndex => _menuIndex;  // Getter for menuIndex

  void change() {
    isAndroid = !isAndroid;  // Toggle between Android and iOS
    notifyListeners();
  }

  void changeMenuIndex(int index) {
    _menuIndex = index;  // Update the selected index
    notifyListeners();
  }
}
