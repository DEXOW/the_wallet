import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:the_wallet/screens/components/global.dart';

class FireStore {
  static Future<bool> checkUserExist({
    required BuildContext context,
    required String email,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userList = await firestore.collection('users').get();
    if (context.mounted){
      if (userList.docs.any((element) => element['email'] == email.trim().toLowerCase())) { 
        SnackBarNotify.showSnackBar(context: context, message: 'Email already in use', bgcolor: Colors.red, textColor: Colors.black);
        return true;
      } else {
        return false;
      }
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
    if (context.mounted) {
      if (userList.docs.any((element) => element['phoneNoCode'] + element['phoneNo'] == phoneNo)) {
        SnackBarNotify.showSnackBar(context: context, message: 'Phone number already in use', bgcolor: Colors.red, textColor: Colors.white);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}