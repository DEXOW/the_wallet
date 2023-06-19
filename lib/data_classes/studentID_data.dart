import 'package:flutter/material.dart';

class StudentIDData extends ChangeNotifier {
  String orgName;
  String cardType;
  String batchCode;
  String studentName;
  String studentIDNumber;
  String expiryDate;
  String imageUrl;

  StudentIDData({
    required this.orgName,
    required this.cardType,
    required this.batchCode,
    required this.studentName,
    required this.studentIDNumber,
    required this.expiryDate,
    required this.imageUrl,
  });

  void setData(String orgName, String cardType,String batchCode,String studentName, String studentIDNumber,
      String expiryDate, String imageUrl) {
    this.orgName = orgName;
    this.cardType = cardType;
    this.batchCode = batchCode;
    this.studentName = studentName;
    this.studentIDNumber = studentIDNumber;
    this.expiryDate = expiryDate;
    this.imageUrl = imageUrl;
    notifyListeners();
  }
}

class StudentIDDataProvider extends ChangeNotifier {
  final StudentIDData _studentIDDataProvider = StudentIDData(
    orgName: '',
    cardType: 'Student ID',
    batchCode: '',
    studentName: '',
    studentIDNumber: '',
    expiryDate: '',
    imageUrl: '',
  );

  StudentIDData get userData => _studentIDDataProvider;

  get studentIDData => null;
}