import 'package:flutter/material.dart';
import 'package:the_wallet/screens/account/userData.dart';

class UserDataProvider extends ChangeNotifier {
  final UserData _userData = UserData(
    fname: '',
    lname: '',
    email: '',
    phoneNo: '',
    pictureUrl: '',
  );

  UserData get userData => _userData;
}