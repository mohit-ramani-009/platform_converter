import 'dart:io';

import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  bool isAndroid = Platform.isAndroid;

  void chnage(){
    isAndroid = !isAndroid;
    notifyListeners();
  }
}