import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialCard {
  String firstName;
  String lastName;
  String career;
  String age;
  String email;
  String phoneNumber;
  String linkedIn;
  String twitter;
  String instagram;
  String facebook;
  File? picture;

  SocialCard({
    required this.firstName,
    required this.lastName,
    required this.career,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.linkedIn,
    required this.twitter,
    required this.instagram,
    required this.facebook,
    this.picture,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'career': career,
      'age': age,
      'email': email,
      'phoneNumber': phoneNumber,
      'linkedIn': linkedIn,
      'twitter': twitter,
      'instagram': instagram,
      'facebook': facebook,
      'picture': picture?.path,
    };
  }

  factory SocialCard.fromJson(Map<String, dynamic> json) {
    return SocialCard(
      firstName: json['firstName'] == null ? '' : json['firstName'] as String,
      lastName: json['lastName'] == null ? '' : json['lastName'] as String,
      picture: json['picture'] == null ? null : File(json['picture'] as String),
      career: json['career'] == null ? '' : json['career'] as String,
      age: json['age'] == null ? '' : json['age'] as String,
      email: json['email'] == null ? '' : json['email'] as String,
      phoneNumber:
          json['phoneNumber'] == null ? '' : json['phoneNumber'] as String,
      linkedIn: json['linkedIn'] == null ? '' : json['linkedIn'] as String,
      twitter: json['twitter'] == null ? '' : json['twitter'] as String,
      instagram: json['instagram'] == null ? '' : json['instagram'] as String,
      facebook: json['facebook'] == null ? '' : json['facebook'] as String,
    );
  }
}

class SocialCardProvider extends ChangeNotifier {
  late SocialCard _socialCard = SocialCard(
      firstName: '',
      lastName: '',
      career: '',
      age: '',
      email: '',
      phoneNumber: '',
      linkedIn: '',
      twitter: '',
      instagram: '',
      facebook: '');

  SocialCard get socialCard => _socialCard;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final socialCardJson = prefs.getString('socialCard');
    if (socialCardJson != null) {
      final jsonMap = json.decode(socialCardJson) as Map<String, dynamic>;
      _socialCard = SocialCard.fromJson(jsonMap);
    } else {
      _socialCard = SocialCard(
        firstName: '',
        lastName: '',
        career: '',
        age: '',
        email: '',
        phoneNumber: '',
        linkedIn: '',
        twitter: '',
        instagram: '',
        facebook: '',
      );
    }
  }

  Future<void> setSocialCard(SocialCard socialCard) async {
    _socialCard = socialCard;
    final prefs = await SharedPreferences.getInstance();
    final socialCardJson = json.encode(socialCard.toJson());
    await prefs.setString('socialCard', socialCardJson);
    notifyListeners();
  }

  Future<void> clearSocialCard() async {
    _socialCard = SocialCard(
      firstName: '',
      lastName: '',
      career: '',
      age: '',
      email: '',
      phoneNumber: '',
      linkedIn: '',
      twitter: '',
      instagram: '',
      facebook: '',
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('socialCard');
    notifyListeners();
  }
}