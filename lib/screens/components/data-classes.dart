import 'package:flutter/material.dart';

class PageDataProvider extends ChangeNotifier {
  String currentScreen = 'home';

  void setCurrentScreen(screen){
    currentScreen = screen;
    notifyListeners();
  }

  String getCurrentScreen(){
    return currentScreen;
  }
}

