import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String? fname;
  String? lname;
  String? email;
  DateTime? dob;
  String? phoneNo;
  String? phoneNoCode;
  String? pictureUrl;
  String? socialCardId;

  UserData({
    required this.fname,
    required this.lname,
    required this.email,
    required this.dob,
    required this.phoneNo,
    required this.phoneNoCode,
    required this.pictureUrl,
    required this.socialCardId,
  });

  void setData({
    String? fname, 
    String? lname, 
    String? email, 
    DateTime? dob,
    String? phoneNo,
    String? phoneNoCode, 
    String? pictureUrl,
    String? socialCardId,
  }) {
    this.fname = fname;
    this.lname = lname;
    this.email = email;
    this.dob = dob;
    this.phoneNo = phoneNo;
    this.phoneNoCode = phoneNoCode;
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
    dob: DateTime.now(),
    phoneNo: '',
    phoneNoCode: '',
    pictureUrl: '',
    socialCardId: '',
  );

  UserData get userData => _userData;
}