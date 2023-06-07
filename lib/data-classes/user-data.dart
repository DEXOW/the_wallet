import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String? fname;
  String? lname;
  String? email;
  String? dobDate;
  String? dobMonth;
  String? dobYear;
  String? phoneNo;
  String? pictureUrl;
  String? socialCardId;

  UserData({
    required this.fname,
    required this.lname,
    required this.email,
    required this.dobDate,
    required this.dobMonth,
    required this.dobYear,
    required this.phoneNo,
    required this.pictureUrl,
    required this.socialCardId,
  });

  void setData({
    String? fname, 
    String? lname, 
    String? email, 
    String? dobDate, 
    String? dobMonth, 
    String? dobYear, 
    String? phoneNo, 
    String? pictureUrl,
    String? socialCardId,
  }) {
    this.fname = fname;
    this.lname = lname;
    this.email = email;
    this.dobDate = dobDate;
    this.dobMonth = dobMonth;
    this.dobYear = dobYear;
    this.phoneNo = phoneNo;
    this.pictureUrl = pictureUrl;
    this.socialCardId = socialCardId;
    notifyListeners();
  }
}

class UserDataProvider extends ChangeNotifier {
  final UserData _userData = UserData(
    fname: '',
    lname: '',
    email: '',
    dobDate: '',
    dobMonth: '',
    dobYear: '',
    phoneNo: '',
    pictureUrl: '',
    socialCardId: '',
  );

  UserData get userData => _userData;
}