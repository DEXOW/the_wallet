// import 'package:flutter/material.dart';
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