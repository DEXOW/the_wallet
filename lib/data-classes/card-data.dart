import 'package:flutter/material.dart';
class CardData extends ChangeNotifier {
  late String cardId;
  late String cardName; //Name of the card (eg: Visa, APIIT Student)
  late String cardCatergory; //Catergory of the card (eg: PID / Payment / Coupon / Other)
}

class SocialCardData extends CardData{
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
  String imgUrl;

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
    required this.imgUrl,
  }) : super();
}