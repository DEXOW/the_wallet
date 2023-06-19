import 'package:flutter/material.dart';

class MembershipIDData extends ChangeNotifier {
  String orgName;
  String cardType;
  String phoneNumber;
  String firstName;
  String lastName;
  String membershipIDNumber;
  String expiryDate;
  String imageUrl;

  MembershipIDData({
    required this.orgName,
    required this.cardType,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.membershipIDNumber,
    required this.expiryDate,
    required this.imageUrl,
  });

  void setData(String orgName, String cardType,String phoneNumber, String firstName,
      String lastName, String membershipIDNumber, String expiryDate,String imageUrl) {
    this.orgName = orgName;
    this.cardType = cardType;
    this.phoneNumber = phoneNumber;
    this.firstName = firstName;
    this.lastName = lastName;
    this.membershipIDNumber = membershipIDNumber;
    this.expiryDate = expiryDate;
    this.imageUrl = imageUrl;
    notifyListeners();
  }
}

class MembershipIDDataProvider extends ChangeNotifier {
  final MembershipIDData _membershipIDDataProvider = MembershipIDData(
    orgName: '',
    cardType: 'Membership ID',
    phoneNumber: '',
    firstName: '',
    lastName: '',
    membershipIDNumber: '',
    expiryDate: '',
    imageUrl: '',
  );

  MembershipIDData get userData => _membershipIDDataProvider;

  get membershipIDData => null;
}
