import 'package:flutter/material.dart';

class SocialCardData extends ChangeNotifier {
  String fname;
  String lname;
  String career;
  String age;
  String email;
  String phoneNo;
  String linkedIn;
  String twitter;
  String instagram;
  String facebook;
  String pictureUrl;

  SocialCardData({
    required this.fname,
    required this.lname,
    required this.career,
    required this.age,
    required this.email,
    required this.phoneNo,
    required this.linkedIn,
    required this.twitter,
    required this.instagram,
    required this.facebook,
    required this.pictureUrl,
  });

  void setData (String fname, String lname, String career, String age, String email, String phoneNo, String linkedIn, String twitter, String instagram, String facebook, String pictureUrl) {
    this.fname = fname;
    this.lname = lname;
    this.career = career;
    this.age = age;
    this.email = email;
    this.phoneNo = phoneNo;
    this.linkedIn = linkedIn;
    this.twitter = twitter;
    this.instagram = instagram;
    this.facebook = facebook;
    this.pictureUrl = pictureUrl;
    notifyListeners();
  }
}

class SocialCardDataProvider extends ChangeNotifier {
  final SocialCardData _socialCardData = SocialCardData(
    fname: '',
    lname: '',
    career: '',
    age: '',
    email: '',
    phoneNo: '',
    linkedIn: '',
    twitter: '',
    instagram: '',
    facebook: '',
    pictureUrl: '',
  );

  SocialCardData get socialCardData => _socialCardData;
}