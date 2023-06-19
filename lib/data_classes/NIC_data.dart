import 'package:flutter/material.dart';

class NICData extends ChangeNotifier {
  String fullName;
  String cardType;
  String nicNumber;
  String dateOfBirth;
  String sex;
  String address;
  String dateOfIssue;
  String serialNumber;
  String imageUrl;

  NICData({
    this.fullName = '',
    this.cardType = '',
    this.nicNumber = '',
    this.dateOfBirth = '',
    this.sex = '',
    this.address = '',
    this.dateOfIssue = '',
    this.serialNumber = '',
    this.imageUrl = '',
  });

  void setData(
      String fullName,
      String cardType,
      String nicNumber,
      String dateOfBirth,
      String sex,
      String address,
      String dateOfIssue,
      String serialNumber,
      String imageUrl) {
    this.fullName = fullName;
    this.nicNumber = nicNumber;
    this.dateOfBirth = dateOfBirth;
    this.sex = sex;
    this.address = address;
    this.dateOfIssue = dateOfIssue;
    this.serialNumber = serialNumber;
    this.imageUrl = imageUrl;
    notifyListeners();
  }
}

class NICDataProvider extends ChangeNotifier {
  final NICData _nicDataProvider = NICData(
    fullName: '',
    cardType: 'National ID',
    nicNumber: '',
    dateOfBirth: '',
    sex: '',
    address: '',
    dateOfIssue: '',
    serialNumber: '',
    imageUrl: '',
  );
  NICData get userData => _nicDataProvider;

  get nicData => null;
}
