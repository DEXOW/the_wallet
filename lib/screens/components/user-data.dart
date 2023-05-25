import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  int? activeCard;

  UserData({
    required this.activeCard,
  });

  void setData({
    int? activeCard,
  }) {
    this.activeCard = activeCard;
    notifyListeners();
  }
}

class UserDataProvider extends ChangeNotifier {
  final UserData _userData = UserData(
    activeCard: null,
  );

  UserData get userData => _userData;
}