import 'dart:io';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String fname;
  String lname;
  String email;
  String phoneNo;
  String pictureUrl;

  UserData({
    required this.fname,
    required this.lname,
    required this.email,
    required this.phoneNo,
    required this.pictureUrl,
  });

  void setData(String fname, String lname, String email, String phoneNo, String pictureUrl) {
    this.fname = fname;
    this.lname = lname;
    this.email = email;
    this.phoneNo = phoneNo;
    this.pictureUrl = pictureUrl;
    notifyListeners();
  }
}
