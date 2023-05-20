import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// class UserData {
//   static Future<List<String?>> getUserData({
//     required String uid,
//   }) async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     final userData = await firestore.collection('users').doc(uid).get();
//     return [userData['fname'], userData['lname'], userData['email'], userData['dobDate'], userData['dobMonth'], userData['dobYear'], userData['phoneNoCode'], userData['phoneNo']];
//   }
// }

// class UserData {
//   static Future<Map<String?, dynamic>> getUserData({
//     required String uid,
//   }) async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     final userData = await firestore.collection('users').doc(uid).get();
//     return userData.data()!;
//   }
// }

class UserData extends ChangeNotifier {
  String? fname;
  String? lname;
  String? email;
  String? dobDate;
  String? dobMonth;
  String? dobYear;
  String? phoneNo;
  String? imgUrl;

  UserData({
    required this.fname,
    required this.lname,
    required this.email,
    required this.dobDate,
    required this.dobMonth,
    required this.dobYear,
    required this.phoneNo,
    required this.imgUrl,
  });

  void setData({
    String? fname, 
    String? lname, 
    String? email, 
    String? dobDate, 
    String? dobMonth, 
    String? dobYear, 
    String? phoneNo, 
    String? imgUrl
  }) {
    this.fname = fname;
    this.lname = lname;
    this.email = email;
    this.dobDate = dobDate;
    this.dobMonth = dobMonth;
    this.dobYear = dobYear;
    this.phoneNo = phoneNo;
    this.imgUrl = imgUrl;
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
    imgUrl: '',
  );

  UserData get userData => _userData;
}