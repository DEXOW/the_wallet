import 'package:flutter/material.dart';

class DrivingIDData extends ChangeNotifier {
  String surname;
  String cardType;
  String otherNames;
  String dateOfBirth;
  String dateOfIssue;
  String dateOfExpiry;
  String drivingID;
  String address;
  String serialNumber;
  String imageUrl;

  DrivingIDData({
    required this.surname,
    required this.cardType,
    required this.otherNames,
    required this.dateOfBirth,
    required this.dateOfIssue,
    required this.dateOfExpiry,
    required this.drivingID,
    required this.address,
    required this.serialNumber,
    required this.imageUrl,
  });

  void setData(String surname, String cardType, String otherNames, String dateOfBirth,
      String dateOfIssue, String dateOfExpiry, String drivingID, String address,
      String serialNumber,String imageUrl) {
    this.surname = surname;
    this.cardType = cardType;
    this.otherNames = otherNames;
    this.dateOfBirth = dateOfBirth;
    this.dateOfIssue = dateOfIssue;
    this.dateOfExpiry = dateOfExpiry;
    this.drivingID = drivingID;
    this.address = address;
    this.serialNumber = serialNumber;
    this.imageUrl = imageUrl;
    notifyListeners();
  }
}

class DrivingIDDataProvider extends ChangeNotifier{
  final DrivingIDData _drivingIDDataProvider = DrivingIDData(
    surname: '',
    otherNames: '',
    cardType: 'Driving ID',
    dateOfBirth: '',
    dateOfIssue: '',
    dateOfExpiry: '',
    drivingID: '',
    address: '',
    serialNumber: '',
    imageUrl: '',
  );

  DrivingIDData get userData => _drivingIDDataProvider;

  get drivingIDData => null;
}

