import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  static Future<bool> checkUserExist({
    required BuildContext context,
    required String email,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userList = await firestore.collection('users').get();
    if (userList.docs.any((element) => element['email'] == email.trim().toLowerCase())) { 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User account already exists'),
        ),
      );
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkPhoneExist({
    required BuildContext context,
    required String phoneNo,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userList = await firestore.collection('users').get();
    if (userList.docs.any((element) => element['phoneNoCode'] + element['phoneNo'] == phoneNo)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number already exists'),
        ),
      );
      return true;
    } else {
      print('no');
      return false;
    }
  }
}