import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_wallet/screens/account/userData.dart';

class UserTest {
  static Future<Map<String?, dynamic>> getUserData({
    required String uid,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userData = await firestore.collection('users').doc(uid).get();
    return userData.data()!;
  }
}

// userDataMap['fname']
